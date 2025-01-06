#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Go to correct directory
cd /ComfyUI

# === Configuration ===

# Base URL for Hugging Face repository
BASE_URL="https://huggingface.co/Aitrepreneur/FLX/resolve/main"

# === Pre-Execution Checks ===

# Check if curl is installed
if ! command -v curl &> /dev/null
then
    echo "[ERROR] curl is not installed. Please install curl and rerun the script."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "[ERROR] git is not installed. Installing git..."
    # For Debian/Ubuntu-based systems
    sudo apt-get update
    sudo apt-get install -y git
    echo "[SUCCESS] git installed successfully."
fi

# === Start of Script ===

# === Models Directory ===
echo "[INFO] Setting up models directory..."
mkdir -p models
cd models

# --- UNET Directory ---
echo "[INFO] Setting up unet directory..."
mkdir -p unet
cd unet

echo "[INFO] Downloading flux1-dev-fp8.safetensors..."
curl -L -o "flux1-dev-fp8.safetensors" "$BASE_URL/flux1-dev-fp8.safetensors?download=true"

echo "[INFO] Downloading flux1-dev-Q8_0.gguf (Best Model)..."
curl -L -o "flux1-dev-Q8_0.gguf" "$BASE_URL/flux1-dev-Q8_0.gguf?download=true"

echo "[INFO] Downloading flux1-schnell-Q8_0.gguf (Schnell Model)..."
curl -L -o "flux1-schnell-Q8_0.gguf" "$BASE_URL/flux1-schnell-Q8_0.gguf?download=true"

# Navigate back to models directory
cd ..

# --- VAE Directory ---
echo "[INFO] Setting up vae directory..."
mkdir -p vae
cd vae

echo "[INFO] Downloading ae.safetensors..."
curl -L -o "ae.safetensors" "$BASE_URL/ae.safetensors?download=true"

echo "[INFO] Downloading ae.sft..."
curl -L -o "ae.sft" "$BASE_URL/ae.sft?download=true"

# Navigate back to models directory
cd ..

# --- CLIP Directory ---
echo "[INFO] Setting up clip directory..."
mkdir -p clip
cd clip

echo "[INFO] Downloading t5xxl_fp16.safetensors..."
curl -L -o "t5xxl_fp16.safetensors" "$BASE_URL/t5xxl_fp16.safetensors?download=true"

echo "[INFO] Downloading t5xxl_fp8_e4m3fn.safetensors..."
curl -L -o "t5xxl_fp8_e4m3fn.safetensors" "$BASE_URL/t5xxl_fp8_e4m3fn.safetensors?download=true"

echo "[INFO] Downloading ViT-L-14-TEXT-detail-improved-hiT-GmP-TE-only-HF.safetensors..."
curl -L -o "ViT-L-14-TEXT-detail-improved-hiT-GmP-TE-only-HF.safetensors" "$BASE_URL/ViT-L-14-TEXT-detail-improved-hiT-GmP-TE-only-HF.safetensors?download=true"

echo "[INFO] Downloading clip_l.safetensors..."
curl -L -o "clip_l.safetensors" "$BASE_URL/clip_l.safetensors?download=true"

echo "[INFO] Downloading t5-v1_1-xxl-encoder-Q8_0.gguf (Best Model Encoder)..."
curl -L -o "t5-v1_1-xxl-encoder-Q8_0.gguf" "$BASE_URL/t5-v1_1-xxl-encoder-Q8_0.gguf?download=true"

echo "[INFO] Downloading longclip-L.pt..."
curl -L -o "longclip-L.pt" "$BASE_URL/longclip-L.pt?download=true"

# Navigate back to models directory
cd ..


# --- Checkpoints Directory ---
echo "[INFO] Setting up checkpoints directory..."
mkdir -p checkpoints
cd checkpoints

echo "[INFO] Downloading sd_xl_base_1.0_0.9vae.safetensors..."
curl -L -o "sd_xl_base_1.0_0.9vae.safetensors" "$BASE_URL/sd_xl_base_1.0_0.9vae.safetensors?download=true"

# Navigate back to models directory
cd ..


