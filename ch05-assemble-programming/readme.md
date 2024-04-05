## 5.1
### SUB objdump and decode
```shell
make code
```

```
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <_start>:

        .text                   # Define beginning of text section
        .global _start          # Define entry _start

_start:
        li x6, -1               # x6 = -1
80000000:       fff00313                li      t1,-1
        li x7, -2               # x7 = -2
80000004:       ffe00393                li      t2,-2
        sub x5, x6, x7          # x5 = x6 - x7
80000008:       407302b3                sub     t0,t1,t2

8000000c <stop>:

stop:
        j stop                  # Infinite loop to stop execution
8000000c:       0000006f                j       8000000c <stop>
```

decode: 40 73 02 b3 (already convert the little endian to regular order)

| data | funct7 | rs2 | rs1 | funct3 | rd | opcode |
| :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| 40 73 02 b3 | 0100 000 | 0 0111 | 0011 0 | 000 | 0010 1 | 011 0011 |

First: b3 indicates the lowest 7 bits are 011 0011

![image-20240404131730064](https://raw.githubusercontent.com/Jingqing3948/FigureBed/main/mdImages/202404041317116.png)

Then: 40 indicates the highest 7 bits are 0100 000, so the instruction can only be SUB or SRA.

Then: 02 indicates the funct3 is 000, so the instruction is SUB.

rs2: 0 0111 (x7)

rs1: 0011 0 (x6)

rd:  0010 1 (x5)

So the instruction is: SUB x5, x6, x7 (x5=x6-x7).

### Another instruction decode

decode: b3 05 95 00

Because of little endian: decode 00 95 05 b3

| data | funct7 | rs2 | rs1 | funct3 | rd | opcode |
| :----: | :----: | :----: | :----: | :----: | :----: | :----: |
|  00 95 05 b3 | 0000 000 | 0 1001 | 0101 0 | 000 | 0101 1 | 011 0011 |

From above pic we can easily find out it is add instruction.

rs2: x9

rs1: x10

rd:  x11

So the instruction is: ADD x11, x10, x9 (x11=x10+x9).

## 5.2

the asm and gdbinit file can be found in this folder.

compile:

```shell
riscv64-unknown-elf-gcc  -nostdlib -fno-builtin -march=rv32g -mabi=ilp32 -g -Wall 5-2.s  -Ttext=0x80000000 -o test.elf
```

qemu:

```shell
qemu-system-riscv32 -nographic -smp 1 -machine virt -bios none -kernel test.elf -s -S 
```

gdb:

```shell
$ gdb-multiarch test.elf -q -x ./gdbinit

warning: /home/jingqing3948/tools/pwndbg/gdbinit.py: 没有那个文件或目录
Reading symbols from test.elf...
Breakpoint 1 at 0x80000000: file 5-2.s, line 5.
0x00001000 in ?? ()
=> 0x00001000:  97 02 00 00     auipc   t0,0x0
1: /z $x1 = 0x00000000
2: /z $x2 = 0x00000000
3: /z $x3 = 0x00000000
4: /z $x4 = 0x00000000
5: /z $x5 = 0x00000000

Breakpoint 1, _start () at 5-2.s:5
5               li x2, 1                # x2 = 1
=> 0x80000000 <_start+0>:       13 01 10 00     li      sp,1
1: /z $x1 = 0x00000000
2: /z $x2 = 0x00000000
3: /z $x3 = 0x00000000
4: /z $x4 = 0x00000000
5: /z $x5 = 0x80000000
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
stop () at 5-2.s:12
12              j stop                  # Infinite loop to stop execution
=> 0x80000014 <stop+0>: 6f 00 00 00     j       0x80000014 <stop>
1: /z $x1 = 0x00000003
2: /z $x2 = 0x00000001
3: /z $x3 = 0x00000002
4: /z $x4 = 0x00000000
5: /z $x5 = 0x00000003
(gdb) c
Continuing.
```