#!/bin/bash
set -xue

QEMU=/usr/local/bin/qemu-system-riscv32
CC=/usr/local/opt/llvm/bin/clang
OBJCOPY=/usr/local/opt/llvm/bin/llvm-objcopy
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib"

$CC $CFLAGS -Wl,-Tuser.ld -Wl,-Map=shell.map -o shell.elf shell.c user.c common.c
$OBJCOPY --set-section-flags .bss=alloc,contents -O binary shell.elf shell.bin
$OBJCOPY -Ibinary -Oelf32-littleriscv shell.bin shell.bin.o

# % ls $(brew --prefix)/bin/qemu-system-riscv32
# /usr/local/bin/qemu-system-riscv32

$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot -kernel kernel.elf
