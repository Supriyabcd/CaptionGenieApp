from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.core.files.storage import default_storage
import requests
from dotenv import load_dotenv
import os

load_dotenv()  # Load environment variables from .env file 

# Hugging Face API URL and Token
HUGGING_FACE_API_URL = "https://api-inference.huggingface.co/models/Salesforce/blip-image-captioning-base"
HUGGINGFACE_TOKEN = os.getenv("")

# Define HEADERS using the token from .env
HEADERS = {
    "Authorization": f"Bearer {HUGGINGFACE_TOKEN}"
}

@api_view(["POST"])
def generate_caption(request):
    if "image" not in request.FILES:
        return Response({"error": "No image provided"}, status=400)

    # Save image temporarily
    image = request.FILES["image"]
    file_name = default_storage.save(image.name, image)

    # Read image and send to Hugging Face model
    with default_storage.open(file_name, "rb") as img_file:
        response = requests.post(
            HUGGING_FACE_API_URL,
            headers=HEADERS,
            files={"file": img_file}
        )

    # Delete image after processing
    default_storage.delete(file_name)

    if response.status_code == 200:
        result = response.json()
        # Hugging Face API returns a list with a 'generated_text' field
        caption = result[0].get("generated_text", "No caption returned")
        return Response({"caption": caption})
    else:
        return Response({"error": "Failed to generate caption"}, status=500)
