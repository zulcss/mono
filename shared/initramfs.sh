#!/usr/bin/env bash

set -xeuo pipefail

mkdir -p /usr/lib/dracut/dracut.conf.d/
printf "systemdsystemconfdir=/etc/systemd/system\nsystemdsystemunitdir=/usr/lib/systemd/system\n" | tee /usr/lib/dracut/dracut.conf.d/30-bootcrew-fix-bootc-module.conf
printf 'reproducible=yes\nhostonly=no\ncompress=zstd\nadd_dracutmodules+=" bootc "' | tee "/usr/lib/dracut/dracut.conf.d/30-bootcrew-bootc-container-build.conf"
KERNEL_PATH="$(find /usr/lib/modules -maxdepth 1 -type d | grep -v ".*.img" | tail -n 1)"
dracut -v --force "${KERNEL_PATH}/initramfs.img" --kver "$(basename "${KERNEL_PATH}")"
#kver=$(ls /usr/lib/modules); 
#echo $kver
#dracut -vf /usr/lib/modules/$kver/initramfs.img
