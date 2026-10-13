FROM ubuntu:24.04

# Install Linux kernel build tools and explicit kernel headers
RUN apt-get update && apt-get install -y \
    build-essential \
    linux-headers-generic \
    gcc-aarch64-linux-gnu \
    kmod \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace