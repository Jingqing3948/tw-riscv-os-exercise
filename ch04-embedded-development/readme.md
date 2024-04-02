## 4.1

compile:

```shell
riscv64-linux-gnu-gcc -g  hello.c -o hello.o
```

file header:

```shell
readelf -h hello.o
ELF 头：
  Magic：   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  类别:                              ELF64
  数据:                              2 补码，小端序 (little endian)
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI 版本:                          0
  类型:                              DYN (Position-Independent Executable file)
  系统架构:                          RISC-V
  版本:                              0x1
  入口点地址：               0x5b0
  程序头起点：          64 (bytes into file)
  Start of section headers:          7600 (bytes into file)
  标志：             0x5, RVC, double-float ABI
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         10
  Size of section headers:           64 (bytes)
  Number of section headers:         35
  Section header string table index: 34

```

section header table:

```shell
readelf -SW hello.o
There are 35 section headers, starting at offset 0x1db0:

节头：
  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        0000000000000270 000270 000021 00   A  0   0  1
  [ 2] .note.gnu.build-id NOTE            0000000000000294 000294 000024 00   A  0   0  4
  [ 3] .note.ABI-tag     NOTE            00000000000002b8 0002b8 000020 00   A  0   0  4
  [ 4] .gnu.hash         GNU_HASH        00000000000002d8 0002d8 000024 00   A  5   0  8
  [ 5] .dynsym           DYNSYM          0000000000000300 000300 0000c0 18   A  6   2  8
  [ 6] .dynstr           STRTAB          00000000000003c0 0003c0 00007d 00   A  0   0  1
  [ 7] .gnu.version      VERSYM          000000000000043e 00043e 000010 02   A  5   0  2
  [ 8] .gnu.version_r    VERNEED         0000000000000450 000450 000030 00   A  6   1  8
  [ 9] .rela.dyn         RELA            0000000000000480 000480 0000c0 18   A  5   0  8
  [10] .rela.plt         RELA            0000000000000540 000540 000030 18  AI  5  21  8
  [11] .plt              PROGBITS        0000000000000570 000570 000040 10  AX  0   0 16
  [12] .text             PROGBITS        00000000000005b0 0005b0 0000d8 00  AX  0   0  4
  [13] .rodata           PROGBITS        0000000000000688 000688 000015 00   A  0   0  8
  [14] .eh_frame_hdr     PROGBITS        00000000000006a0 0006a0 000014 00   A  0   0  4
  [15] .eh_frame         PROGBITS        00000000000006b8 0006b8 00002c 00   A  0   0  8
  [16] .preinit_array    PREINIT_ARRAY   0000000000001df8 000df8 000008 08  WA  0   0  1
  [17] .init_array       INIT_ARRAY      0000000000001e00 000e00 000008 08  WA  0   0  8
  [18] .fini_array       FINI_ARRAY      0000000000001e08 000e08 000008 08  WA  0   0  8
  [19] .dynamic          DYNAMIC         0000000000001e10 000e10 0001f0 10  WA  6   0  8
  [20] .data             PROGBITS        0000000000002000 001000 000008 00  WA  0   0  8
  [21] .got              PROGBITS        0000000000002008 001008 000048 08  WA  0   0  8
  [22] .bss              NOBITS          0000000000002050 001050 000008 00  WA  0   0  1
  [23] .comment          PROGBITS        0000000000000000 001050 00002b 01  MS  0   0  1
  [24] .riscv.attributes RISCV_ATTRIBUTES 0000000000000000 00107b 000033 00      0   0  1
  [25] .debug_aranges    PROGBITS        0000000000000000 0010ae 000030 00      0   0  1
  [26] .debug_info       PROGBITS        0000000000000000 0010de 00008c 00      0   0  1
  [27] .debug_abbrev     PROGBITS        0000000000000000 00116a 000043 00      0   0  1
  [28] .debug_line       PROGBITS        0000000000000000 0011ad 000062 00      0   0  1
  [29] .debug_frame      PROGBITS        0000000000000000 001210 000040 00      0   0  8
  [30] .debug_str        PROGBITS        0000000000000000 001250 0000a3 01  MS  0   0  1
  [31] .debug_line_str   PROGBITS        0000000000000000 0012f3 000054 01  MS  0   0  1
  [32] .symtab           SYMTAB          0000000000000000 001348 0006d8 18     33  54  8
  [33] .strtab           STRTAB          0000000000000000 001a20 000220 00      0   0  1
  [34] .shstrtab         STRTAB          0000000000000000 001c40 00016c 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), p (processor specific)

```

disassemble:

```shell
riscv64-linux-gnu-objdump -S hello.o

hello.o：     文件格式 elf64-littleriscv


Disassembly of section .plt:

0000000000000570 <.plt>:
 570:	00002397          	auipc	t2,0x2
 574:	41c30333          	sub	t1,t1,t3
 578:	a983be03          	ld	t3,-1384(t2) # 2008 <__TMC_END__>
 57c:	fd430313          	addi	t1,t1,-44
 580:	a9838293          	addi	t0,t2,-1384
 584:	00135313          	srli	t1,t1,0x1
 588:	0082b283          	ld	t0,8(t0)
 58c:	000e0067          	jr	t3

0000000000000590 <__libc_start_main@plt>:
 590:	00002e17          	auipc	t3,0x2
 594:	a88e3e03          	ld	t3,-1400(t3) # 2018 <__libc_start_main@GLIBC_2.34>
 598:	000e0367          	jalr	t1,t3
 59c:	00000013          	nop

00000000000005a0 <puts@plt>:
 5a0:	00002e17          	auipc	t3,0x2
 5a4:	a80e3e03          	ld	t3,-1408(t3) # 2020 <puts@GLIBC_2.27>
 5a8:	000e0367          	jalr	t1,t3
 5ac:	00000013          	nop

Disassembly of section .text:

00000000000005b0 <_start>:
 5b0:	022000ef          	jal	ra,5d2 <load_gp>
 5b4:	87aa                	mv	a5,a0
 5b6:	00002517          	auipc	a0,0x2
 5ba:	a8253503          	ld	a0,-1406(a0) # 2038 <_GLOBAL_OFFSET_TABLE_+0x10>
 5be:	6582                	ld	a1,0(sp)
 5c0:	0030                	addi	a2,sp,8
 5c2:	ff017113          	andi	sp,sp,-16
 5c6:	4681                	li	a3,0
 5c8:	4701                	li	a4,0
 5ca:	880a                	mv	a6,sp
 5cc:	fc5ff0ef          	jal	ra,590 <__libc_start_main@plt>
 5d0:	9002                	ebreak

00000000000005d2 <load_gp>:
 5d2:	00002197          	auipc	gp,0x2
 5d6:	22e18193          	addi	gp,gp,558 # 2800 <__global_pointer$>
 5da:	8082                	ret
	...

00000000000005de <deregister_tm_clones>:
 5de:	00002517          	auipc	a0,0x2
 5e2:	a2a50513          	addi	a0,a0,-1494 # 2008 <__TMC_END__>
 5e6:	00002797          	auipc	a5,0x2
 5ea:	a2278793          	addi	a5,a5,-1502 # 2008 <__TMC_END__>
 5ee:	00a78863          	beq	a5,a0,5fe <deregister_tm_clones+0x20>
 5f2:	00002797          	auipc	a5,0x2
 5f6:	a3e7b783          	ld	a5,-1474(a5) # 2030 <_ITM_deregisterTMCloneTable@Base>
 5fa:	c391                	beqz	a5,5fe <deregister_tm_clones+0x20>
 5fc:	8782                	jr	a5
 5fe:	8082                	ret

0000000000000600 <register_tm_clones>:
 600:	00002517          	auipc	a0,0x2
 604:	a0850513          	addi	a0,a0,-1528 # 2008 <__TMC_END__>
 608:	00002597          	auipc	a1,0x2
 60c:	a0058593          	addi	a1,a1,-1536 # 2008 <__TMC_END__>
 610:	8d89                	sub	a1,a1,a0
 612:	4035d793          	srai	a5,a1,0x3
 616:	91fd                	srli	a1,a1,0x3f
 618:	95be                	add	a1,a1,a5
 61a:	8585                	srai	a1,a1,0x1
 61c:	c599                	beqz	a1,62a <register_tm_clones+0x2a>
 61e:	00002797          	auipc	a5,0x2
 622:	a2a7b783          	ld	a5,-1494(a5) # 2048 <_ITM_registerTMCloneTable@Base>
 626:	c391                	beqz	a5,62a <register_tm_clones+0x2a>
 628:	8782                	jr	a5
 62a:	8082                	ret

000000000000062c <__do_global_dtors_aux>:
 62c:	1141                	addi	sp,sp,-16
 62e:	e022                	sd	s0,0(sp)
 630:	00002417          	auipc	s0,0x2
 634:	a2040413          	addi	s0,s0,-1504 # 2050 <completed.0>
 638:	00044783          	lbu	a5,0(s0)
 63c:	e406                	sd	ra,8(sp)
 63e:	e385                	bnez	a5,65e <__do_global_dtors_aux+0x32>
 640:	00002797          	auipc	a5,0x2
 644:	a007b783          	ld	a5,-1536(a5) # 2040 <__cxa_finalize@GLIBC_2.27>
 648:	c791                	beqz	a5,654 <__do_global_dtors_aux+0x28>
 64a:	00002517          	auipc	a0,0x2
 64e:	9b653503          	ld	a0,-1610(a0) # 2000 <__dso_handle>
 652:	9782                	jalr	a5
 654:	f8bff0ef          	jal	ra,5de <deregister_tm_clones>
 658:	4785                	li	a5,1
 65a:	00f40023          	sb	a5,0(s0)
 65e:	60a2                	ld	ra,8(sp)
 660:	6402                	ld	s0,0(sp)
 662:	0141                	addi	sp,sp,16
 664:	8082                	ret

0000000000000666 <frame_dummy>:
 666:	bf69                	j	600 <register_tm_clones>

0000000000000668 <main>:
#include <stdio.h>
int main()
{
 668:	1141                	addi	sp,sp,-16
 66a:	e406                	sd	ra,8(sp)
 66c:	e022                	sd	s0,0(sp)
 66e:	0800                	addi	s0,sp,16
	printf("hello world!\n");
 670:	00000517          	auipc	a0,0x0
 674:	02050513          	addi	a0,a0,32 # 690 <_IO_stdin_used+0x8>
 678:	f29ff0ef          	jal	ra,5a0 <puts@plt>
	return 0;
 67c:	4781                	li	a5,0
}
 67e:	853e                	mv	a0,a5
 680:	60a2                	ld	ra,8(sp)
 682:	6402                	ld	s0,0(sp)
 684:	0141                	addi	sp,sp,16
 686:	8082                	ret
```

