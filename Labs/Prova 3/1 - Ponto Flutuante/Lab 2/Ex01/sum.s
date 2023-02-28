.section .rodata

.align 8
s: .double 0.0

fmt: .string "Soma %f maior que o limite %f (%d)\n"

.data

.text
.globl sum

sum: 

    pushq %rbp
    movq %rsp, %rbp

    subq $64, %rsp

    # int i = 4;
    movl $4, %esi
    movl %esi, -4(%rbp)

    # double s = 0.0;
    movsd s, %xmm10
    movsd %xmm10, -16(%rbp)

    # int vi[4] = {5,6,7,8};
    movl $5, -32(%rbp)
    movl $6, -28(%rbp)
    movl $7, -24(%rbp)
    movl $8, -20(%rbp)

    # double vd[4]; -> -64(%rbp)

    # double limit -> %xmm0
    movsd %xmm0, -72(%rbp)


    # mult(vi, vd, i);
    leaq -32(%rbp), %rdi
    leaq -64(%rbp), %xmm0
    call mult

    movl -4(%rbp), %r8d

    # while (i > 0)
while:
    cmpl $0, %r8d
    jle endwhile

    # s += vd[--i]
    # &vet + (i * sizeof(vet))
    leaq -64(%rbp), %xmm11
    decl %r8d
    cvtsi2sd %r8d, %xmm12
    imull $8, %xmm12
    addsd %xmm12, %xmm11

    movsd (%xmm11), %xmm12
    addsd %xmm12, %xmm10 # %xmm10 -> s

if: # s > limit
    movsd -72(%rbp), %xmm1
    ucomisd %xmm1, %xmm0
    jbe endif

    # printf("Soma %f maior que o limite %f (%d)\n", s, limit, i)
    movq $fmt, %rdi
    movsd %xmm10, %xmm0


endif:

    jmp while
endwhile:

    leave
    ret