# --- Controlnet Directory ---
echo "[INFO] Setting up controlnet directory..."
mkdir -p controlnet
cd controlnet

echo "[INFO] diffusion_pytorch_model_promax.safetensors..."
curl -L -o "diffusion_pytorch_model_promax.safetensors" "$BASE_URL/diffusion_pytorch_model_promax.safetensors?download=true"

# Navigate back to models directory
cd ..


# --- Xlabs Controlnets Directory ---
echo "[INFO] Setting up xlabs/controlnets directory..."
mkdir -p xlabs/controlnets
cd xlabs/controlnets

echo "[INFO] Downloading flux-canny-controlnet-v3.safetensors..."
curl -L -o "flux-canny-controlnet-v3.safetensors" "$BASE_URL/flux-canny-controlnet-v3.safetensors?download=true"

echo "[INFO] Downloading flux-depth-controlnet-v3.safetensors..."
curl -L -o "flux-depth-controlnet-v3.safetensors" "$BASE_URL/flux-depth-controlnet-v3.safetensors?download=true"

echo "[INFO] Downloading flux-hed-controlnet-v3.safetensors..."
curl -L -o "flux-hed-controlnet-v3.safetensors" "$BASE_URL/flux-hed-controlnet-v3.safetensors?download=true"

# Navigate back to models directory
cd ../..

# --- Upscale Models Directory ---
echo "[INFO] Setting up upscale_models directory..."
mkdir -p upscale_models
cd upscale_models

echo "[INFO] Downloading 4x-ClearRealityV1.pth (Upscaler Model)..."
curl -L -o "4x-ClearRealityV1.pth" "$BASE_URL/4x-ClearRealityV1.pth?download=true"

# Navigate back to models directory
cd ..

# --- Pulid Models Directory ---
echo "[INFO] Setting up pulid directory..."
mkdir -p pulid
cd pulid

echo "[INFO] Downloading pulid_flux_v0.9.0.safetensors..."
curl -L -o "pulid_flux_v0.9.0.safetensors" "$BASE_URL/pulid_flux_v0.9.0.safetensors?download=true"

# Navigate back to models directory
cd ..


# --- InsightFace Directory ---
echo "[INFO] Cloning InsightFace repository..."
git lfs install
git clone https://huggingface.co/Aitrepreneur/insightface

# --- CogVideo Directory ---
echo "[INFO] Cloning CogVideo repository..."
git lfs install
git clone https://huggingface.co/Aitrepreneur/CogVideo

cd CogVideo/CogVideoX-5b-I2V/transformer
echo "[INFO] Downloading diffusion_pytorch_model-00001-of-00003.safetensors..."
curl -L -o "diffusion_pytorch_model-00001-of-00003.safetensors" "$BASE_URL/diffusion_pytorch_model-00001-of-00003.safetensors?download=true"

echo "[INFO] Downloading diffusion_pytorch_model-00002-of-00003.safetensors..."
curl -L -o "diffusion_pytorch_model-00002-of-00003.safetensors" "$BASE_URL/diffusion_pytorch_model-00002-of-00003.safetensors?download=true"

echo "[INFO] Downloading diffusion_pytorch_model-00003-of-00003.safetensors..."
curl -L -o "diffusion_pytorch_model-00003-of-00003.safetensors" "$BASE_URL/diffusion_pytorch_model-00003-of-00003.safetensors?download=true"

# Navigate back to models directory
cd ../../..

echo "[INFO] All models downloaded and setup completed successfully."

# === Custom Nodes Directory ===

echo "[INFO] Setting up custom_nodes directory..."
mkdir -p ../custom_nodes
cd ../custom_nodes

# List of GitHub repositories to clone
REPOS=(
	"https://github.com/balazik/ComfyUI-PuLID-Flux"
)

# Clone each repository
for repo in "${REPOS[@]}"; do
    repo_name=$(basename "$repo" .git)
    if [ -d "$repo_name" ]; then
        echo "[INFO] Repository $repo_name already exists. Skipping clone."
    else
        echo "[INFO] Cloning $repo..."
        git clone "$repo"
    fi
done

echo "[INFO] All custom_nodes repositories cloned successfully."
