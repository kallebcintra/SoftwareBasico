.section .rodata

fmt: .string "Diferença em %d/%d: %ld\n"

.data

.globl prods
.align 24

prods: 
    # prod[0]
    .byte 0   # char mes +0
    .zero 7
    .quad 0   # long preço +8
    .int 0    # int ano +16
    .zero 4  
    # prod[1] 
    .byte 0   # char mes +24
    .zero 7
    .quad 0   # long preço +32
    .int 0    # int ano +40
    .zero 4   
    # +48

.text

.globl media

media:

   pushq %rbp
   movq %rsp, %rbp

   subq $16, %rbp

   movq %r12, -8(%rbp)
   movq %r13, -16(%rbp)

   movl $0, %r12d # int i = 0
   movq $0, %r13

   movl $0, %r12d # int i = 0, sem precisão, apenas para deixar o mais literal possível
for:
   movslq %r12d, %r8 # r8 = (long)i

   cmpq %rsi, %r8
   jge endfor

   # soma += ptr[i].preco;
   movslq %r12d, %r8 # r8 = (long)i
   imulq $24, %r8 # r8 = i * sizeof(produto)
   addq %rdi, %r8 # r8 = &ptr[i]

   movl 8(%r8), %r13 # sum += ptr[i].preco

   incl %r8d
   jmp for
endfor:

   movq %r13, %rax # rax = soma
   cqto # rdx = sinal
   idivq %rsi # rax = quociente

   movq -8(%rbp), %r12
   movq -16(%rbp), %r13

   leave
   ret

.globl main

main:

   pushq %rbp
   movq %rsp, %rbp

   subq $16, %rbp

   movl $0, %r8d  # int i = 0

   movl $prod, %r10

   movb $1, (%r10) # prods[0].mes   = JAN;
   movq $100, 8(%r10) # prods[0].preco = 100;
   movl $2020, 16(%10) # prods[0].ano   = 2020;

   addq $24, %r10

   movb $2, (%r10) # prods[1].mes   = FEV;
   movq $120, 8(%r10) # prods[1].preco = 120;
   movl $2020, 16(%r10) # prods[1].ano   = 2020;

   # long m = media(prods, SIZE);   // usar obrigatoriamente o registrador %r9 para 'm'
   movq $prods, %rdi
   movq $2, %rsi
   call media

   movl %rax, %r9

while:

   cmpl $2, %r8d
   jge endWhile

   
   movq %r8, -8(%rbp)
   movq %r9, -16(%rbp)

   # printf("Diferença em %d/%d: %ld\n", (int)prods[i].mes, prods[i].ano, prods[i].preco - m);
   movl $fmt, %rdi

   movl $prods, %r10
   movl %r8d, %r11
   imull $24, %r11
   addq %r10, %r11

   movbl (%r11), %esi
   movl 16(%r11), %edx

   movq 8(%r11), %rcx
   subq %r9, %rcx
   movl $0, eax
   call printf

   movq -8(%rbp), %r8
   movq -16(%rbp), %r9

   incl %r8d

   jmp while

endWhile:

   movl $0, %eax

   leave
   ret