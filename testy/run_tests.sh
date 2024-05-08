#!/bin/bash

#nasm -f elf64 -w+all -w+error -o mdiv.o mdiv.asm

#gcc -c -Wall -Wextra -std=c17 -O2 -o mdiv_example.o mdiv_example.c
#gcc -z noexecstack -o mdiv_example mdiv_example.o mdiv.o

#./mdiv_example

if [[ $# -eq 0 ]]; then
    echo Please provide an argument
    exit 1
fi

auto_tests () {
    echo "Running auto tests..."
    for ((i = 0; i < 1000; i++)) {
        python3 mdiv_rand_gen.py > test.in
        ./a < test.in > a.out
        python3 mdiv_brute.py < test.in > b.out
        diff -wq a.out b.out || break
        echo $i: correct!
    }
}

comp_asm () {
    nasm -f elf64 -g -F dwarf -w+all -w+error -o mdiv.o mdiv.asm
    
}

if [[ "$1" == "ver_naive_example" ]]; then
    gcc mdiv_example.c mdiv.c -o a
    ./a
    rm a
elif [[ "$1" == "ver_naive_auto" ]]; then
    gcc mdiv_tester.c mdiv.c -o a
    auto_tests

elif [[ "$1" == "ver_smart_auto" ]]; then
    gcc mdiv_tester.c mdiv2.c -o a
    auto_tests
elif [[ "$1" == "ver_smart_example" ]]; then
    gcc mdiv_example.c mdiv2.c -o a
    ./a
    rm a
elif [[ "$1" == "ver_asm_example" ]]; then
    comp_asm
    gcc -c -Wall -Wextra -std=c17 -O2 -o mdiv_example.o mdiv_example.c
    gcc -z noexecstack -o mdiv_example mdiv_example.o mdiv.o
    ./mdiv_example
elif [[ "$1" == "ver_asm_auto" ]]; then
    comp_asm
    gcc -c -Wall -Wextra -std=c17 -O2 -o mdiv_tester.o mdiv_tester.c
    gcc -z noexecstack -o a mdiv_tester.o mdiv.o
    auto_tests
else
    echo Incorrect arugment: choose one of ver_naive_example, ver_naive_auto, ver_smart_auto, ver_smart_example
fi
