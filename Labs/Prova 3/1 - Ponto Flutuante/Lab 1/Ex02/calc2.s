.section .rodata

fmt: .string "a = %f, b = %f, e = %f\n"

.data

.text

.globl calc2

calc2:

    pushq %rbp
    movq %rsp, %rbp

    subq $16, %rbp

    movsd %xmm0, -4(%rbp)
    movsd %xmm1, -8(%rbp)

    # double e = a + cos(b); || float a -> %xmm0 | float b -> %xmm1
    cvtss2sd %xmm0, %xmm2 # %xmm2 -> (double)a

    cvtss2sd %xmm1, %xmm0 # %xmm0 -> (double)b
    call cos

    addsd %xmm0, %xmm2 # %xmm0 -> a + cos(b) ==> double e

    # printf("a = %f, b = %f, e = %f\n", a, b, e);
    movq $fmt, %rdi          # 1° Param
    movsd -4(%rbp), %xmm0    # 2° Param
    movsd -8(%rbp), %xmm1    # 3° Param
    # %xmm2 -> e             # 4° Param
    movsd $3, %eax           # 3 Pontos Flutuantes
    call printf

    # return b;
    movsd -8(%rbp), %xmm0

    leave
    ret
