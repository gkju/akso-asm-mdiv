#include <stdio.h>

// To jest deklaracja funkcji.
void foo(int, long);

// To jest deklaracja funkcji.
void foo(int x, long y);

// To jest definicja funkcji.
void foo(int a, long b) {
  printf("Funkcja foo została wywołana z parametrami %d, %ld.\n", a, b);
}
