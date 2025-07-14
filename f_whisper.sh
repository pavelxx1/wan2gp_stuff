#!/bin/bash

# Faster Whisper Server Setup Script

# Change to /tmp directory
# cd /tmp

# Install unzip if not available
apt update && apt install -y unzip wget

# Download and unpack FW.zip
wget https://github.com/pavelxx1/wan2gp_stuff/raw/refs/heads/main/FW.zip
unzip -o FW.zip

# Download and install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
$HOME/miniconda3/bin/conda init bash
source ~/.bashrc

# Export PATH to ensure conda is available
export PATH="$HOME/miniconda3/bin:$PATH"

# Create conda environment with Python 3.12
conda create -n whisper python=3.12 -y
conda activate whisper

# Install CUDA 12.2 and cuDNN
conda install cuda-toolkit=12.2 -c nvidia -y
conda install cudnn -c conda-forge -y

# Install faster-whisper-server with all dependencies
pip install .[client,dev,ui]

# Set environment variables
export PRELOAD_MODELS='["deepdml/faster-whisper-large-v3-turbo-ct2"]'
export WHISPER__INFERENCE_DEVICE=cuda

# Start the server
echo "Starting Faster Whisper Server..."
uvicorn faster_whisper_server.main:create_app --factory --host 0.0.0.0 --port 8000

