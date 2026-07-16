# Imagen base para Cloud Agents de Delfos.
# No COPY del repo: Cursor monta el workspace en el commit correcto.
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    UV_INSTALL_DIR=/usr/local/bin \
    PATH=/usr/local/bin:/usr/bin:/bin

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    build-essential \
    python3 \
    python3-venv \
    python3-dev \
    file \
    unzip \
    xz-utils \
    squashfs-tools \
    libfuse2t64 \
    libgtk-3-0t64 \
    libnss3 \
    libxss1 \
    libasound2t64 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libgbm1 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libxkbcommon0 \
    libpango-1.0-0 \
    libcairo2 \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# Node.js 22.x (Astro + Electron requieren >= 22.12)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && node --version \
    && npm --version

# uv (gestión de backend Python + PyInstaller via dependency-groups)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && uv --version
