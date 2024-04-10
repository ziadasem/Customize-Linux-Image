### Memory Segments
executing the following command to compile without linking
```
ziad@ziadpc:~/#1- Memory Sections$ gcc main.c -c -o main.o
```
then executing objdump to show the symbol table to ensure that the variables are stored in their sections
Notes: 
 - rw variables are under data section
 - local variables are not symbols as their lifetime is same as lifetime of its surrounded  scope (except static variables)

```
ziad@ziadpc:~/#1- Memory Sections$ objdump -t main.o
```
```main.o:     file format elf64-x86-64

SYMBOL TABLE:
0000000000000000 l    df *ABS*  0000000000000000 main.c
0000000000000000 l    d  .text  0000000000000000 .text
0000000000000008 l     O .bss   0000000000000004 staticBssVariable
0000000000000004 l     O .data  0000000000000004 staticRWVariable
0000000000000008 l     O .rodata        0000000000000004 constStateNonInit.3
000000000000000c l     O .rodata        0000000000000004 constStateInit.2
000000000000000c l     O .bss   0000000000000004 statData2.1
0000000000000008 l     O .data  0000000000000004 statData.0
0000000000000000 g     O .bss   0000000000000004 bssVaraible
0000000000000004 g     O .bss   0000000000000004 bssDataVariable
0000000000000000 g     O .data  0000000000000004 dataVariable
0000000000000000 g     O .rodata        0000000000000004 roVariable
0000000000000004 g     O .rodata        0000000000000004 roUnintVarable
0000000000000000 g     F .text  000000000000001d main
```
local variables aren't shown.
