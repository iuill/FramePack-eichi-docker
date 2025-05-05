# 6.8GB
# FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-devel
# 3.05GB
FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-runtime AS lllyasviel

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    ninja-build \
    sudo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/lllyasviel/FramePack /app/FramePack && \
    cd /app/FramePack && \
    git checkout 6da55e8f8788044e67f95418effdfbe9f1d69700 && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir xformers --index-url https://download.pytorch.org/whl/cu126


FROM lllyasviel AS eichi

WORKDIR /app

RUN git clone https://github.com/git-ai-code/FramePack-eichi /app/FramePack-eichi && \
    cd /app/FramePack-eichi && \
    git checkout 6fd4394d55880af4e8a5828e755a4caa6f9827fa

RUN mkdir -p /app/FramePack/webui
RUN cp /app/FramePack-eichi/webui/endframe_ichi.py /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/eichi_utils/ /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/lora_utils/ /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/diffusers_helper/ /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/locales/ /app/FramePack/webui/
