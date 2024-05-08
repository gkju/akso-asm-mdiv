CC = gcc
CFLAGS = -Wall -Wextra -std=c17 -fPIC

.PHONY: all clean

all: static dynamic

generator.o: generator.c generator.h
input-output.o: input-output.c input-output.h
main.o: main.c input-output.h generator.h

libgenerator.so: generator.o input-output.o
	gcc $(CFLAGS) -shared -o $@ $^

libgenerator.a: generator.o input-output.o
	ar -rcs $@ $^

static: main.o libgenerator.a
	gcc $(CFLAGS) -static -L. -o $@ $< -lgenerator

dynamic: main.o libgenerator.so
	gcc $(CFLAGS) -L. -o $@ $< -lgenerator 

clean:
	@rm -rf static dynamic *.a *.so *.o