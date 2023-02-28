.section .rodata

fmt01: .string "'a' maior do que 'b'\n"

fmt02: .string "Valor de 'b': %d\n"

.data

# char a = 97;
.globl a
.align 1

a: .byte 97

# char b = 105;
.globl b
.align 1

b: .byte 105


.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # int ret = maximo(a, b);
   movb a, %dil
   movb b, %sil
   call maximo

   movl %eax, %r8d # Movendo o Valor de maximo(a, b) em %eax para %r8d que representa 'int ret'

   # # if( !(ret == a) ) goto blc_else
   movsbl a, %r11d
   cmpl %r11d, %r8d
   jne blc_else

   # printf("'a' maior do que 'b'\n");
   movq $fmt01, %rdi
   movl $0, %eax
   call printf

   jmp If01

blc_else:

   # printf("Valor de 'b': %d\n", (int)b);
   movq $fmt02, %rdi
   movsbl b, %esi
   movl $0, %eax
   call printf

If01:

   # return 0;
   movl $0, %eax

   leave

   ret
