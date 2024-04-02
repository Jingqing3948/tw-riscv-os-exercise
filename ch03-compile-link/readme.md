## 3.1

```shell
gcc -g -c hello.c
```

add -g is good for debug. For example, without -g the `objdump -S hello.o` won't indicate which c statement is related to the asm instructions.

check file header:

```shell
readelf -h hello.o
```

```shell
ELF 头：
  Magic：   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  类别:                              ELF64
  数据:                              2 补码，小端序 (little endian)
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI 版本:                          0
  类型:                              REL (可重定位文件)
  系统架构:                          Advanced Micro Devices X86-64
  版本:                              0x1
  入口点地址：               0x0
  程序头起点：          0 (bytes into file)
  Start of section headers:          2096 (bytes into file)
  标志：             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           0 (bytes)
  Number of program headers:         0
  Size of section headers:           64 (bytes)
  Number of section headers:         23
  Section header string table index: 22
```

check section header table:

```shell
readelf -SW hello.o
```

```shell
There are 23 section headers, starting at offset 0x830:

节头：
  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        0000000000000000 000040 00001e 00  AX  0   0  1
  [ 2] .rela.text        RELA            0000000000000000 000500 000030 18   I 20   1  8
  [ 3] .data             PROGBITS        0000000000000000 00005e 000000 00  WA  0   0  1
  [ 4] .bss              NOBITS          0000000000000000 00005e 000000 00  WA  0   0  1
  [ 5] .rodata           PROGBITS        0000000000000000 00005e 00000d 00   A  0   0  1
  [ 6] .debug_info       PROGBITS        0000000000000000 00006b 00008c 00      0   0  1
  [ 7] .rela.debug_info  RELA            0000000000000000 000530 000180 18   I 20   6  8
  [ 8] .debug_abbrev     PROGBITS        0000000000000000 0000f7 000043 00      0   0  1
  [ 9] .debug_aranges    PROGBITS        0000000000000000 00013a 000030 00      0   0  1
  [10] .rela.debug_aranges RELA            0000000000000000 0006b0 000030 18   I 20   9  8
  [11] .debug_line       PROGBITS        0000000000000000 00016a 000052 00      0   0  1
  [12] .rela.debug_line  RELA            0000000000000000 0006e0 000060 18   I 20  11  8
  [13] .debug_str        PROGBITS        0000000000000000 0001bc 0000f7 01  MS  0   0  1
  [14] .debug_line_str   PROGBITS        0000000000000000 0002b3 0000a2 01  MS  0   0  1
  [15] .comment          PROGBITS        0000000000000000 000355 00002c 01  MS  0   0  1
  [16] .note.GNU-stack   PROGBITS        0000000000000000 000381 000000 00      0   0  1
  [17] .note.gnu.property NOTE            0000000000000000 000388 000020 00   A  0   0  8
  [18] .eh_frame         PROGBITS        0000000000000000 0003a8 000038 00   A  0   0  8
  [19] .rela.eh_frame    RELA            0000000000000000 000740 000018 18   I 20  18  8
  [20] .symtab           SYMTAB          0000000000000000 0003e0 000108 18     21   9  8
  [21] .strtab           STRTAB          0000000000000000 0004e8 000013 00      0   0  1
  [22] .shstrtab         STRTAB          0000000000000000 000758 0000d3 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), l (large), p (processor specific)
```

disassemble hello.o:

```shell
objdump -S hello.o
```

```shell
hello.o：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include <stdio.h>
int main()
{
   0:	f3 0f 1e fa          	endbr64 
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
	printf("hello world!\n");
   8:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # f <main+0xf>
   f:	48 89 c7             	mov    %rax,%rdi
  12:	e8 00 00 00 00       	call   17 <main+0x17>
	return 0;
  17:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1c:	5d                   	pop    %rbp
  1d:	c3                   	ret    

```

1. push %rbp origin value to protect register status.
2. make %rbp point to current stack top. Although in this case we don't need stack because print hello world don't use local variables.
3. the third step maybe means pass the "helloworld" string value to %rax.
4. pass %rax to %rdi which is usually used as a function first parameter register.
5. call print function.
6. change %eax to zero means return 0.
7. recover %rbp value.

## 3.2

```shell
objdump -x  ex3-2.o
```

```shell
ex3-2.o：     文件格式 elf64-x86-64
ex3-2.o
体系结构：i386:x86-64， 标志 0x00000011：
HAS_RELOC, HAS_SYMS
起始地址 0x0000000000000000

节：
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000025  0000000000000000  0000000000000000  00000040  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .data         00000008  0000000000000000  0000000000000000  00000068  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000004  0000000000000000  0000000000000000  00000070  2**2
                  ALLOC
  3 .rodata       00000011  0000000000000000  0000000000000000  00000070  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .comment      0000002c  0000000000000000  0000000000000000  00000081  2**0
                  CONTENTS, READONLY
  5 .note.GNU-stack 00000000  0000000000000000  0000000000000000  000000ad  2**0
                  CONTENTS, READONLY
  6 .note.gnu.property 00000020  0000000000000000  0000000000000000  000000b0  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .eh_frame     00000038  0000000000000000  0000000000000000  000000d0  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
SYMBOL TABLE:
0000000000000000 l    df *ABS*	0000000000000000 ex3-2.c
0000000000000000 l    d  .text	0000000000000000 .text
0000000000000000 l    d  .rodata	0000000000000000 .rodata
0000000000000000 l     O .bss	0000000000000004 static_var_uninit.1
0000000000000004 l     O .data	0000000000000004 static_var.0
0000000000000000 g     O .data	0000000000000004 global_init
0000000000000000 g     O .rodata	0000000000000004 global_const
0000000000000000 g     F .text	0000000000000025 main
0000000000000000         *UND*	0000000000000000 puts


RELOCATION RECORDS FOR [.text]:
OFFSET           TYPE              VALUE 
0000000000000016 R_X86_64_PC32     .rodata
000000000000001e R_X86_64_PLT32    puts-0x0000000000000004


RELOCATION RECORDS FOR [.eh_frame]:
OFFSET           TYPE              VALUE 
0000000000000020 R_X86_64_PC32     .text

```

data: inited global / static variables. 

- global_init
- static_var

rodata: read-only, such as const variables, and string constants.

- global_const
- "hello world" (R_X86_64_PC32 is the quotation of string constant "hello world")

bss: uninitialized global / static variables.

- static_var_uninit

stack: not specified in this table, includes some local variables.

- auto_var

