- qemu exit: `control` + `a` -> `q`

```shell
ls $(brew --prefix)/opt/llvm/bin/
FileCheck                       git-clang-format                llvm-exegesis                   llvm-strip
UnicodeNameMappingGenerator     hmaptool                        llvm-extract                    llvm-symbolizer
amdgpu-arch                     intercept-build                 llvm-gsymutil                   llvm-tapi-diff
analyze-build                   ld.lld                          llvm-ifs                        llvm-tblgen
bugpoint                        ld64.lld                        llvm-install-name-tool          llvm-tli-checker
c-index-test                    llc                             llvm-jitlink                    llvm-undname
clang                           lld                             llvm-jitlink-executor           llvm-windres
clang++                         lld-link                        llvm-lib                        llvm-xray
clang-16                        lldb                            llvm-libtool-darwin             mlir-cpu-runner
clang-apply-replacements        lldb-argdumper                  llvm-link                       mlir-linalg-ods-yaml-gen
clang-change-namespace          lldb-instr                      llvm-lipo                       mlir-lsp-server
clang-check                     lldb-server                     llvm-lto                        mlir-opt
clang-cl                        lldb-vscode                     llvm-lto2                       mlir-pdll
clang-cpp                       lli                             llvm-mc                         mlir-pdll-lsp-server
clang-doc                       lli-child-target                llvm-mca                        mlir-reduce
clang-extdef-mapping            llvm-PerfectShuffle             llvm-ml                         mlir-tblgen
clang-format                    llvm-addr2line                  llvm-modextract                 mlir-translate
clang-include-cleaner           llvm-ar                         llvm-mt                         modularize
clang-include-fixer             llvm-as                         llvm-nm                         not
clang-linker-wrapper            llvm-bcanalyzer                 llvm-objcopy                    nvptx-arch
clang-move                      llvm-bitcode-strip              llvm-objdump                    obj2yaml
clang-offload-bundler           llvm-c-test                     llvm-opt-report                 opt
clang-offload-packager          llvm-cat                        llvm-otool                      pp-trace
clang-pseudo                    llvm-cfi-verify                 llvm-pdbutil                    run-clang-tidy
clang-query                     llvm-config                     llvm-profdata                   sancov
clang-refactor                  llvm-cov                        llvm-profgen                    sanstats
clang-rename                    llvm-cvtres                     llvm-ranlib                     scan-build
clang-reorder-fields            llvm-cxxdump                    llvm-rc                         scan-build-py
clang-repl                      llvm-cxxfilt                    llvm-readelf                    scan-view
clang-scan-deps                 llvm-cxxmap                     llvm-readobj                    set-xcode-analyzer
clang-tblgen                    llvm-debuginfo-analyzer         llvm-reduce                     split-file
clang-tidy                      llvm-debuginfod                 llvm-remark-size-diff           tblgen-lsp-server
clangd                          llvm-debuginfod-find            llvm-remarkutil                 verify-uselistorder
clangd-xpc-test-client          llvm-diff                       llvm-rtdyld                     wasm-ld
count                           llvm-dis                        llvm-sim                        yaml-bench
darwin-debug                    llvm-dlltool                    llvm-size                       yaml2obj
diagtool                        llvm-dwarfdump                  llvm-split
dsymutil                        llvm-dwarfutil                  llvm-stress
find-all-symbols                llvm-dwp                        llvm-strings
```

```shell
% /usr/local/opt/llvm/bin/clang -print-targets | grep riscv32
    riscv32     - 32-bit RISC-V
```

```shell
% /usr/local/opt/llvm/bin/llvm-nm shell.bin.o
00010254 D _binary_shell_bin_end
00010254 A _binary_shell_bin_size
00000000 D _binary_shell_bin_start
```

```shell
% /usr/local/opt/llvm/bin/llvm-objdump -d shell.elf

shell.elf:      file format elf32-littleriscv

Disassembly of section .text:

01000000 <start>:
 1000000: 37 05 01 01   lui     a0, 4112
 1000004: 13 05 45 25   addi    a0, a0, 596
 1000008: 2a 81         mv      sp, a0
 100000a: 19 20         jal     0x1000010 <main>
 100000c: 21 20         jal     0x1000014 <exit>
 100000e: 00 00         unimp

01000010 <main>:
 1000010: 01 a0         j       0x1000010 <main>
 1000012: 00 00         unimp

01000014 <exit>:
 1000014: 01 a0         j       0x1000014 <exit>
...
```

