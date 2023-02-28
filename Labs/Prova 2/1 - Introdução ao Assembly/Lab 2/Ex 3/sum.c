#include <stdio.h>


long sum = 0;

long vet[5] = {10, 20, 30, 40, 50};


int main()
{
   int i = 0; // => %ecx

   long *ptr = vet; // *ptr => (%r8)

   while (i < 5)
   {
        sum = sum + *ptr;

        ptr++;

        i++;
   }

   printf("Soma: %ld\n", sum);

   return 0;
}