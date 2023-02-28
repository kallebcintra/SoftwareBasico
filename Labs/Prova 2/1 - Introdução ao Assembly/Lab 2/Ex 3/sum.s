# Para testar o programa compile: gcc -no-pie -o sum01 sum01.s

.section .rodata

fmt: .string "Soma: %ld\n"


.section .data

# Definição das variáveis aqui...

# long sum = 0;
.globl sum
.align 8

sum: .quad 0

# long vet[5] = {10, 20, 30, 40, 50};
.globl vet
.align 8

vet: .quad 10, 20, 30, 40, 50


.section .text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # int i = 0; // => %ecx
   movl $0, %ecx
   
   # long *ptr = vet; // *ptr => (%r8)
   movq $vet, %r8

beginwhile:

   cmpl $5, %ecx
   jge  endwhile

   # sum = sum + *ptr;
   addq (%r8), sum

   # ptr++;
   incq %r8 # pode ser que seja (%r8), não sei

   # i++;
   incl %ecx

   jmp beginwhile

endwhile:

   movq $fmt, %rdi    # printf()

   movq sum, %rsi

   movl $0, %eax

   call printf


   movl $0, %eax      # return 0

   leave

   ret
