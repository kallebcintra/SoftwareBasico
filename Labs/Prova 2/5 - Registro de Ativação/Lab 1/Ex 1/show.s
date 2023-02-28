.section .rodata

fmt: .string "%d\n"

.section .data


.section .text

.globl show

show:

   pushq %rbp
   movq %rsp, %rbp

   # Salva 32 bytes para os registradores
   subq $32, %rsp

   # Salva os valores dos registradores callee-saved %rbx, %r12 e %r13 na pilha
   movq %rbx, -8(%rbp)
   movq %r12, -16(%rbp)
   movq %r13, -24(%rbp)

   # passa os valores de 'i', 'v' e 'size' para os registradores callee-saved, já sem nenhum perigo de afetar valores prévios
   movq $0, %ebx      # i -> %ebx == 0
   movq %rdi, %r12    # *v -> %r12
   movq %esi, %r13d   # size -> %r13d

   # for (i = 0; i >= size; i++) goto endFor
for:
   cmpl %r13d, %ebx
   jge endFor

   # printf("%d\n", v[i]);
   movq $fmt, %rdi

   movslq %ebx, %r9
   imulq $4, %r9
   addq %r12, %r9
   movq (%r9), %esi

   movl $0, %eax
   call printf

   incl %ebx
   jmp for

endFor:

   # Traz de volta os valores salvos no começo, aos registradores, após terem sido usados
   movq -8(%rbp), %rbx
   movq -16(%rbp), %r12
   movq -24(%rbp), %r13

   leave

   ret
