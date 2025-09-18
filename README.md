# Face Search Web App

A web application that allows users to take a selfie and instantly find all their photos (solo or group) where the same face appears with high accuracy. Similar to [Memzo.ai](https://memzo.ai/).

## 🚀 Features

- **Real-time Face Capture**: Take selfies using your device's camera
- **High-Accuracy Face Recognition**: Uses DeepFace with ArcFace model for state-of-the-art accuracy
- **Fast Vector Search**: FAISS-powered similarity search for instant results
- **Group Photo Support**: Detects and matches faces in group photos
- **Bulk Indexing**: Admin tools to index multiple photos at once
- **Modern UI**: Clean Bootstrap-based interface with drag-and-drop support

## 🏗️ Architecture

```
Frontend (HTML/JS) → PHP Layer → Python FastAPI → DeepFace + FAISS
```

- **Frontend**: HTML + JavaScript with Bootstrap UI
- **PHP Layer**: File upload handling and service communication
- **Backend**: Python FastAPI with DeepFace and FAISS for face recognition
- **Storage**: Local disk for images, FAISS index for embeddings

## 📁 Project Structure

```
project/
├── frontend/
│   └── index.html          # Main web interface
├── php/
│   ├── upload.php          # Handle selfie uploads and face search
│   └── index.php           # Handle bulk image indexing
├── backend/
│   ├── face_service.py     # FastAPI service with DeepFace + FAISS
│   ├── requirements.txt    # Python dependencies
│   ├── run_service.py      # Service startup script
│   └── test_service.py     # Test suite
├── uploads/
│   └── indexed/           # Indexed photos storage
├── data/                  # FAISS index and metadata (auto-created)
└── README.md
```

## 🛠️ Installation & Setup

### Prerequisites

- **Python 3.8+** with pip
- **PHP 7.4+** with curl extension
- **Web server** (Apache/Nginx) or PHP built-in server
- **Camera access** for selfie functionality

### 1. Clone and Setup

```bash
git clone <your-repo-url>
cd AiPersonIdentifier
```

### 2. Python Backend Setup

```bash
# Navigate to backend directory
cd backend

# Create virtual environment (recommended)
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Download DeepFace models (first run will download models)
python -c "from deepface import DeepFace; DeepFace.represent('test.jpg', model_name='ArcFace')"
```

### 3. Start the Python Service

```bash
# From the backend directory
python run_service.py
```

The service will start on `http://localhost:8000`

### 4. Start the Web Server

#### Option A: PHP Built-in Server (Development)
```bash
# From project root
php -S localhost:8080 -t frontend
```

#### Option B: Apache/Nginx (Production)
- Point document root to the `frontend/` directory
- Ensure PHP can access the `php/` directory
- Configure proper permissions for `uploads/` directory

### 5. Access the Application

Open your browser and go to:
- **Main App**: `http://localhost:8080` (or your web server URL)
- **API Docs**: `http://localhost:8000/docs` (FastAPI documentation)

## 🎯 Usage

### For End Users

1. **Take a Selfie**: Click "Start Camera" and capture your photo
2. **Upload Photo**: Alternatively, drag and drop or select a photo file
3. **View Results**: See all matching photos with similarity scores
4. **Browse Matches**: Click on results to view full-size images

### For Administrators

1. **Index Photos**: Use the admin section to upload multiple photos
2. **Bulk Processing**: Select multiple images to index at once
3. **Monitor Stats**: Check the service stats via API or logs

## 🔧 Configuration

### Face Recognition Settings

Edit `backend/face_service.py` to modify:

```python
CONFIG = {
    "model_name": "ArcFace",           # Face recognition model
    "detector_backend": "opencv",      # Face detection backend
    "distance_metric": "cosine",       # Similarity metric
    "similarity_threshold": 0.6,       # Matching threshold (0-1)
    "max_faces_per_image": 10,         # Max faces to process per image
    "embedding_dim": 512,              # Embedding vector dimension
}
```

### Model Options

**Face Recognition Models:**
- `ArcFace` (recommended) - Best accuracy
- `Facenet` - Good balance of speed/accuracy
- `VGG-Face` - Fast but less accurate
- `DeepFace` - Good for general use

**Face Detection Backends:**
- `opencv` (default) - Fast, good for most cases
- `retinaface` - More accurate, slower
- `mtcnn` - Good accuracy, moderate speed

## 🧪 Testing

### Run the Test Suite

```bash
cd backend
python test_service.py
```

### Manual Testing

1. **Health Check**: Visit `http://localhost:8000/`
2. **API Documentation**: Visit `http://localhost:8000/docs`
3. **Upload Test Images**: Use the admin interface to index sample photos
4. **Search Test**: Take a selfie or upload a test image

## 📊 Performance

### Accuracy
- **ArcFace Model**: ~99% accuracy on standard benchmarks
- **Similarity Threshold**: 0.6 provides good balance of precision/recall
- **Group Photos**: Supports multiple faces per image

### Speed
- **Indexing**: ~2-5 seconds per image (depending on faces detected)
- **Search**: ~100-500ms for similarity search
- **Memory**: ~50MB base + ~1KB per indexed face

## 🚀 Scaling & Production

### Database Options
- **Current**: FAISS (local file-based)
- **Upgrade to**: Milvus, pgvector, or Elasticsearch for distributed storage

### GPU Acceleration
```bash
# Install GPU version of FAISS
pip install faiss-gpu

# Install TensorFlow GPU
pip install tensorflow-gpu
```

### Docker Deployment
```dockerfile
# Example Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY backend/requirements.txt .
RUN pip install -r requirements.txt
COPY backend/ .
EXPOSE 8000
CMD ["python", "run_service.py"]
```

### Security Considerations
- Add authentication/authorization
- Implement rate limiting
- Use HTTPS in production
- Validate file uploads more strictly
- Add liveness detection to prevent spoofing

## 🔍 API Endpoints

### Face Search
```http
POST /face_search
Content-Type: application/json

{
  "image_path": "/path/to/selfie.jpg"
}
```

### Index Image
```http
POST /index_image
Content-Type: application/json

{
  "image_path": "/path/to/photo.jpg",
  "filename": "photo.jpg"
}
```

### Get Statistics
```http
GET /stats
```

## 🐛 Troubleshooting

### Common Issues

**1. "No module named 'deepface'"**
```bash
pip install deepface
```

**2. "Cannot connect to service"**
- Ensure Python service is running on port 8000
- Check firewall settings
- Verify PHP curl extension is installed

**3. "No faces detected"**
- Try different photos with clear faces
- Adjust `similarity_threshold` in config
- Check if face detection backend is working

**4. "Permission denied" errors**
```bash
chmod 755 uploads/
chmod 755 data/
```

**5. Slow performance**
- Use GPU acceleration for FAISS
- Reduce image sizes before indexing
- Use faster face detection backend

### Logs
- **Python Service**: Check console output
- **PHP Errors**: Check web server error logs
- **Browser**: Check browser developer console

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [DeepFace](https://github.com/serengil/deepface) for face recognition
- [FAISS](https://github.com/facebookresearch/faiss) for vector similarity search
- [FastAPI](https://fastapi.tiangolo.com/) for the web framework
- [Bootstrap](https://getbootstrap.com/) for the UI framework

## 🔮 Future Enhancements

- [ ] Real-time video face detection
- [ ] Face clustering and grouping
- [ ] Advanced filtering options
- [ ] Mobile app development
- [ ] Cloud storage integration
- [ ] Multi-user support
- [ ] Face aging simulation
- [ ] Duplicate photo detection
- [ ] Privacy controls and data encryption
- [ ] Batch processing API

---

**Ready to find your photos? Start the services and take your first selfie! 📸**
