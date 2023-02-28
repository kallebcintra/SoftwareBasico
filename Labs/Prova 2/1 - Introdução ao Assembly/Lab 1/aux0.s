# Não está pronto! Mas para testar o programa use: gcc -no-pie -o main-asm main01.c aux01.s

# Declaração de Variáveis Globais na Seção de dados
.section .data

# char c = -20;
.globl c

c: .byte -20

# int i = -256;
.globl i
.align 4

i: .long -256

# int j = 512;
.globl j
.align 4

j: .long 512

# long l = 128;
.globl l
.align 2

l: .word 128

# unsigned short us = 111;
.globl us
.align 2

us: .word 111

# unsigned int ui = 1024;
.globl ui
.align 4

ui: .long 1024

# unsigned long ul = 2048;
.globl ul
.align 8

ul: .quad 2048


# Código da função aux na Seção de Código
.section .text

.globl aux

aux:

    pushq %rbp

    movq  %rsp, %rbp



    # Se necessário, usar apenas os registradores (ou suas variações) abaixo:

    # %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11


    # Atribuições Simples

    # j = 68000;
    movl $68000, j

    # l = 4096;
    movw $4096, l

    # i = j;
    movl j, %eax
    movl %eax, i


    # Expressões

    # j = 10 + i - 5;

    subl $5, i # Subtrair a constante 10 a variável global 'i'
    movl i, %ecx # Mover o valor da variável global 'i' para registrador %ecx
    addl $10, %ecx # Somar 10 ao valor do registrador %ecx

    movl %ecx, j # Mover o valor do registrador %ecx para a variável global 'j'

    # i = (i * 2) - (j + 5);

    # (i * 2)
    movl i, %edx # Mover o valor de 'i' para o registrador %edx 
    imull $2, %edx # Multiplicar o valor do registraddor %edx por 2

    # (j + 5)
    movl j, %edi # Mover o valor de 'j' para o registrador %edi
    addl $5, %edi # Somar 5 ao valor do registrador %edi 

    # (i * 2) - (j + 5)
    subl %edi, %edx # Subtrair os valores de %edx e %edi
    # i = (i * 2) - (j + 5);
    movl i, %edx # Mover o valor da subtração presente em %edx para a variável global 'i'
    addl $5, j


    # Casts # Preciso aprender melhor sobre Casts

    # ui = i;
    movl i, %esi
    movl %esi, ui 

    # j = c;
    movb c, %r8d
    movl %r8d, j

    # ul = ui;
    movl ui, %r9
    movq %r9, ul

    # us = ul;

    # c = i + j;


    # Ponteiros # Preciso aprender um pouco melhor sobre Ponteiros

    # long *ptr;        // Utilize um registrador para representar 'ptr'

    # ptr = &l;

    # *ptr = 128;

    movq $l, %r10
    movl $128, (%r10)



    # int *iptr;        // Utilize um registrador para representar 'iptr'

    # iptr = &i;

    # j = j + *iptr;

    movl $i, %r11d
    addl (%r11d), j

    leave

    ret

