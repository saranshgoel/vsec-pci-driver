#!/bin/bash
cd "$(dirname "$0")"

if [ "$1" == "initramfs" ]; then
    echo "1. Ensuring kernel module is compiled..."
    docker run --rm -v $(pwd):/workspace kernel-builder bash -c \
      "make -C /workspace/driver KDIR=\$(ls -d /lib/modules/*/build | head -n 1)"

    echo "2. Extracting Linux kernel image (vmlinuz)..."
    docker run --rm -v $(pwd):/workspace kernel-builder bash -c \
      "apt-get update -qq && apt-get install -y -qq linux-image-generic > /dev/null && \
       cp \$(ls -1 /boot/vmlinuz* | head -n 1) /workspace/qemu-env/vmlinuz"

    echo "3. Building minimal BusyBox initramfs & packaging vsec_driver.ko..."
    docker run --rm -v $(pwd):/workspace kernel-builder bash -c \
      "apt-get update -qq && apt-get install -y -qq busybox-static cpio > /dev/null && \
       mkdir -p /workspace/qemu-env/initramfs/{bin,sbin,etc,proc,sys,dev,mnt,modules} && \
       cp /bin/busybox /workspace/qemu-env/initramfs/bin/ && \
       for tool in sh ls insmod rmmod dmesg mknod mount umount cat; do \
         ln -s /bin/busybox /workspace/qemu-env/initramfs/bin/\$tool 2>/dev/null || true; \
       done && \
       cp /workspace/driver/build/vsec_driver.ko /workspace/qemu-env/initramfs/modules/ && \
       cat << 'INITEOF' > /workspace/qemu-env/initramfs/init
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

echo ''
echo '=================================================='
echo '  Virtual Secure Storage Controller (vsec-blk)     '
echo '  QEMU Test Environment Loaded Successfully        '
echo '=================================================='
echo ''

exec /bin/sh
INITEOF
       chmod +x /workspace/qemu-env/initramfs/init && \
       cd /workspace/qemu-env/initramfs && \
       find . | cpio -o -H newc | gzip > /workspace/qemu-env/initramfs.cpio.gz"

    echo "QEMU environment ready! Run ./qemu-run.sh to boot."
else
    # Default: compile driver
    docker run --rm -v $(pwd):/workspace kernel-builder bash -c \
      "make -C /workspace/driver KDIR=\$(ls -d /lib/modules/*/build | head -n 1) \$1"
fi
