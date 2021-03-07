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
time make O=out omega_defconfig
export PATH="/home/kristof/android/aarch64-elf/bin:${PATH}"

echo
echo "Build The Kernel"
echo 

time make -j$(nproc --all) O=out CROSS_COMPILE=aarch64-elf-
find /home/kristof/omega-11.0/out/arch/arm64/boot/dts/vendor/qcom -name '*.dtb' -exec cat {} + > /home/kristof/omega-11.0/out/arch/arm64/boot/dtb
