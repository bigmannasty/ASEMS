#!/bin/bash

nasm -I /home/root/ASEMS -o main test.asm

if [[ -x main ]]
then
	./main
else
	chmod u+x main
	./main
fi
