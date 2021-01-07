#!/bin/bash

echo
echo "Clean Build Directory"
echo 

make clean && make mrproper

echo
echo "Issue build commands"
echo

mkdir -p out
export CLANG_PATH=/home/kristof/android/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export CROSS_COMPILE=/home/kristof/android/binutils/bin/aarch64-linux-gnu-

echo
echo "Set DEFCONFIG"
echo 
time make O=out CC=clang AR=llvm-ar LD=ld.lld NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip omega_defconfig
export PATH="/home/kristof/android/clang/bin:/home/kristof/android/binutils/bin:${PATH}"
export LD_LIBRARY_PATH="/home/kristof/android/clang/lib:/home/kristof/android/clang/lib64:$LD_LIBRARY_PATH"

echo
echo "Build The Kernel"
echo 

time make -j$(nproc --all) O=out CC=clang AR=llvm-ar LD=ld.lld NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu-
find /home/kristof/omega-11.0_sm8250/out/arch/arm64/boot/dts/vendor/qcom -name '*.dtb' -exec cat {} + > /home/kristof/omega-11.0_sm8250/out/arch/arm64/boot/dtb
