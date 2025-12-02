cd rootfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../ubuntu18.img
cd ..
