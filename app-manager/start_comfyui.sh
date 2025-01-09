#!/usr/bin/env bash
export PYTHONUNBUFFERED=1

# Start ComfyUI
cd /workspace/ComfyUI
source venv/bin/activate
echo "COMFYUI: Starting ComfyUI"
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"
venv/bin/python3 main.py --listen 0.0.0.0 --port 3001 > /workspace/logs/comfyui.log 2>&1 &
echo "COMFYUI: ComfyUI Started"
deactivate

# Start OmniGen
cd /OmniGen
source /omnigen-venv/bin/activate
echo "OMNIGEN: Starting OmniGen on port 4001"
# omnigen-venv/bin/python app.py --share --server_port=4001 > /workspace/logs/omnigen.log 2>&1 &
omnigen-venv/bin/python app.py --listen 0.0.0.0 --port 4001 > /workspace/logs/omnigen.log 2>&1 &
echo "OMNIGEN: OmniGen Started"
deactivate
