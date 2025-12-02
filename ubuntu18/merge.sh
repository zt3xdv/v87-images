#!/bin/bash

TARGET_DIR="rootfs"
UBUNTU_FILE="ubuntu-base-18.04.5-base-i386.tar.gz"
NODE_FILE=$(ls node-*-linux-x86.tar.gz | sort -V | tail -n 1)

mkdir -p "$TARGET_DIR"

echo "Extracting $UBUNTU_FILE to $TARGET_DIR..."
tar -xzf "$UBUNTU_FILE" -C "$TARGET_DIR"

echo "Extracting $NODE_FILE to $TARGET_DIR..."

tar -xzf "$NODE_FILE" -C "$TARGET_DIR" --strip-components=1


cat <<EOF > "$TARGET_DIR/init"
#!/bin/sh

mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs udev /dev

mkdir -p /dev/pts
mount -t devpts devpts /dev/pts

export PATH=/sbin:/bin:/usr/sbin:/usr/bin

ip addr add 192.168.86.100/24 dev eth0
ip link set eth0 up
ip route add default via 192.168.86.1

echo "nameserver 8.8.8.8" > /etc/resolv.conf

mkdir -p /home
mount -t 9p -o trans=virtio,version=9p2000.L,access=any host9p /home

cd /home
exec /bin/sh
EOF

chmod 777 "$TARGET_DIR/init"

echo "Done."
