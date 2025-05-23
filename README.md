# RAG-based Image Captioning App

This project combines a Flutter frontend and a FastAPI backend to create an image captioning application using Retrieval-Augmented Generation (RAG). The .zip file contains two main folders:
- `flutter_frontend/`: Contains all Dart files and `frontend.bat` for the Flutter frontend.
- `rag_pipeline/`: Contains the FastAPI backend files, including `main.py`, `requirements.txt`, and `backend.bat`.

---

## How to Run

### Prerequisites
- **Python 3.8+**: Required for the FastAPI backend.
- **Flutter SDK**: Required for the frontend. If you don't have Flutter installed, follow the setup instructions below.
- A stable internet connection for downloading dependencies.
- Access to a terminal (Command Prompt, PowerShell, or equivalent).

### Project Setup

#### 1. Update IP Address
Update the IP address (your local IPv4) in the following places:
- **Flutter Frontend**:
  - Edit `flutter_frontend/lib/home_screen.dart`.
  - Replace `apiBaseUrl` with your machine's IP address (found using `ipconfig` on Windows or `ifconfig` on Linux/Mac).
- **FastAPI Backend**:
  - Edit `rag_pipeline/backend.bat`.
  - Ensure any hardcoded IP in the `uvicorn` command is replaced with your current IPv4 address.

Find your IP address:
- Windows: Run `ipconfig` in a terminal and look under "Wireless LAN adapter Wi-Fi" for "IPv4 Address".
- Linux/Mac: Run `ifconfig` and look for the active network interface's IP.

#### 2. Set Up Flutter (If Not Installed)
If you don't have Flutter installed:
1. **Download Flutter SDK**:
   - Visit [flutter.dev](https://flutter.dev/docs/get-started/install) and download the Flutter SDK for your operating system.
   - Extract the Flutter zip file to a directory (e.g., `C:\flutter` on Windows).
2. **Add Flutter to PATH**:
   - Windows:
     - Add `C:\flutter\bin` to your system PATH (search for "Edit environment variables" in Windows).
   - Linux/Mac:
     - Add `export PATH="$PATH:/path/to/flutter/bin"` to your `~/.bashrc` or `~/.zshrc` file.
3. **Verify Installation**:
   - Run `flutter doctor` in a terminal to check for missing dependencies (e.g., Android Studio, Xcode, or Chrome for web).
   - Install any required tools as prompted by `flutter doctor`.

#### 3. Backend (FastAPI)
1. Open a terminal.
2. Navigate to `rag_pipeline/`:
   ```bash
   cd rag_pipeline
   ```
3. Create and activate a virtual environment (recommended):
   - Windows:
     ```bash
     python -m venv venv
     .\venv\Scripts\activate
     ```
   - Linux/Mac:
     ```bash
     python3 -m venv venv
     source venv/bin/activate
     ```
4. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
5. Run the backend:
   ```bash
   backend.bat
   ```
6. The API will start at `http://127.0.0.1:8000` (or your specified IP).

#### 4. Frontend (Flutter)
1. Open a new terminal.
2. Navigate to `flutter_frontend/`:
   ```bash
   cd flutter_frontend
   ```
3. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
4. Run the frontend:
   ```bash
   frontend.bat
   ```
5. This will launch the Flutter app (ensure the backend is running).

---

## Notes
- Ensure the backend is running before starting the frontend.
- If you encounter issues with Flutter, run `flutter doctor` to diagnose problems.
- For development, you may need additional tools like Android Studio (for Android) or Xcode (for iOS) if targeting mobile devices.



<!-- 
# RAG-based Image Captioning App

This project uses a Flutter frontend and a FastAPI backend.

---

## 🔧 How to Run
If you're running this project on your own machine, please update the IP address (your local IPv4) in the following places:

In the Flutter frontend:
Edit frontend/lib/home_screen.dart → replace apiBaseUrl with your machine's IP (found using ipconfig).

In the RAG_pipeline\run_backend.bat :
Ensure any hardcoded IP in uvicorn command is replaced with your current IPv4 address.

You can find your IP address by running ipconfig (Windows) or ifconfig (Linux/Mac) and looking under Wireless LAN adapter Wi-Fi.

### 📦 Backend (FastAPI)
1. Open a terminal
2. Navigate to `backend/`
3. Run: `run_backend.bat`
4. Your API will start at: `http://127.0.0.1:8000`

### 📱 Frontend (Flutter)
1. Open a terminal
2. Navigate to `flutter_frontend/`
3. Run: `run_frontend.bat`
4. This will launch the Flutter app

---

## 📝 Requirements

- Python 3.8+
- Flutter SDK installed and in PATH -->
