from django.urls import path, include

urlpatterns = [
    path("caption_genie/", include("caption_genie.urls")),
]
