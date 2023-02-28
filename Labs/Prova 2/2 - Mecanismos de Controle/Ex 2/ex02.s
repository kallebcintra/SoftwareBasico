.section .rodata


.data

# int  a = 0;
.globl a
.align 4

a: .long 0

# long b = 2;
.globl b
.align 8

b: .quad 2


.text

.globl ex01

ex01:

   pushq %rbp

   movq  %rsp, %rbp

   # Seu código aqui...

   # %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

   # # if(a == 0) goto endIf01
   cmpl $0, a
   je endIf01

   # # if(b >= 5) goto blcElse
   cmpq $5, b
   jge blcElse

   # b = (a << 1) + (a * b);
   movl a, %eax
   shll $1, %eax

   movslq a, %rcx
   imull b, %rcx

   movslq %eax, %rax
   addl %rdx, %rax

   movl  %rax, b

   jmp endIf02

   blcElse:

   # a = b ^ 0x1FL;
   movq b, %rax
   xorq $0x1FL, b

   movl %eax, a 

endIf02:

endIf01:

   leave

   ret
