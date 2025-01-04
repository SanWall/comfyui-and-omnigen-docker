#!/usr/bin/env bash
set -e

git clone https://github.com/SanWall/sd-app-manager-runpod.git /app-manager
cd /app-manager
# git checkout tags/${APP_MANAGER_VERSION}
npm install # Install dependencies



# #   List the contents of /ComfyUI for debugging
# echo "Contents of / root-directory after cloning:"
# ls -l /

# # Debugging-1
# #   List the contents of /ComfyUI for debugging
# echo "Contents of /ComfyUI directory after cloning:"
# ls -l /ComfyUI

# # Debugging-2
# #   List the contents of /ComfyUI for debugging
# echo "Contents of /ComfyUI/app-manager directory after cloning:"
# ls -l /app-manager

# # Debugging-2
# #   List the contents of /ComfyUI for debugging
# echo "Contents of /ComfyUI/app-manager/app-manager directory after cloning:"
# ls -l /app-manager/app-manager

# # Debugging-3
# #   Show the current path for debugging
# echo "Current path: $(pwd)" 
# #   Check if package.json exists
# if [[ ! -f "package.json" ]]; then
#   echo "Error: package.json not found in $(pwd)"
#   exit 1
# fi