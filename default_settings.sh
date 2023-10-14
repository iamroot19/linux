#!/bin/bash

wget -O .config https://raw.githubusercontent.com/iamroot19/linux/dev-v6.1/arch/arm64/configs/arm64_qemu_defconfig
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make olddefconfig
git clone https://github.com/elongbug/vscode-linux-kernel .vscode
wget -O .clangd https://raw.githubusercontent.com/iamroot19/linux/dev-v6.1/.clangd
git checkout dev-v6.1 -- .vscode
