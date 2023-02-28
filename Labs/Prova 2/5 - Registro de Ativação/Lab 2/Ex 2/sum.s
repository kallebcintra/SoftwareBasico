.section .rodata

fmt: .string "%d\n"

.section .data


.section .text

.globl sum

sum:

   pushq %rbp
   movq %rsp, %rbp

   # Alocação de espaço na pilha
   subq $16, %rsp

   # Salvando os valores atuais dos registradores callee-saved que serão usados, na pilha
   movq %rbx, -8(%rbp)
   movq %r12, -16(%rbp)

   # Passando os valores de 'p1' e 'p2' para os registradores salvos
   movl %esi, %ebx    # p1
   movl %ecx, %r12d   # p2

   # p1 = (int)a1[p1] + 1;  (a1 -> %rdi) (p1 -> %ebx)
   movl (%rdi), %r8d
   imull $2, %ebx
   addl %ebx, %r8d
   movl (%r8d), %ebx
   addl $1, %ebx

   # p2 = (int)a2[p2] + 1;  (a2 -> %rdx) (p2 -> %r12d)
   movl (%rdx), %r9d
   imull $8, %r12d
   addl %r12d, %r9d
   movl (%r9d), %r12d
   addl $1, %r12d

   addl %r12d, %ebx

   # printf("%d\n", p1 + p2);
   movq $fmt, %rdi
   movl %ebx, %esi
   movl $0, %eax
   call printf

   # Traz de volta os valores salvos no começo, aos registradores, após terem sido usados
   movq -8(%rbp), %rbx
   movq -16(%rbp), %r12

   leave
   ret
