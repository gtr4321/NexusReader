#!/bin/bash
set -e

echo "🚀 Initializing NexusReader Environment..."

# 1. Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 could not be found."
    exit 1
fi

# 2. Setup Backend
echo "📦 Setting up Python Virtual Environment..."
cd core
if [ ! -d ".venv" ]; then
    echo "   Creating .venv..."
    python3 -m venv .venv
else
    echo "   .venv exists."
fi

# Activate and install
source .venv/bin/activate
echo "📥 Installing backend dependencies..."
pip install -r requirements.txt
echo "✅ Backend dependencies installed."
cd ..

# 3. Setup Frontend
echo "📦 Setting up Frontend..."
if [ -d "renderer" ]; then
    cd renderer
    if [ ! -d "node_modules" ]; then
        echo "📥 Installing frontend dependencies (this may take a while)..."
        npm install
    else
        echo "ℹ️  node_modules exists. ensuring types are installed..."
        npm install @types/react @types/react-dom --save-dev
    fi
    cd ..
fi

echo "==========================================="
echo "✅ Environment Setup Complete!"
echo "==========================================="
echo "To start the application:"
echo "1. Backend: python3 run.py"
echo "2. Frontend: cd renderer && npm run dev"
echo "==========================================="
