#!/usr/bin/env bash

# Stop ComfyUI
echo "COMFYUI: Stopping ComfyUI on port 3001"
fuser -k 3001/tcp
echo "COMFYUI: ComfyUI Stopped"

# Stop OmniGen
echo "OMNIGEN: Stopping OmniGen on port 4000"
fuser -k 4001/tcp
echo "OMNIGEN: OmniGen Stopped"
