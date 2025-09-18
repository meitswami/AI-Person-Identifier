#!/usr/bin/env python3
"""
Startup script for the Face Search Web App
Starts both the FastAPI backend and the web server
"""

import subprocess
import time
import sys
import os
from pathlib import Path

def start_backend():
    """Start the FastAPI backend service"""
    print("🚀 Starting Face Recognition Backend...")
    backend_dir = Path(__file__).parent / "backend"
    
    # Use the virtual environment Python
    if os.name == 'nt':  # Windows
        python_path = backend_dir / "venv" / "Scripts" / "python.exe"
    else:  # Unix/Linux/Mac
        python_path = backend_dir / "venv" / "bin" / "python"
    
    # Start the backend service
    backend_process = subprocess.Popen([
        str(python_path), "simple_face_service.py"
    ], cwd=backend_dir)
    
    print("✅ Backend service started on http://localhost:8000")
    return backend_process

def start_web_server():
    """Start the web server"""
    print("🌐 Starting Web Server...")
    backend_dir = Path(__file__).parent / "backend"
    
    # Use the virtual environment Python
    if os.name == 'nt':  # Windows
        python_path = backend_dir / "venv" / "Scripts" / "python.exe"
    else:  # Unix/Linux/Mac
        python_path = backend_dir / "venv" / "bin" / "python"
    
    # Start the web server
    web_process = subprocess.Popen([
        str(python_path), "simple_upload_handler.py", "8080"
    ], cwd=backend_dir)
    
    print("✅ Web server started on http://192.168.0.135:8080")
    print("📱 Mobile access: http://192.168.0.135:8080")
    return web_process

def main():
    """Main function to start both services"""
    print("=" * 50)
    print("🎯 Face Search Web App Startup")
    print("=" * 50)
    
    try:
        # Start backend service
        backend_process = start_backend()
        
        # Wait a moment for backend to start
        print("⏳ Waiting for backend to initialize...")
        time.sleep(3)
        
        # Start web server
        web_process = start_web_server()
        
        print("\n" + "=" * 50)
        print("🎉 Face Search Web App is running!")
        print("=" * 50)
        print("💻 Local Web Interface: http://localhost:8080")
        print("📱 Mobile Web Interface: http://192.168.0.135:8080")
        print("🔧 API Documentation: http://localhost:8000/docs")
        print("📊 API Health Check: http://localhost:8000")
        print("\n📱 Access from your mobile: http://192.168.0.135:8080")
        print("Press Ctrl+C to stop both services")
        print("=" * 50)
        
        # Wait for user to stop
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("\n🛑 Stopping services...")
            
    except Exception as e:
        print(f"❌ Error starting services: {e}")
        sys.exit(1)
    
    finally:
        # Clean up processes
        try:
            if 'backend_process' in locals():
                backend_process.terminate()
            if 'web_process' in locals():
                web_process.terminate()
            print("✅ Services stopped successfully")
        except:
            pass

if __name__ == "__main__":
    main()
