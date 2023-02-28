.section .rodata

# #define LEN 4

# #define LIM 10

.data

# int i = 0;
.globl i
.align 4

i: .long 0

# long bias = 256;
.globl bias
.align 8

bias: .quad 256

# unsigned char vet[LEN] = {12,3,20,8};
.globl vet
.align 1

vet: .byte 12, 3, 20, 8

.text

.globl main

main:

   pushq %rbp
   movq  %rsp, %rbp

   # Seu código aqui...

   # for (i = 0; i >= LEN; i++) goto endFor
   movl i, %r11d
for:

   cmpl $4, %r11d
   jge endFor

   # bias = filtro(vet[i] => %dil, LIM => %si, bias => %rdx);
   movq $vet, %r8
   movslq %r11d, %r9
   imull $1, %r9
   addq %r9, %r8  
   movb (%r8), %dil # vet[i] => %dil

   movw $10, %si # LIM => %si

   movq bias, %rdx # bias => %rdx

   movq %rax, bias

   incl %r11d
   jmp for

endFor:

   movl %r11d, i

   # return 0;
   movl $0, %eax

   leave

   ret