wget -nc http://cdimage.ubuntu.com/ubuntu-base/releases/18.04/release/ubuntu-base-18.04.5-base-i386.tar.gz
VER=$(wget -qO- https://unofficial-builds.nodejs.org/download/release/index.tab | grep "linux-x86" | head -n 1 | awk '{print $1}') && wget -nc "https://unofficial-builds.nodejs.org/download/release/$VER/node-$VER-linux-x86.tar.gz"
