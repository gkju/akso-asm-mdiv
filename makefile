CCFLAGS = -g -c -Wall -Wextra -std=c17 -O2
LDFLAGS = -z noexecstack

.PHONY: clean all
mdiv_example.o: mdiv_example.c

mdiv.o:
	nasm -f elf64 -F dwarf -g -w+all -w+error -o mdiv.o mdiv.asm

mdiv_example: mdiv_example.o mdiv.o
all: mdiv_example

clean:
	@rm *.o *.so