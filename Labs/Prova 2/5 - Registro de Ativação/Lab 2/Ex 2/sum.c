#include <stdlib.h>
#include <stdio.h>


void sum(short *a1 /* %rdi */, int p1 /* %esi */, long *a2 /* %rdx */, int p2 /* %ecx */)
{

  p1 = (int)a1[p1] + 1;

  p2 = (int)a2[p2] + 1;

  printf("%d\n", p1 + p2);

}