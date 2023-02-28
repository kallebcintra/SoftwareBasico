# struct Temperatura
#
# 0       1      8         16         20    24
# +-------+------+---------+-----------+----+
# | scale |######|  value  | repeated  |####|
# +-------+------+---------+-----------+----+

# struct Data
#
# 0     4      8
# +-----+------+
# | sum | fail |
# +-----+------+


.section .rodata

.align 4
sum: .float 0.0

fmt: .string "Fail: sum = %f, limit = %f, count = %d\n"


.section .data


.text
.globl collect

collect:

    pushq %rbp
    movq %rsp, %rbp

    subq $64, %rsp

    movq %r13, -52(%rbp)

    # Salvando os parâmetros recebido, na pilha para a chamada de funções
    movq %rdi, -8(%rbp)       # Salva ptr
    movss %xmm0, -12(%rbp)    # Salva limit
    movl %esi, -16(%rbp)      # Salva count

    # float sum = 0.0;
    movss sum, %xmm5
    movss %xmm5, -44(%rbp)

    # int i = 0;
    movl $0, %r13d

    # t_init(&t);
    leaq -40(%rbp), %rdi
    call t_init

    # Devolvendo os parâmetros para os registradores
    leaq -8(%rbp), %rdi
    movss -12(%rbp), %xmm0
    movl -16(%rbp), %esi
    movss -44(%rbp), %xmm5

while:
    cmpl %esi, %r13d
    jge endWhile

    # if(ptr[i].sum < limit)
if:
    movq %rdi, %r8              # r8 = ptr
    movslq %r13d, %r9           # r9 = (long)i
    imulq $8, %r9               # r9 = r9 * sizeof(data)
    addq %r8, %r9               # r9 = &ptr[i]
    movss 0(%r9), %xmm4         # xmm4 = ptr[i].sum

    ucomisd %xmm0, %xmm4
    jae endIf

    # sum = sum + (t.repeated * ptr[i].sum);
    cvtsi2ss -36(%rbp), %xmm3
    mulsd 0(%r9), %xmm3
    addss %xmm3, %xmm5

else:
    # Salvando os parâmetros recebido, na pilha para a chamada de funções
    movq %rdi, -8(%rbp)
    movss %xmm0, -12(%rbp)
    movl %esi, -16(%rbp)
    movss %xmm5, -44(%rbp)

    # printf("Fail: sum = %f, limit = %f, count = %d\n", (double)ptr[i].sum, (double)limit, count);
    movq $fmt, %rdi

    cvtsi2sd %xmm4, %xmm0

    cvtsi2sd %xmm5, %xmm1

    movl $2, %eax

    call printf

    # Devolvendo os parâmetros para os registradores
    leaq -8(%rbp), %rdi
    movss -12(%rbp), %xmm0
    movl -16(%rbp), %esi
    movss -44(%rbp), %xmm5

    # ptr[i].fail++;
    addq $8, 4(%r9)

endIf:
    incl %r13d
    jmp while

endWhile:
    movss %xmm5, %xmm0
    movq -52(%rbp), %r13

    leave
    ret
