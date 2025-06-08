# RAG-based Image Captioning App

This project combines a Flutter frontend and a FastAPI backend to create an image captioning application using Retrieval-Augmented Generation (RAG). The app's purpose is to provide architectural and historical details for an input image of the facade of an Indian Monument. The repository contains two main folders:
- `flutter_frontend/`: Contains all Dart files and `run_frontend.bat` for the Flutter frontend.
- `rag_pipeline/`: Contains the FastAPI backend files, including `main.py`, `requirements.txt`, and `run_backend.bat`.

---

## How to Run

### Prerequisites
- **Python 3.8+**: Required for the FastAPI backend.
- **Flutter SDK**: Required for the frontend. If you don't have Flutter installed, follow the setup instructions below.
- A stable internet connection for downloading dependencies.
- Access to a terminal (Command Prompt, PowerShell, or equivalent).
- An Android/iOS phone on the same LAN connection as the laptop running the `.bat` files (for physical device testing).
- Android Studio (for Android emulator or physical device testing) or Xcode (for iOS physical device testing).

### Project Setup

#### 1. Update IP Address
Update the IP address (your local IPv4) in the following places:
- **Flutter Frontend**:
  - Edit `flutter_frontend/lib/home_screen.dart`.
  - Replace `apiBaseUrl` with your machine's IP address (found using `ipconfig` on Windows or `ifconfig` on Linux/Mac).
- **FastAPI Backend**:
  - Edit `rag_pipeline/run_backend.bat`.
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
4. Install backend dependencies:
   ```bash
   pip install -r requirements.txt
   ```
5. Run the backend:
   ```bash
   run_backend.bat
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
   run_frontend.bat
   ```
5. This will launch the Flutter app (ensure the backend is running). Follow the steps below to run on a physical device or emulator.

### Running on a Physical Phone via USB
1. **Enable Developer Mode on Your Phone**:
   - **Android**:
     - Go to **Settings > About Phone**.
     - Tap **Build Number** 7 times to enable Developer Options.
     - Go to **Settings > Developer Options** and enable **USB Debugging**.
   - **iOS**:
     - No developer mode is needed, but ensure the phone is trusted when connected to the computer (you’ll be prompted on the phone).
2. **Connect the Phone to Your Computer**:
   - Use a USB cable to connect your phone to the computer running the `.bat` files.
   - Ensure the phone is on the same LAN as the computer (for API communication).
3. **Verify Device Detection**:
   - Run `flutter devices` in the terminal to confirm your phone is detected.
   - If not detected, ensure USB Debugging is enabled and the correct drivers are installed (e.g., Google USB Driver for Android).
4. **Run the Frontend**:
   - In the `flutter_frontend/` directory, run `run_frontend.bat`.
   - The Flutter app will build and install on your phone automatically.
   - Ensure the backend is running (`run_backend.bat` in a separate terminal) before launching the app.

### Running on an Android Studio Emulator
1. **Set Up Android Studio**:
   - Download and install **Android Studio** from [developer.android.com](https://developer.android.com/studio).
   - During setup, ensure the **Android Virtual Device (AVD)** component is installed.
2. **Create a Virtual Device**:
   - Open Android Studio and go to **Tools > Device Manager**.
   - Click **Create Virtual Device**, select a device (e.g., Pixel 6), and choose a system image (e.g., Android 12 or higher).
   - Download the system image if prompted, then finish creating the AVD.
3. **Start the Emulator**:
   - In the **Device Manager**, select your virtual device and click the **Play** button to launch the emulator.
   - Wait for the emulator to fully boot up.
4. **Verify Emulator Detection**:
   - Run `flutter devices` in the terminal to confirm the emulator is detected.
5. **Run the Frontend**:
   - Navigate to `flutter_frontend/` in a terminal:
     ```bash
     cd flutter_frontend
     ```
   - Ensure dependencies are installed:
     ```bash
     flutter pub get
     ```
   - Run `run_frontend.bat` to build and install the app on the emulator.
   - Ensure the backend is running (`run_backend.bat` in a separate terminal) before launching the app.
6. **Configure Emulator Networking**:
   - The emulator uses `10.0.2.2` to access the host machine’s localhost. If the backend is running on `127.0.0.1:8000`, update `flutter_frontend/lib/home_screen.dart` to use `http://10.0.2.2:8000` instead of the local IP for emulator testing.

---

## Notes
- **Two Terminals**: Always run `run_backend.bat` and `run_frontend.bat` in separate terminals to avoid conflicts. For example:
  - Terminal 1: `cd rag_pipeline && run_backend.bat`
  - Terminal 2: `cd flutter_frontend && run_frontend.bat`
- **Network Considerations**:
  - For a physical phone, ensure both the phone and computer are on the same Wi-Fi network for API calls.
  - For the emulator, use `10.0.2.2` for localhost access as mentioned above.
- **Troubleshooting**:
  - If the app fails to connect to the backend, verify the IP address in `home_screen.dart` matches the backend’s IP (or `10.0.2.2` for emulators).
  - If the emulator is slow, ensure your computer has sufficient resources (e.g., enable hardware acceleration like HAXM or Hypervisor Framework).
  - Run `flutter doctor` to check for missing dependencies or misconfigurations.
- **Development Tools**:
  - For Android development, Android Studio is recommended for managing emulators and debugging.
  - For iOS development, Xcode is required for physical iOS devices (macOS only).
- **Dependencies**: Ensure all dependencies in `requirements.txt` (backend) and `pubspec.yaml` (frontend) are installed correctly.
