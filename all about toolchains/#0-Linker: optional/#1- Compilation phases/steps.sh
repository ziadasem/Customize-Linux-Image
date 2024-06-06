#!/bin/bash

echo "executing compilation steps, you can use single command 'gcc *.c -o program' but it will not generate the intermediate files"

#Step 1- preprocessing
gcc -E main.c -o main.i
echo "preprocessing is done"

#Step 2-Compiler
gcc  -S main.i -o main.S
echo "Compilation is done"

#Step 3- Assembler
gcc -c main.S -o main.o
echo "Assembly is done"

#Step 4- Linker
gcc main.o -o main.elf
echo "done, opening the program"

./main.elf
