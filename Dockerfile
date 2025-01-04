ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Add SDXL models and VAE
RUN mkdir -p /sd-models
# Get files - 2 Options
# Option 1: 
#   These need to already have been downloaded:
#       wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
#       wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors
#       wget https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors
#   Add them to the image
#       ADD sd_xl_base_1.0.safetensors /sd-models/sd_xl_base_1.0.safetensors
#       ADD sd_xl_refiner_1.0.safetensors /sd-models/sd_xl_refiner_1.0.safetensors
#       ADD sdxl_vae.safetensors /sd-models/sdxl_vae.safetensors
# Option 2: 
#   Copy pre-existing SDXL models and VAE from another image (copy -> adds them to the image already)
COPY --from=ashleykza/comfyui:2.4.0 /sd-models/sd_xl_base_1.0.safetensors /sd-models/sd_xl_base_1.0.safetensors
COPY --from=ashleykza/comfyui:2.4.0 /sd-models/sd_xl_refiner_1.0.safetensors /sd-models/sd_xl_refiner_1.0.safetensors
COPY --from=ashleykza/comfyui:2.4.0 /sd-models/sdxl_vae.safetensors /sd-models/sdxl_vae.safetensors

# Copy the build scripts
WORKDIR /
COPY --chmod=755 build/* ./

# Install ComfyUI
ARG TORCH_VERSION
ARG XFORMERS_VERSION
ARG INDEX_URL
ARG COMFYUI_COMMIT
RUN /install_comfyui.sh

# Install Application Manager
ARG APP_MANAGER_VERSION
RUN /install_app_manager.sh
COPY app-manager/config.json /app-manager/public/config.json
COPY --chmod=755 app-manager/*.sh /app-manager/scripts/

# Install CivitAI Model Downloader
ARG CIVITAI_DOWNLOADER_VERSION
RUN /install_civitai_model_downloader.sh

# Clone and set up OmniGen in its own folder
RUN /install_omnigen.sh

# Cleanup installation scripts
RUN rm -f /install_*.sh

# Remove existing SSH host keys
RUN rm -f /etc/ssh/ssh_host_*

# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Set template version
ARG RELEASE
ENV TEMPLATE_VERSION=${RELEASE}

# Set the main venv path
ARG VENV_PATH
ENV VENV_PATH=${VENV_PATH}

# Copy the scripts
WORKDIR /
COPY --chmod=755 scripts/* ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]