```shell
(qemu) info mem
vaddr    paddr            size     attr
-------- ---------------- -------- -------
01000000 0000000080265000 00001000 rwxu-a-
01001000 0000000080267000 00010000 rwxu---
```

```shell
(qemu) xp /32b 0x80265000
0000000080265000: 0x37 0x05 0x01 0x01 0x13 0x05 0x45 0x25
0000000080265008: 0x2a 0x81 0x19 0x20 0x21 0x20 0x00 0x00
0000000080265010: 0x01 0xa0 0x00 0x00 0x01 0xa0 0x82 0x80
0000000080265018: 0x1d 0x71 0x06 0xde 0x22 0xdc 0x26 0xda
```

```shell
% hexdump -C shell.bin | head
00000000  37 05 01 01 13 05 45 25  2a 81 19 20 21 20 00 00  |7.....E%*.. ! ..|
00000010  01 a0 00 00 01 a0 82 80  1d 71 06 de 22 dc 26 da  |.........q..".&.|
00000020  4a d8 4e d6 52 d4 56 d2  5a d0 5e ce 62 cc 66 ca  |J.N.R.V.Z.^.b.f.|
00000030  6a c8 6e c6 2a 84 c6 ce  c2 cc be ca ba c8 b6 c6  |j.n.*...........|
00000040  b2 c4 ae c2 c8 00 2a c4  13 0a 50 02 13 09 30 06  |......*...P...0.|
00000050  93 09 40 06 29 4b a5 4a  37 d5 cc cc 13 0d d5 cc  |..@.)K.J7.......|
00000060  93 0b 80 07 37 05 00 01  13 0c 05 24 39 a0 63 06  |....7......$9.c.|
00000070  05 12 55 37 a2 8d 13 84  1d 00 03 45 04 00 e3 18  |..U7.......E....|
00000080  45 ff 83 45 14 00 93 0d  14 00 63 5b b9 02 63 80  |E..E......c[..c.|
00000090  35 05 63 89 75 05 13 05  30 07 e3 9e a5 fc 22 45  |5.c.u...0....."E|
```

```shell
(qemu) xp /8i 0x80265000
0x80265000:  01010537          lui                     a0,4112
0x80265004:  25450513          addi                    a0,a0,596
0x80265008:  812a              mv                      sp,a0
0x8026500a:  2019              jal                     ra,6                    # 0x80265010
0x8026500c:  2021              jal                     ra,8                    # 0x80265014
0x8026500e:  0000              illegal
0x80265010:  a001              j                       0                       # 0x80265010
0x80265012:  0000              illegal
```

```shell
% /usr/local/opt/llvm/bin/llvm-objdump -d shell.elf | head -n 20

shell.elf:      file format elf32-littleriscv

Disassembly of section .text:

01000000 <start>:
 1000000: 37 05 01 01   lui     a0, 4112
 1000004: 13 05 45 25   addi    a0, a0, 596
 1000008: 2a 81         mv      sp, a0
 100000a: 19 20         jal     0x1000010 <main>
 100000c: 21 20         jal     0x1000014 <exit>
 100000e: 00 00         unimp

01000010 <main>:
 1000010: 01 a0         j       0x1000010 <main>
 1000012: 00 00         unimp

01000014 <exit>:
 1000014: 01 a0         j       0x1000014 <exit>
```

```shell
(qemu) info registers

CPU#0
 V      =   0
 pc       01000010
```

```c
#include "user.h"

void main(void)
{
    *((volatile int *)0x80200000) = 0x1234;
    for (;;)
        ;
}
```

```shell
PANIC: kernel.c:255: unexpected trap scause=0000000f, stval=80200000, sepc=0100001a
```

```shell
% /usr/local/opt/llvm/bin/llvm-addr2line -e shell.elf 0x0100001a
/Users/.../os1000lines/shell.c:5
```
