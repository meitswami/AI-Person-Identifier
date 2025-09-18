@echo off
echo Starting Face Search Web App for Mobile Access...
echo.

echo [1/2] Starting Python FastAPI Backend...
cd backend
start "Face Recognition Service" cmd /k "venv\Scripts\python simple_face_service.py"
cd ..

echo [2/2] Waiting for backend to start...
timeout /t 5 /nobreak > nul

echo [3/3] Starting Web Server for Mobile Access...
cd backend
start "Web Server" cmd /k "venv\Scripts\python upload_handler.py"
cd ..

echo.
echo ========================================
echo Face Search Web App is starting!
echo ========================================
echo.
echo 💻 Local Access: http://localhost:8080
echo 📱 Mobile Access: http://192.168.0.135:8080
echo 🔧 API Docs: http://localhost:8000/docs
echo.
echo 📱 Open this URL on your mobile device:
echo    http://192.168.0.135:8080
echo.
echo Services are running in separate windows.
echo Close those windows to stop the services.
echo.
pause
