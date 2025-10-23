#!/bin/bash

# Gen AI Playground - Virtual Environment Setup Script
echo "🚀 Setting up virtual environment for Gen AI Playground..."

# Parse command line arguments
UPDATE_REQUIREMENTS=false
FORCE_RECREATE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --update-requirements)
            UPDATE_REQUIREMENTS=true
            shift
            ;;
        --force)
            FORCE_RECREATE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  --update-requirements    Check for and update to latest package versions"
            echo "  --force                  Force recreate virtual environment even if it exists"
            echo "  -h, --help              Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed. Please install Python 3 first."
    exit 1
fi

# Check Python version (should be 3.8 or higher for compatibility with requirements)
python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "📍 Using Python version: $python_version"

# Check if we should update requirements
if [ "$UPDATE_REQUIREMENTS" = true ]; then
    echo "🔍 Checking for package updates..."
    
    # Backup current requirements
    if [ -f "requirements.txt" ]; then
        cp requirements.txt requirements.txt.bak
        echo "💾 Backed up current requirements to requirements.txt.bak"
    fi
    
    # Create temporary virtual environment for checking latest versions
    echo "📦 Creating temporary environment for version checking..."
    python3 -m venv temp_venv
    source temp_venv/bin/activate
    pip install --upgrade pip pip-tools
    
    # Create requirements.in from current requirements.txt
    sed 's/>=.*$//' requirements.txt | sed 's/==.*$//' > requirements.in
    
    echo "🔄 Compiling latest versions..."
    pip-compile --upgrade requirements.in
    
    # Clean up temporary environment and files
    deactivate
    rm -rf temp_venv requirements.in
    
    echo "📊 Requirements updated to latest versions!"
fi

# Create virtual environment
if [ -d "venv" ]; then
    if [ "$FORCE_RECREATE" = true ]; then
        echo "🔄 Force recreating virtual environment..."
        rm -rf venv
    else
        echo "⚠️  Virtual environment already exists. Use --force to recreate or activate with: source venv/bin/activate"
        echo "💡 To update packages in existing environment, run: pip install --upgrade -r requirements.txt"
        exit 0
    fi
fi

echo "📦 Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "🔄 Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "📋 Installing requirements from requirements.txt..."
pip install -r requirements.txt

# Handle pygraphviz installation on macOS with Homebrew
if [[ "$OSTYPE" == "darwin"* ]] && command -v brew &> /dev/null; then
    echo "🔍 Checking pygraphviz installation on macOS..."
    
    # Check if pygraphviz import fails
    if ! python -c "import pygraphviz" &> /dev/null; then
        echo "⚠️  pygraphviz failed to install. Attempting fix for macOS with Homebrew..."
        
        # Check if graphviz is installed via Homebrew
        if ! brew list graphviz &> /dev/null; then
            echo "📦 Installing graphviz via Homebrew..."
            brew install graphviz
        fi
        
        echo "🔧 Reinstalling pygraphviz with proper include/library paths..."
        pip uninstall -y pygraphviz
        pip install pygraphviz \
            --config-settings="--build-option=build_ext" \
            --config-settings="--build-option=--include-dirs=/opt/homebrew/include" \
            --config-settings="--build-option=--library-dirs=/opt/homebrew/lib"
        
        # Verify installation
        if python -c "import pygraphviz" &> /dev/null; then
            echo "✅ pygraphviz successfully installed and working!"
        else
            echo "⚠️  pygraphviz installation still has issues. You may need to install graphviz manually."
        fi
    else
        echo "✅ pygraphviz is already working correctly!"
    fi
fi

echo "✅ Virtual environment setup complete!"
echo ""
echo "To activate the virtual environment in the future, run:"
echo "    source venv/bin/activate"
echo ""
echo "To deactivate the virtual environment, run:"
echo "    deactivate"
echo ""
echo "📝 Note: The virtual environment is located in ./venv and is ignored by git."
echo ""
if [ "$UPDATE_REQUIREMENTS" = true ]; then
    echo "🔄 Requirements were updated. Check requirements.txt.bak to see what changed."
fi