## 4.2

```shell
riscv64-unknown-elf-gcc -march=rv32imac -mabi=ilp32 hello.c
qemu-riscv32 a.out
```

debug:

```shell
riscv64-unknown-elf-gcc -g -march=rv32imac -mabi=ilp32 hello.c
qemu-riscv32 -g 1234  a.out 
```

In another window:

```shell
riscv64-unknown-elf-gdb a.out 
```

```
set architecture riscv:rv32
target remote localhost:1235
b hello.c:5
c
```

```shell
riscv64-unknown-elf-gdb a.out 
GNU gdb (GDB) 14.1
Copyright (C) 2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "--host=x86_64-pc-linux-gnu --target=riscv64-unknown-elf".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...

warning: /home/jingqing3948/tools/pwndbg/gdbinit.py: 没有那个文件或目录
Reading symbols from a.out...
(gdb) set architecture riscv:rv32
The target architecture is set to "riscv:rv32".
(gdb) b hello.c:5
Breakpoint 1 at 0x10152: file hello.c, line 5.
(gdb) target remote localhost:1235
Remote debugging using localhost:1235
0x000100c2 in _start ()
(gdb) r
The "remote" target does not support "run".  Try "help target" or "continue".
(gdb) c
Continuing.

Breakpoint 1, main () at hello.c:5
5		return 0;
(gdb) c
Continuing.
[Inferior 1 (process 1) exited normally]
```

## 4.3

```makefile
# 为了理解方便这里我就用中文啦。有一位老师曾对我说，笔记就是为了让自己学习方便用的~
# SECTIONS 定义变量，定义出了所有需要编译的文件的目录。
SECTIONS = \
	code/asm \
	code/os \

# 设置默认编译选项，比如只输入 make 就是执行 make all
.DEFAULT_GOAL := all

# make all 用于编译所有目标，循环访问所有目录并编译其中文件
all :
	@echo "begin compile ALL exercises for assembly samples ......................."
	for dir in $(SECTIONS); do $(MAKE) -C $$dir || exit "$$?"; done
	@echo "compile ALL exercises finished successfully! ......"

# .PHONY 用于设置非文件对象
# clean 用于清理所有编译结果
.PHONY : clean
clean:
	for dir in $(SECTIONS); do $(MAKE) -C $$dir clean || exit "$$?"; done

# 编译幻灯片，通过 writer_pdf_Export 工具把 pptx 文件转为 pdf
.PHONY : slides
slides:
	rm -f ./slides/*.pdf
	soffice --headless --convert-to pdf:writer_pdf_Export --outdir ./slides ./docs/ppts/*.pptx
```

