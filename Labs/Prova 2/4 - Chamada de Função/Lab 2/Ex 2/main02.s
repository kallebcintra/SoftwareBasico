.section .rodata

fmt: .string "Iteração %d, v = %d\n"

.data

# int   i = 0;
.globl i
.align 4

i: .long 0

# short v = 0;
.globl v
.align 2

v: .word 0

# short vetA[5] = {28,42,16,23,47};
.globl vetA
.align 2

vetA: .word 28, 42, 16, 23, 47

# int   vetB[5] = {0,0,0,0,0};
.globl vetB
.align 4

vetB: .long 0, 0, 0, 0, 0


.text

.globl main

main:

   pushq %rbp
   movq  %rsp, %rbp
   
   # while (i >= 5) goto endWhile
while:
   movl i, %r10d
   cmpl $5, %r10d
   jge endWhile

   # v = vetA[i] << 2;
   movq $vetA, %rdx
   movslq i, %rcx
   imulq $2, %rcx
   addq %rdx, %rcx
   movl (%rcx), %r11w # vetA[i] => %r11w

   shll $2, %r11w # vetA[i] << 2
   movw %r11w, v # v = .^.

   # printf("Iteração %d, v = %d\n", i, (int)v);
   movq $fmt, %rdi
   movq i, %esi
   movswl v, %r8d
   movq %r8d, %edx
   movl $0, %eax
   call printf

   # process(i, v, &vetB[i]);
   movl i, %edi # i => %rdi
   movw v, %si # v => %si
   
   movq $vetB, %rdx
   movslq i, %rcx
   imulq $4, %rcx
   addq %rdx, %rcx
   movl (%rcx), %rdx # vetB[i] => %rdx

   call process

   # i++
   incl i

   jmp while

endWhile:

   # show(vetB, 5);
   movq vetB, %rdi
   movq $5, %rsi
   call show

   # return 0;
   movl $0, %eax

   leave

   ret
