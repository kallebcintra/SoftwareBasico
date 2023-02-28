.section .rodata

.align 8
s: .double 0.0

.align 1
fmt: .string "Soma %f maior que o limite %f (%d)\n"

.data


.text

.globl sum

sum:

    pushq %rbp
    movq %rsp, %rbp

    subq $64, %rsp

    movq %rbx, -8(%rbp)
    movl $4, %ebx        # int i = 4

    movsd s, %xmm1       # %xmm1 -> s = 0.0
    movsd %xmm1, -72(%rbp)

    movl $5, -24(%rbp)
    movl $6, -20(%rbp)
    movl $7, -16(%rbp)
    movl $8, -12(%rbp)

    # double vd[4] -> -56(%rbp)

    movsd %xmm0, -64(%rbp)   # Salvando limit

    leaq -24(%rbp), %rdi
    leaq -56(%rbp), %xmm0
    movsd -64(%rbp), %xmm1

    call mult

    movsd -72(%rbp), %xmm1

while:
    movq -8(%rbp), %ebx
    cmpl $0, %ebx
    jle endWhile

    decl %ebx

    leaq -56(%rbp), %r8
    cvtsi2sd %ebx, %r9
    imull $8, %r9
    addsd %r9, %r8
    movsd (%r8), %xmm1

if:
    ucomisd %xmm0, %xmm1
    jp endIf
    jbe endIf

    movsd %xmm1, -72(%rbp)

    movq $fmt, %rdi
    movsd %xmm1, %xmm0
    movsd -64(%rbp), %xmm1
    movl %ebx, %esi
    movl $2, %eax

    call printf

endIf:

    jmp while
endWhile:

    movl -72(%rbp), %eax
    movq -8(%rbp), %rbx

    leave
    ret
