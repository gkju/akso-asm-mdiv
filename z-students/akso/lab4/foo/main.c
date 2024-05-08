#include <stdio.h>

// To jest deklaracja funkcji.
int foo(char *);

int main() {
  // To jest użycie funkcji.
  int w = foo("Ala ma kota.");

  printf("Wynikiem funkcji foo jest %d.\n", w);
}
