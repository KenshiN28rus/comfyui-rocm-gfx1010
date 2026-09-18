# ComfyUI для AMD RDNA1 (gfx1010) с PyTorch 2.8 + ROCm 6.2
FROM rocm/dev-ubuntu-22.04:6.2-complete
RUN apt update && apt install -y \
    build-essential clang cmake git python3-dev python3-venv \
    python3-pip libnuma-dev wget curl ninja-build \
    libopenblas0 liblapack3 pkg-config \
    libjpeg-dev libpng-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
RUN cd /tmp && \
    wget https://github.com/Efenstor/PyTorch-ROCm-gfx1010-Debian13/raw/refs/heads/main/files/rocblas_library_gfx1010.tar.gz && \
    mkdir -p /opt/rocm/lib/rocblas/library && \
    tar xvzf rocblas_library_gfx1010.tar.gz -C /opt/rocm/lib/rocblas/library && \
    rm rocblas_library_gfx1010.tar.gz
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --upgrade pip wheel setuptools
WORKDIR /tmp
RUN git clone https://github.com/pytorch/pytorch.git --branch=release/2.8 --recurse-submodules --depth=1 pytorch && \
    cd pytorch && \
    pip install -r requirements.txt && \
    python tools/amd_build/build_amd.py
RUN cd /tmp/pytorch && \
    mkdir -p patches_ck && \
    (wget -P patches_ck https://raw.githubusercontent.com/Efenstor/PyTorch-ROCm-gfx1010/refs/heads/main/patches/5465fcc9e25ab9828b9d34ce5d341a127ff8ea9e.patch && \
     git apply --directory=third_party/composable_kernel patches_ck/5465fcc9e25ab9828b9d34ce5d341a127ff8ea9e.patch) || true
RUN cd /tmp/pytorch && \
    export PYTORCH_ROCM_ARCH=gfx1010 && \
    export MAX_JOBS=$(nproc) && \
    export USE_CUDA=0 USE_ROCM=1 USE_NNPACK=0 USE_QNNPACK=0 BUILD_TEST=0 && \
    export USE_FBGEMM=0 USE_MKLDNN=0 USE_DISTRIBUTED=0 && \
    export USE_FLASH_ATTENTION=0 USE_MEM_EFF_ATTENTION=0 && \
    python setup.py bdist_wheel && \
    pip install --no-deps dist/*.whl
WORKDIR /opt
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /opt/ComfyUI
RUN sed -i -E 's/^(torch|torchvision|torchaudio)/#\1/' requirements.txt && \
    pip install --no-cache-dir -r requirements.txt

RUN pip install --no-cache-dir --no-deps torchsde trampoline
RUN cd custom_nodes && \
    git clone https://github.com/Comfy-Org/ComfyUI-Manager.git comfyui-manager
RUN mkdir -p /opt/ComfyUI/user/__manager && \
    printf '[default]\ngit_exe = /usr/bin/git\ndowngrade_blacklist = torch, torchvision, torchaudio, numpy, triton, nvidia-cublas, nvidia-cuda-runtime, nvidia-cudnn-cu13\nsecurity_level = normal\nallow_pip_install = false\nallow_git_url_install = false\n' > /opt/ComfyUI/user/__manager/config.ini
EXPOSE 8188
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--force-fp32", "--lowvram", "--enable-manager"]
