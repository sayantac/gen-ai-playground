# Gen AI Playground

Welcome to the Gen AI Playground! This repository contains examples and experiments with various generative AI frameworks and tools including OpenAI, LangChain, LlamaIndex, Semantic Kernel, and more.

## 🚀 Setup

This project uses a Python virtual environment for dependency management. Dev containers have been removed in favor of local virtual environment setup.

### Quick Start

1. **Set up the virtual environment:**
   ```bash
   ./scripts/setup_venv.sh
   ```

2. **Set up with latest package versions:**
   ```bash
   ./scripts/setup_venv.sh --update-requirements
   ```

3. **Force recreate environment:**
   ```bash
   ./scripts/setup_venv.sh --force
   ```

4. **Activate the virtual environment:**
   ```bash
   source venv/bin/activate
   ```
   
   Or use the convenience script:
   ```bash
   source scripts/activate_venv.sh
   ```

5. **Deactivate when done:**
   ```bash
   deactivate
   ```

### Setup Script Options

- `--update-requirements`: Check for and update to latest package versions before creating environment
- `--force`: Force recreate virtual environment even if it already exists
- `--help`: Show help message with all options

### Manual Setup

If you prefer to set up manually:

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate  # Linux/macOS
# or
venv\Scripts\activate     # Windows

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt
```

### Special Installation Notes

For `pygraphviz` on macOS, you may need to install it with specific configuration:

```bash
pip install -U --no-cache-dir  \
            --config-settings="--global-option=build_ext" \
            --config-settings="--global-option=-I$(brew --prefix graphviz)/include/" \
            --config-settings="--global-option=-L$(brew --prefix graphviz)/lib/" \
            pygraphviz
```

Make sure you have graphviz installed: `brew install graphviz`

## 📁 Project Structure

- `notebooks/` - Jupyter notebooks organized by framework
  - `langchain/` - LangChain examples (RAG, Agents, Tools, etc.)
  - `llamaindex/` - LlamaIndex examples
  - `openai/` - OpenAI API examples
  - `samples/` - General sample notebooks
  - `agentic-workflow/` - Agentic workflow examples
- `src/` - Python source code examples
  - `langchain/` - LangChain scripts
  - `openai/` - OpenAI scripts
  - `semantic_kernel/` - Semantic Kernel examples
- `data/` - Sample datasets and files (organized by type)
  - `structured/` - CSV and tabular data files
  - `unstructured/` - Documents, audio, images, etc.
    - `documents/` - PDF and text files
    - `audio/` - Audio files for speech processing
    - `images/` - Image files
    - `notion/` - Notion database exports
    - `youtube/` - Downloaded YouTube content
  - `generated/` - Runtime-generated data (gitignored)
  - See `data/README.md` for detailed file listing
- `scripts/` - Setup and utility scripts
- `requirements.txt` - Python dependencies