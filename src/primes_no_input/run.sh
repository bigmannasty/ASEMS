#!/bin/bash

nasm -I /home/root/ASEMS -o main main.asm

if [[ -x main ]]
then
	./main
else
	chmod u+x main
	./main
fi
