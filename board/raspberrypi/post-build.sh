#!/bin/sh

set -u
set -e

BOARD_DIR="$(dirname $0)"

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Wipe target dir
rm -rf ${TARGET_DIR}/*
# Copy crafted ROOTFS
cp -a ${BOARD_DIR}/../../system/skeleton-pebble/* ${TARGET_DIR}/

#sed -i 's|\(^kernel/net/wireless/cfg80211\.ko.*\)|\1 kernel/crypto/sha256_generic.ko|g' ${TARGET_DIR}/lib/modules/5.10.92-v8/modules.dep

