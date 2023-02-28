.section .rodata

str01: .string "Hello"

.data

# int val = 432;
.globl val
.align 4

val: .long 432

# short age = 4;
.globl age
.align 2

age: .word 4

# int r = 0;
.globl r
.align 4

r: .long 0

# long err = 2048;
.globl err
.align 8

err: .quad 2048


.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # val = sum("Hello" => %rdi, val => %esi, age => %dx, &r => %rcx);
   movq str01, %rdi # "Hello" => %rdi
   movl val, %esi # val => %esi
   movw age, %dx # age => %dx
   movq $r, %rcx # &r => %rcx
   call sum
   
   movl %eax, val

   # show(err => %rdi, val => %esi, r => %edx);
   movq err, %rdi # err => %rdi
   movl val, %esi # val => %esi
   movl r, %edx # r => %edx
   call show

   # return 0;
   movl $0, %eax

   leave

   ret
