from transformers import AutoModel, AutoProcessor
from PIL import Image
import torch

# Load the model and processor from Hugging Face
model_name = "Salesforce/blip-image-captioning-base"
model = AutoModel.from_pretrained(model_name, trust_remote_code=True)
processor = AutoProcessor.from_pretrained(model_name)

def predict_image(image_path):
    image = Image.open(image_path).convert("RGB")
    inputs = processor(images=image, return_tensors="pt")
    
    with torch.no_grad():
        outputs = model(**inputs)
    
    logits = outputs.logits
    predicted_label = torch.argmax(logits, dim=-1).item()
    
    return {"label": predicted_label}
