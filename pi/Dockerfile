FROM node:trixie-slim

# 1. Install tool sistem dasar, Python3, dan pip
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    ca-certificates \
    python3 \
    python3-fastapi \
    python3-pip \
    python3-venv \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 2. Setup PATH untuk npm global & binary python
ENV NPM_CONFIG_PREFIX=/usr/local
ENV PATH="/root/.local/bin:/usr/local/bin:${PATH}"

# Install KiloCode secara global
RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent

WORKDIR /app

#COPY ./ecosystem.config.js /etc/ecosystem.config.js

# Jalankan PM2 membaca file di /etc
#CMD ["pm2-runtime", "start", "/etc/ecosystem.config.js"]
