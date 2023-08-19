#!/bin/bash
set -xue

# % ls $(brew --prefix)/opt/llvm/bin/clang
# /usr/local/opt/llvm/bin/clang
CC=/usr/local/opt/llvm/bin/clang
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib"
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf kernel.c

# % ls $(brew --prefix)/bin/qemu-system-riscv32
# /usr/local/bin/qemu-system-riscv32
QEMU=/usr/local/bin/qemu-system-riscv32
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot -kernel kernel.elf
