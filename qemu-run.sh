#!/bin/bash
if ! command -v qemu-system-aarch64 &> /dev/null; then
    echo "Error: qemu is missing. Run: brew install qemu"
    exit 1
fi

qemu-system-aarch64 \
  -machine virt \
  -cpu host \
  -accel hvf \
  -m 1G \
  -kernel qemu-env/vmlinuz \
  -initrd qemu-env/initramfs.cpio.gz \
  -nographic \
  -append "console=ttyAMA0 rdinit=/init panic=1"
