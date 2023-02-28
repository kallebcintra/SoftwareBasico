.section .rodata

fmt: .string "Valor: x = %ld, i = %d\n"

.section .data

# long x = 10;
.globl x
.align 8

x: .quad 10

.section .text

.globl aux

aux:

   poshq %rbp
   movq %rsp, %rbp

   # Aloca 16 bytes na pilha
   subq $16, %rsp

   # Salva os registradores callee-saved (verdes)
   movq %r14, -8(%rbp) 
   movq %r15, -16(%rbp)

   # Move parâmetros para registradores callee-saved
   # Isso garante que ao chamar qualquer função, os valores
   # desses registradores serão mantidos
   movq %rdi, %r14 # r14 = i
   movq %rsi, %r15 # r15 = ptr

   # x = 5;
   movq $5, x

   # printf("Valor: x = %ld, i = %d\n", x, i);
   movq $fmt, %rdi
   movq x, %rsi
   movl %r14d, %edx
   movl $0, %eax
   call printf

   # return x + i + *ptr;
   movslq %r14d, %rax
   addq x, %rax
   addq (%r15), %rax

   # Recupera os registradores callee-saved (verdes)
   # Retorna para a função chamadora do jeito que recebeu
   movq -8(%rbp), %r14
   movq -16(%rbp), %r15


   leave
   ret
