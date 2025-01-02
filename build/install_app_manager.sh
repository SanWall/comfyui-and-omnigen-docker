#!/usr/bin/env bash
set -e

# Clone the repository and switch to the dev branch
git clone --branch dev https://github.com/SanWall/comfyui-and-omnigen-docker.git /app-manager
cd /app-manager
# git checkout tags/${APP_MANAGER_VERSION}

# Install dependencies
npm install
