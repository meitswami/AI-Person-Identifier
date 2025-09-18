#!/bin/bash

echo "Starting Face Search Web App Services..."
echo

echo "[1/3] Starting Python FastAPI Service..."
cd backend
gnome-terminal --title="Face Recognition Service" -- bash -c "python run_service.py; exec bash" 2>/dev/null || \
xterm -title "Face Recognition Service" -e "python run_service.py; bash" 2>/dev/null || \
osascript -e 'tell app "Terminal" to do script "cd '$(pwd)' && python run_service.py"' 2>/dev/null || \
echo "Please start the Python service manually: cd backend && python run_service.py"
cd ..

echo "[2/3] Waiting for Python service to start..."
sleep 5

echo "[3/3] Starting PHP Web Server..."
cd frontend
gnome-terminal --title="Web Server" -- bash -c "php -S localhost:8080; exec bash" 2>/dev/null || \
xterm -title "Web Server" -e "php -S localhost:8080; bash" 2>/dev/null || \
osascript -e 'tell app "Terminal" to do script "cd '$(pwd)' && php -S localhost:8080"' 2>/dev/null || \
echo "Please start the web server manually: cd frontend && php -S localhost:8080"
cd ..

echo
echo "========================================"
echo "Services are starting up!"
echo "========================================"
echo
echo "Python FastAPI Service: http://localhost:8000"
echo "Web Application: http://localhost:8080"
echo "API Documentation: http://localhost:8000/docs"
echo

# Try to open the web application
if command -v xdg-open > /dev/null; then
    echo "Opening web application..."
    xdg-open http://localhost:8080
elif command -v open > /dev/null; then
    echo "Opening web application..."
    open http://localhost:8080
else
    echo "Please open http://localhost:8080 in your browser"
fi

echo
echo "Services are running in separate terminals."
echo "Close those terminals to stop the services."
echo
