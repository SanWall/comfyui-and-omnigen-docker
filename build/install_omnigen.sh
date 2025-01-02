#!/usr/bin/env bash
set -e

# Clone the OmniGen repository
git clone https://github.com/VectorSpaceLab/OmniGen /OmniGen
cd /OmniGen

# Create and activate the virtual environment
python3 -m venv omnigen-venv
source omnigen-venv/bin/activate

# Install OmniGen and its dependencies
/omnigen-venv/bin/pip3 install -e .
/omnigen-venv/bin/pip3 install torch==2.3.1+cu118 torchvision --extra-index-url https://download.pytorch.org/whl/cu118
/omnigen-venv/bin/pip3 install gradio spaces
/omnigen-venv/bin/pip3 install -r requirements.txt

# Deactivate the virtual environment
deactivate
