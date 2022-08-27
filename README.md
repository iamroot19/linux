# 최신 ARM64 리눅스 커널 5.19 분석

## 커뮤니티: IAMROOT 19차
- [www.iamroot.org][#iamroot] | IAMROOT 홈페이지
- [jake.dothome.co.kr][#moonc] | 문c 블로그

[#iamroot]: http://www.iamroot.org
[#moonc]: http://jake.dothome.co.kr

## \# How to build and run
```
$ sudo apt install -y build-essential gcc-aarch64-linux-gnu g++-aarch64-linux-gnu git bison flex libssl-dev libncurses-dev  
$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 arm64_qemu_defconfig
$ sudo apt install -y qemu-system-arm
```
-> [rootfs download](http://downloads.yoctoproject.org/releases/yocto/yocto-4.0/machines/qemu/qemuarm64/core-image-minimal-qemuarm64-20220416133845.rootfs.ext4)
```
sudo qemu-system-aarch64 -M virt -smp 4 -m 1024 -cpu cortex-a57 -nographic \
  -kernel linux/arch/arm64/boot/Image \
  -append 'root=/dev/vda rw rootwait mem=1024M loglevel=8 console=ttyAMA0' \
  -netdev user,id=net0 \
  -device virtio-net-device,netdev=net0 \
  -drive if=none,id=disk,file=core-image-minimal-qemuarm64-20220416133845.rootfs.ext4,format=raw \
  -device virtio-blk-device,drive=disk
```
## \# History

- 첫 모임: 2022년 5월 7일 (zoom online)

### 16주차
- 2022.08.27, Zoom 온라인 (11명 참석)
- 코드로 알아보는 ARM 리눅스 커널 : 2.1.3 ~ 2.1.4
- set_cpu_boot_mode_flag 완료
- __create_page_tables 분석 시작
- **Discord 새로 시작**

### 15주차
- 2022.08.20, Zoom 온라인
- 코드로 알아보는 ARM 리눅스 커널 : 2.1 ~ 2.1.2
- dcache_inval_poc, init_kernel_el 완료

### 14주차
- 2022.08.13, Zoom 온라인
- 첫 Linux kernel v5.19 source code 분석 시작
- preserve_boot_args 완료
