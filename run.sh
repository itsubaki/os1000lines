#!/bin/bash
set -xue

QEMU=/usr/local/bin/qemu-system-riscv32
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot
