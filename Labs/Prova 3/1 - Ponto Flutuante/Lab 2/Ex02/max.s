# Para compilar utilize:  
#   gcc -no-pie -o max main2.c max.S  -lm

# struct produto_s
#
# 0      4      8        16
# +------+------+---------+
# |  id  |######|  value  |
# +------+------+---------+

.section .rodata

.align 8
m: .double 0.0

.section .data

.section .text

.globl max_prod

max_prod:

    pushq %rbp
    movq %rsp, %rbp

    subq $16, %rsp
    # ptr -> -8(%rbp)   | (%rdi)
    # m -> -16(%rbp)    | (%xmm5)

    # double m = 0.0
    movsd m, %xmm5

    # while(ptr->id)
while:
    ucomisd $0, 0(%rdi)
    je endWhile

    movsd %rdi, -8(%rbp)
    movsd %xmm5, -16(%rbp)

    # double tmp = floor(ptr->value);
    movsd 8(%rdi), %xmm0
    call floor

    movsd %xmm0, %xmm1        # %xmm1 -> tmp

    movsd -8(%rbp), %rdi      # %rdi -> ptr
    movsd -16(%rbp), %xmm5    # %xmm5 -> m


    # if (m < tmp) m = tmp;
if:
    ucomisd %xmm1, %xmm5
    jp endIf
    jae endIf

    movsd %xmm1, %xmm5
endIf:
    
    # ptr++;
    addq $16, %rdi           # 16 porque é o tamanho do ponteiro 'ptr' para a struct

    jmp while
endWhile:

    leave
    ret