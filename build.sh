#!/bin/bash

if [[ -z $KERNEL_VERSION ]]; then
    KERNEL_VERSION="stable-5.10-rock5"
    echo "Kernel version not explicitly set, using default: ${KERNEL_VERSION}"
    echo "Set the KERNEL_VERSION environment variable to use a different one."
fi

if [[ -z $DEVICE ]]; then
    DEVICE="rk3588-rock-5b"
    echo "DEVICE not explicitly set, using default: ${DEVICE}"
    echo "Set the DEVICE environment variable to use a different one."
fi

# Build toolchain is fetched at runtime, so the image always uses the latest sources

echo "fetching build sources and toolchain..."
git clone --depth 1 -b ${KERNEL_VERSION} https://github.com/radxa/kernel.git
git clone --depth 1 -b master https://github.com/radxa/rkbin.git
git clone --depth 1 -b debian https://github.com/radxa/build.git
curl -o gcc-arm-x86_64-aarch64-none-linux-gnu.tar.gz https://dl.radxa.com/tools/linux/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.gz
tar zxvf gcc-arm-x86_64-aarch64-none-linux-gnu.tar.gz -C /usr/local/
cd /usr/local/
export PATH="$(find . -name aarch64-none-linux-gnu-ld -type f -print0 | xargs -0 dirname | head -n 1 | xargs -0 realpath -z):$PATH"
cd -

echo "starting kernel build..."
./build/mk-kernel.sh ${DEVICE}

echo "building debian packages for easier installation..."
./build/pack-kernel.sh -d rockchip_linux_defconfig -r 10
