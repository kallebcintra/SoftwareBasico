# struct produto_s
#
# 0    4    8       16
# +----+----+-------+
# | id |####| value |
# +----+----+-------+

.section .rodata

.align 8
m: .double 0.0

.data


.text

.globl max

max:

    pushq %rbp
    movq %rsp, %rbp

    subq $32, %rsp

    # double m = 0.0 -> -8(%rbp) | %xmm5
    movsd m, %xmm5

    # Salvando produto_s *ptr

while:
    cmpl, $0, (%rdi)
    je endwhile

    movsd %xmm5, -8(%rbp)
    movq %rdi, -24(%rbp)

    movsd 8(%rdi), %rdi
    call floor              # %xmm0 -> double tmp

if:
    movsd m, %xmm5
    ucomisd %xmm0, %xmm5
    jae endif

    movsd %xmm0, %xmm5

endif:
    leaq -24(%rbp), %rdi
    addq $16, %rdi

    jmp while
endwhile:

    movsd %xmm5, %xmm0

    leave
    ret
