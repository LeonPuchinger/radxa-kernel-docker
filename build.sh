#!/bin/bash

if [[ -z $KERNEL_VERSION ]]; then
    KERNEL_VERSION="linux-5.10-gen-rkr3.4"
    echo "Kernel version not explicitly set, using default: ${KERNEL_VERSION}"
    echo "Set the KERNEL_VERSION environment variable to use a different one."
fi

if [[ -z $DEVICE ]]; then
    DEVICE="rk3588-rock-5b"
    echo "DEVICE not explicitly set, using default: ${DEVICE}"
    echo "Set the DEVICE environment variable to use a different one."
fi

git clone -b ${KERNEL_VERSION} https://github.com/radxa/kernel.git
git clone -b master https://github.com/radxa/rkbin.git
git clone -b debian https://github.com/radxa/build.git

echo "starting kernel build..."
./build/mk-kernel.sh ${DEVICE}

ls out/kernel/