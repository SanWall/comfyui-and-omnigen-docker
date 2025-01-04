#!/usr/bin/env bash

ARGS=("$@" --listen 0.0.0.0 --port 3001)

export PYTHONUNBUFFERED=1

# Start ComfyUI
echo "Starting ComfyUI"
cd /workspace/ComfyUI
source venv/bin/activate
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"
venv/bin/python3 main.py "${ARGS[@]}" > /workspace/logs/comfyui.log 2>&1 &
echo "ComfyUI started"
echo "Log file: /workspace/logs/comfyui.log"
deactivate

# Start OmniGen
echo "Starting OmniGen on port 4001"
cd /OmniGen
source /omnigen-venv/bin/activate
omnigen-venv/bin/python app.py --share --server_port=4001 > /workspace/logs/omnigen.log 2>&1 &
echo "OmniGen started on port 4001"
echo "OmniGen log file: /workspace/logs/omnigen.log"
deactivate