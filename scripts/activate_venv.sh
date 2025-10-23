#!/bin/bash

# Quick activation script for the virtual environment
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Please run ./setup_venv.sh first."
    exit 1
fi

echo "🔄 Activating virtual environment..."
source venv/bin/activate
echo "✅ Virtual environment activated!"
echo "📝 Run 'deactivate' to exit the virtual environment."