#!/bin/bash

echo
echo "Clean Build Directory"
echo 

make clean && make mrproper
rm -rf out

echo
echo "Create Working Directory"
echo

mkdir -p out

echo
echo "Set DEFCONFIG"
echo 
time make O=out CC=clang omega_defconfig
export PATH="/home/kristof/android/clang/bin:/home/kristof/android/binutils/bin:${PATH}"

echo
echo "Build The Kernel"
echo 

time make -j$(nproc --all) O=out CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu-
find /home/kristof/omega-11.0/out/arch/arm64/boot/dts/vendor/qcom -name '*.dtb' -exec cat {} + > /home/kristof/omega-11.0/out/arch/arm64/boot/dtb
