# Compile o seu código usando:
#  gcc -no-pie -o ex01 main01.c ex01.S

.section .rodata


.data

# int a = 30;
.globl a
.align 4

a: .long 30

# int b = 45;
.globl b
.align 4

b: .long 45

# int c = -60;
.globl c
.align 4

c: .long -60

# int d = 25;
.globl d
.align 4

d: .long 25


.text

.globl ex01

ex01:

   pushq %rbp

   movq  %rsp, %rbp

   # %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

   movl a, %eax
   movl b, %ecx

   # # if(a <= b) goto endIf
   cmpl %ecx, %eax
   jle endIf

   # c = -c
   movl c, %edx
   negl %edx # Poderia fazer "imull $-1, %edx" ?
   movl %edx, c

   # d = c / 3
   movl c, %edi
   cltd
   movl $3, %ecx
   movl %edi, %eax # Poderia ter movido "c" direto para %eax
   idvl %ecx
   movl %eax, d

endIf:

   # # if(b < a) goto endIf2
   movl a, %r8d
   movl b, %r9d

   cmpl %r8d, %r9d # Por que não seria "cmpl %r9d, %r8d" ? 
   jl endIf2

   # c = (a + b) * c
   addl %r9d, %r8d
   imull c, %r8d
   movl %r8d, c

   # d = 1024
   movl $1024, d

endIf2:

   leave

   ret
