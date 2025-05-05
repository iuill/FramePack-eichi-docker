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
    git checkout c5d375661a2557383f0b8da9d11d14c23b0c4eaf && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir xformers --index-url https://download.pytorch.org/whl/cu126


FROM lllyasviel AS eichi

WORKDIR /app

RUN git clone https://github.com/git-ai-code/FramePack-eichi /app/FramePack-eichi && \
    cd /app/FramePack-eichi && \
    git checkout fdf7353ab2ce56277a3f3555dc8cd13a75e932ae

RUN mkdir -p /app/FramePack/webui
RUN cp /app/FramePack-eichi/webui/endframe_ichi.py /app/FramePack/webui/ && \
    cp /app/FramePack-eichi/webui/endframe_ichi_f1.py /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/eichi_utils/ /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/lora_utils/ /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/diffusers_helper/ /app/FramePack/webui/ && \
    cp -r /app/FramePack-eichi/webui/locales/ /app/FramePack/webui/
