from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
import faiss
import json
import numpy as np
from PIL import Image
import io
import torch
from transformers import CLIPProcessor, CLIPModel, T5Tokenizer, T5ForConditionalGeneration
from sentence_transformers import SentenceTransformer
import spacy
import logging

# Initialize FastAPI app
app = FastAPI()

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load models and data
try:
    # Paths to FAISS index and captions
    FAISS_INDEX_PATH = "faiss_index_train.idx"
    CAPTIONS_PATH = "captions_train.json"

    # Load CLIP model
    clip_model = CLIPModel.from_pretrained("openai/clip-vit-base-patch32")
    clip_processor = CLIPProcessor.from_pretrained("openai/clip-vit-base-patch32")
    logger.info("CLIP model loaded successfully")

    # Load SentenceTransformer
    text_encoder = SentenceTransformer('all-MiniLM-L6-v2')
    logger.info("SentenceTransformer loaded successfully")

    # Load T5 model
    tokenizer = T5Tokenizer.from_pretrained("t5-small")
    generator = T5ForConditionalGeneration.from_pretrained("t5-small")
    logger.info("T5 model loaded successfully")

    # Load spaCy
    nlp = spacy.load("en_core_web_sm")
    logger.info("spaCy model loaded successfully")

    # Load FAISS index
    faiss_index = faiss.read_index(FAISS_INDEX_PATH)
    logger.info("FAISS index loaded successfully")

    # Load captions
    with open(CAPTIONS_PATH, "r", encoding="utf-8") as f:
        captions = json.load(f)
    logger.info(f"Loaded {len(captions)} captions")

except Exception as e:
    logger.error(f"Failed to initialize models or data: {e}")
    raise

def extract_image_features(image: Image.Image):
    try:
        image = image.convert("RGB")
        inputs = clip_processor(images=image, return_tensors="pt")
        with torch.no_grad():
            features = clip_model.get_image_features(**inputs)
        features = torch.nn.functional.normalize(features, p=2, dim=-1)
        return features.squeeze(0).cpu().numpy().astype("float32")
    except Exception as e:
        logger.error(f"Error extracting image features: {e}")
        return None

def retrieve_similar_captions(image_embedding, k=5):
    if image_embedding.ndim == 1:
        image_embedding = image_embedding.reshape(1, -1)

    assert image_embedding.shape[1] == faiss_index.d, "Embedding dimension mismatch!"
    D, I = faiss_index.search(image_embedding, k)
    return [captions[i] for i in I[0]]

def extract_location_names(texts):
    names = []
    for text in texts:
        doc = nlp(text)
        for ent in doc.ents:
            if ent.label_ in ["GPE", "LOC", "FAC"]:
                names.append(ent.text)
    return list(set(names))

def generate_caption_from_retrieved(retrieved_captions):
    locations = extract_location_names(retrieved_captions)
    location_hint = f"The place might be: {', '.join(locations)}. " if locations else ""
    prompt = location_hint + " ".join(retrieved_captions) + " Generate a caption with the landmark name:"

    inputs = tokenizer(prompt, return_tensors="pt", truncation=True)
    outputs = generator.generate(
        input_ids=inputs.input_ids,
        attention_mask=inputs.attention_mask,
        max_length=3000,
        num_beams=5,
        early_stopping=True
    )
    return tokenizer.decode(outputs[0], skip_special_tokens=True)

@app.post("/generate_caption")
async def generate_caption(file: UploadFile = File(...)):
    try:
        # Read and process the image
        contents = await file.read()
        image = Image.open(io.BytesIO(contents))
        
        # Extract image features
        embedding = extract_image_features(image)
        if embedding is None:
            raise HTTPException(status_code=500, detail="Failed to process image")

        # Retrieve similar captions
        retrieved = retrieve_similar_captions(embedding, k=5)
        if not retrieved:
            raise HTTPException(status_code=404, detail="No similar captions found")

        # Generate final caption
        caption = generate_caption_from_retrieved(retrieved)
        return JSONResponse(content={"caption": caption})

    except Exception as e:
        logger.error(f"Error in generate_caption: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/")
async def root():
    return {"message": "FastAPI RAG Caption Generator"}