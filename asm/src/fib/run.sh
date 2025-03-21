#!/bin/bash

nasm -I /home/root/vbs/stuf/asm -o main main.asm

if [[ -x main ]]
then
	./main
else
	chmod u+x main
	./main
fi
