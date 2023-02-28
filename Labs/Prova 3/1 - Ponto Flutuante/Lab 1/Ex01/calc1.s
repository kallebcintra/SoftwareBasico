.section .rodata


.data


.text

.globl calc1

calc1:

    pushq %rbp
    movq %rsp, %rbp

    cvtss2sd %xmm1, %xmm1

    movsd %xmm0, %xmm2   # %xmm2 -> a
    movsd %xmm1, %xmm3   # %xmm3 -> b

    addsd %xmm1, %xmm0   # %xmm0 -> (a+b)
    subsd %xmm3, %xmm2   # %xmm2 -> (a-b)

    mulsd %xmm2, %xmm0   # %xmm0 -> (a+b)*(a-b)

    leave
    ret
