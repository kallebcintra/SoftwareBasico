.section .rodata

fmr: .string "a = %f, b = %f, e = %f\n"

.data


.text

.globl calc2

calc2:

    pushq %rbp
    movq %rsp, %rbp

    subq $16, %rsp

    # float a -> %xmm0
    # float b -> %xmm1

    movss %xmm0, -4(%rbp)
    movss %xmm1, -8(%rbp)

    cvtss2sd %xmm1, %xmm0
    call cos

    cvtss2sd -4(%rbp), %xmm2
    addsd %xmm0, %xmm2   # %xmm2 -> e

    movsd %xmm2, -16(%rbp)

    movq $fmt, %rdi
    movss -4(%rbp), %xmm0
    movss -8(%rbp), %xmm1
    # %xmm2 -> e
    movl $2, %eax

    call printf



    movss -8(%rbp), %xmm0

    leave
    ret
