@echo off
echo Starting Face Search Web App Services...
echo.

echo [1/3] Starting Python FastAPI Service...
cd backend
start "Face Recognition Service" cmd /k "python run_service.py"
cd ..

echo [2/3] Waiting for Python service to start...
timeout /t 5 /nobreak > nul

echo [3/3] Starting PHP Web Server...
cd frontend
start "Web Server" cmd /k "php -S localhost:8080"
cd ..

echo.
echo ========================================
echo Services are starting up!
echo ========================================
echo.
echo Python FastAPI Service: http://localhost:8000
echo Web Application: http://localhost:8080
echo API Documentation: http://localhost:8000/docs
echo.
echo Press any key to open the web application...
pause > nul

start http://localhost:8080

echo.
echo Services are running in separate windows.
echo Close those windows to stop the services.
echo.
pause
