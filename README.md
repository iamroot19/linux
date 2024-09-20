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
$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 -j $(nproc)
$ ./scripts/clang-tools/gen_compile_commands.py
$ sudo apt install -y qemu-system-arm
```
-> [rootfs download](http://downloads.yoctoproject.org/releases/yocto/yocto-4.0/machines/qemu/qemuarm64/core-image-minimal-qemuarm64-20220416133845.rootfs.ext4)
```
sudo qemu-system-aarch64 -M virt -smp cpus=4 -cpu cortex-a57 \
  -nographic -m 1024 \
  -numa node,cpus=0,nodeid=0 \
  -numa node,cpus=1,nodeid=1 \
  -numa node,cpus=2,nodeid=2 \
  -numa node,cpus=3,nodeid=3 \ 
  -kernel linux/arch/arm64/boot/Image \
  -append 'root=/dev/vda rw rootwait mem=1024M loglevel=8 console=ttyAMA0 nokaslr' \
  -netdev user,id=net0 \
  -device virtio-net-device,netdev=net0 \
  -drive if=none,id=disk,file=core-image-minimal-qemuarm64-20220416133845.rootfs.ext4,format=raw \
  -device virtio-blk-device,drive=disk
```
## \# History

- 첫 모임: 2022년 5월 7일 (zoom online)

### 123주차
- 2024.09.14  Zoom 온라인 (4명 참석)
- 코드 : pcpu_schedule_balance_work()

### 95주차
- 2024.03.02 Zoom 온라인 (6명 참석)
- 코드 : kmem_cache_free()

### 65주차
- 2023.08.26 Zoom 온라인 (5명 참석)
- 코드 : drain_all_pages()
- 책 : 4.6 페이지 할당자 ~ 4.6.4 zonelist 초기화->build_zonelists()

### 64주차
- 2023.08.19 Zoom 온라인 (7명 참석)
- 코드 : free_unref_page()

### 63주차
- 2023.08.12 Zoom 온라인 (7명 참석)
- 코드 : build_all_zonelist_init(), set_per_cpu_pageset(), rmqueue_pcplist()

### 62주차
- 2023.08.05 Zoom 온라인 (7명 참석)
- 책 : 4.5 per-cpu 페이지 프레임 캐시(pcp) 읽음

### 61주차
- 2023.07.29 Zoom 온라인 (7명 참석)
- 코드 : __free_pages() 분석 완료

### 60주차
- 2023.07.22 Zoom 온라인 (5명 참석)
- 코드 : __rmqueue()->__rmqueue_fallback() ~ __rmqueue(), __free_pages() ~ free_pages_prepare() 분석 중

### 59주차
- 2023.07.15 Zoom 온라인 (8명 참석)
- 코드 : __rmqueue() ~ __rmqueue()->__rmqueue_cma_fallback()

### 58주차
- 2023.07.01 Zoom 온라인 (7명 참석)
- 코드 : mem_init()->memblock_free_all()->free_unused_memmap() ~ mem_init()->memblock_free_all()->free_low_memory_core_early()->__free_memory_core()->__free_pages_memory()->memblock_free_pages()->__free_pages_core()->__free_pages_ok()->free_pages_prepare()

### 57주차
- 2023.06.24 Zoom 온라인 (7명 참석)
- 책 : 4.4.3 버디 시스템의 페이지 할당->move_freepages_block():페이지 블록의 속한 전체 페이지 이동하기 ~ 4.4.4 버디 시스템의 페이지 해제
- 코드 : mem_init() ~ mem_init()->memblock_free_all()->free_unused_memmap()

### 56주차
- 2023.06.17 Zoom 온라인 (6명 참석)
- 책 : 4.4.3 버디 시스템의 페이지 할당 ~ 4.4.3 버디 시스템의 페이지 할당->change_pageblock_range():페이지 블록의 마이그레이션 타입 설정하기

### 55주차
- 2023.06.10 Zoom 온라인 (6명 참석)
- 책 : 4.4.2 최초 버디 구성 과정

### 54주차
- 2023.06.03 Zoom 온라인 (7명 참석)
- 코드 : bootmem_init()->arch_numa_init()->numa_init()->setup_node_to_cpumask_map() ~ bootmem_init()->arch_numa_init()->of_numa_init() 분석 완료
- 책 : 4.4 버디 시스템 ~ 4.4.1 버디 시스템의 구조

### 53주차
- 2023.05.27 Zoom 온라인 (7명 참석)
- 코드 : bootmem_init()->zone_sizes_init()->free_area_init()->memmap_init() ~ bootmem_init()->zone_sizes_init() 분석 완료, bootmem_init()->arch_numa_init() ~ bootmem_init()->arch_numa_init()->numa_init()->numa_register_nodes() 분석 완료

### 52주차
- 2023.05.20 Zoom 온라인 (6명 참석)
- 코드 : bootmem_init()->zone_sizes_init()->free_area_init()-free_area_init_node()->free_area_init_core() ~ bootmem_init()->zone_sizes_init()->free_area_init()->memmap_init() 분석 중

### 51주차
- 2023.05.13 Zoom 온라인 (6명 참석)
- 코드 : bootmem_init()->zone_sizes_init()->free_area_init()->setup_nr_node_ids() ~ bootmem_init()->zone_sizes_init()->free_area_init()-free_area_init_node()->free_area_init_core() 분석 중

### 50주차
- 2023.05.06 Zoom 온라인 (5명 참석)
- 코드 : bootmem_init()->zone_sizes_in1it()->free_area_init()->find_zone_movable_pfns_for_nodes() ~ bootmem_init()->zone_sizes_init()->free_area_init()->setup_nr_node_ids() 분석 완료

### 49주차
- 2023.04.29 Zoom 온라인 (8명 참석)
- 코드 : bootmem_init()->zone_sizes_init() ~ bootmem_init()->zone_sizes_init()->free_area_init()->find_zone_movable_pfns_for_nodes() 분석 중

### 48주차
- 2023.04.22 Zoom 온라인 (7명 참석)
- 코드 : bootmem_init() ~ bootmem_init()->sparse_init() 분석 완료

### 47주차
- 2023.04.15 Zoom 온라인 (5명 참석)
- 코드 : paging_init()->map_mem() ~ paging_init() 분석 완료

### 46주차 
- 2023.04.08 Zoom 온라인 (6명 참석)
- ARM 리눅스 커널 책 : 3.1.5 페이지 테이블 레지스터 설정 -> cpu_switch_mm(): mm스위칭하기 (157쪽) ~ 3.1.6 페이지 테이블 및 주소 변환 API (161쪽)
- 코드 : paging_init() ~ paging_init()->map_mem() 분석 완료
- pgd_set_fixmap(), pgd_clear_fixmap() 분석 예정

### 45주차 
- 2023.04.01 Zoom  (7명 참석)
- ARM 리눅스 커널 책 : 3.1 ARM64 페이징 (127쪽) ~ 3.1.5 페이지 테이블 레지스터 설정 -> cpu_uninstall_idmap(): 아이덴티티 매핑 테이블 사용 해제하기 (157쪽)

### 44주차 
- 2023.03.25 Zoom 온라인
- ARM 리눅스 커널 4.3.3 vmemmap을 사용하는 sparse 메모리모델 (~304쪽)

### 43주차 
- 2023.03.18 Zoom 온라인
- ARM 리눅스 커널 4.2 memblock_double_array() ~ 4.3 전까지 코드분석, 3.1 ~ 3.1.3 map_kernel() 책 읽기 (~137쪽)

### 42주차 
- 2023.03.11 Zoom 온라인
- ARM 리눅스 커널 4.3.3 vmemmap을 사용하는 sparse 메모리모델 (~304쪽)

### 40주차, 41주차
- 2023.02.24, 2023.03.04. Zoom 온라인
- ARM 리눅스 커널 4.3.2 부트 메모리 초기화
- 41주차에는 40주차에 스터디한 내용을 복습했습니다.

### 39주차
- 2023.02.18, Zoom 온라인 (10명 참석)
- ARM 리눅스 커널 4.1.4 memblock 추가 ~ 4.3.1 존 타입

### 38주차
- 2023.02.11, Zoom 온라인 (9명 참석)
- ARM 리눅스 커널 3.5 vmemmap ~ 4.1.3 memblock 할당과 해제
- vmemmap_populate() 분석 완료

### 37주차
- 2023.02.04, Zoom 온라인 (10명 참석)
- ARM 리눅스 커널 3.4 I/O 메모리 매핑(ioremap) 읽음
- ioremap 관련 함수 분석 완료

### 36주차
- 2023.01.28, Zoom 온라인 (8명 참석)
- vunmap() 분석 완료
- ARM 리눅스 커널 3.4 ~ 3.4.1 ioremap

### 36주차
- 2023.01.21
- 명절 휴식

### 35주차
- 2023.01.14, Zoom 온라인 (8명 참석)
- vmap() 분석 완료
- vunmap() 분석 예정

### 34주차
- 2023.01.07, Zoom 온라인 (9명 참석)
- vmap() 분석 중
- vmap()->get_vm_area_caller()->alloc_vmap_area()->insert_vmap_area() 분석 완료
- vmap()->get_vm_area_caller()->alloc_vmap_area()->purge_vmap_area_lazy() 분석 예정

### 33주차
- 2022.12.31, Zoom 온라인 (7명 참석)
- ARM 리눅스 커널 3.3.3 vmap_area 할당 ~ 3.3 끝
- vmap() 분석 중
- vmap()->get_vm_area_caller()->alloc_vmap_area() 분석 완료
- vmap()->get_vm_area_caller()->alloc_vmap_area()->__alloc_vmap_area 분석 예정

### 32주차
- 2022.12.24
- 크리스마스 휴식

### 31주차
- 2022.12.17, Zoom 온라인 (11명 참석)
- ARM 리눅스 커널 3.3.3 vmap_area 할당 ~ 3.3.4 vunmap

### 30주차
- 2022.12.10, Zoom 온라인 (11명 참석)
- MM Overview Seminar (유형곤)
- ARM 리눅스 커널 3.3.1 ~ 3.32 vmap

### 29주차
- 2022.12.03, Zoom 온라인 (7명 참석)
- MM Overview Seminar (유형곤)

### 28주차
- 2022.11.26, Zoom 온라인 (9명 참석)
- MM Overview Seminar (유형곤)

### 27주차
- 2022.11.19, 오프라인 (3명 참석), Zoom 온라인 (5명 참석)
- IARMROOT 16기 Seminar 참석
- start_kernel 이후 스터디 방법 재논의
- struct thread_info 분석

### 26주차
- 2022.11.12, Zoom 온라인 (9명 참석)
- start_kernel 시작
- local_irq_disable까지 분석 완료
- start_kernel 이후 스터디 방법 논의

### 25주차
- 2022.11.05, Zoom 온라인 (7명 참석)
- init_feature_override, kaslr_early_init, switch_to_vhe 분석 완료

### 24주차
- 2022.10.29, Zoom 온라인 (8명 참석)
- early_fixmap_init@arch/arm64/mm/mmu.c 분석 완료
- fixmap_remap_fdt@arch/arm64/mm/mmu.c 분석 완료
- early_fdt_map@arch/arm64/kernel/setup.c 분석 완료

### 23주차
- 2022.10.22, Zoom 온라인 (6명 참석)
- ARM리눅스커널 3.1.2, 3.2.1
- __primary_switched - early_fdt_map 분석 중

### 22주차
- 2022.10.15, Zoom 온라인 (8명 참석)
- __primary_switched 분석 중
- arch/arm64/kernel/entry.S Exception 관련 내용 분석 중 (kernel_ventry)

### 21주차
- 2022.10.08, Zoom 온라인 (8명 참석)
- __primary_switch 분석 완료
- __primary_switched 분석 시작

### 20주차
- 2022.10.01, Zoom 온라인 (6명 참석)
- __cpu_setup@arch/arm64/mm/proc.S 완료
- __primary_switch 분석 시작

### 19주차
- 2022.09.24, Zoom 온라인 (13명 참석)
- __cpu_setup@arch/arm64/mm/proc.S 진행 중

### 18주차
- 2022.09.17, Zoom 온라인 (7명 참석)
- .macro map_memory, .macro compute_indices, .macro populate_entries 완료
- ARM리눅스커널 2.1.5 CPU 초기화
- __cpu_setup@arch/arm64/mm/proc.S 분석 시작

### 17주차
- 2022.09.03, Zoom 온라인 (14명 참석)
- __create_page_tables 완료

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
