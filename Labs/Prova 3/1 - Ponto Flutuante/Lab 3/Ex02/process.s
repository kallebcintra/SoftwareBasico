.section .rodata

.align 1
fmt: .string "copy[%d] = %f\n"

.data

.globl factor
.align 8
factor: .double 15.0

.globl vets
.align 4
vets: .float 1.0, 2.0, 3.0, 4.0, 5.0

.text
.globl main

main:

    pushq %rbp
    movq %rsp, %rbp

    subq $64, %rsp

    movq %rbx, -8(%rbp)     # Salvando o valor de %rbx
    movq %r12, -16(%rbp)    # Salvando o valor de %r12
    movq %r13, -64(%rbp)    # Salvando o valor de %r13

    movl $0, %ebx             # %ebx -> j

    movq $50, %r12            # %r12 -> drop

    movl $0, %r13d            # %r13d -> i
for1:
    cmpl $5, %r13d
    jge endFor1

    movl $vets, %xmm1
    cvtsi2ss %r13d, %xmm2
    imull $4, %xmm2
    addss %xmm2, %xmm1
    movss (%xmm1), %xmm2

    cvtss2sd %xmm2, %xmm2

    mulsd factor, %xmm2   # %xmm2 -> tmp

    if:
        cvtsi2sdq %r12, %xmm3
        ucomisd %xmm3, %xmm2
        jae endIf

        leaq -56(%rbp), %xmm10
        incl %ebx
        cvtsi2sd %ebx, %xmm11
        mulsd $8, %xmm11
        addsd %xmm11, %xmm10
        
        movsd (%xmm2), %xmm10
    endIf:

    incl %r13d
    jmp for1

endFor1:




    movl $0, %r13d  # %r13d -> i
for2:
    cmpl %ebx, %r13d
    jge endFor2

    movq $fmt, %rdi
    movl %r13d, %esi

    leaq -40(%rbp), %rcx
    movslq %r13d, %rax
    imulq $8, %rax
    addq %rcx, %rax
    movsd (%rax), %xmm0

    movl $1, %eax

    call printf

    incl %r13d
endFor2:

    movq -8(%rbp), %rbx     # Devolvendo o valor de %rbx
    movq -16(%rbp), %r12    # Devolvendo o valor de %r12
    movq -64(%rbp), %r13    # Devolvendo o valor de %r13

    movl $0, %eax

    leave
    ret
