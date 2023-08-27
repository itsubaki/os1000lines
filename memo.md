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
