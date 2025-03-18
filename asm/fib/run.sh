#!/bin/bash

nasm -o fib fib.asm
./fib
echo $?
