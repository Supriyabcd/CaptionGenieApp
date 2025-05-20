@REM @echo off
@REM echo [*] Creating virtual environment...
@REM python -m venv venv

@REM echo [*] Activating virtual environment...
@REM call venv\Scripts\activate

@REM echo [*] Installing Python dependencies...
@REM pip install -r requirements.txt
@REM :: edit ip address 
@REM echo [*] Starting FastAPI server at http://192.168.88.1:8000 ...
@REM uvicorn main:app --host 192.168.88.1 --port 8000 --reload

@echo off
cd /d %~dp0

echo [*] Creating virtual environment...
python -m venv venv

echo [*] Activating virtual environment...
call venv\Scripts\activate

echo [*] Installing Python dependencies...
pip install -r requirements.txt

echo [*] Installing extra libraries (sentencepiece + spacy model)...
pip install sentencepiece
pip install python-multipart
python -m spacy download en_core_web_sm

echo [*] Starting FastAPI server at http://192.168.213.109:8000 ...
uvicorn main:app --host  192.168.213.109 --port 8000 --reload

