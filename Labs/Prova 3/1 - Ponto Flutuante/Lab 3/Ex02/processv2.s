.section .rodata


.data

.globl factor
.align 8

factor: .double 15.0

.globl vets
.align 4

vets .float 1.0, 2.0, 3.0, 4.0, 5.0

.text

.globl process

process:
    pushq %rbp
    movq %rsp, %rbp

    subq $_, %rsp

    movq %rbx, -8(%rbp)                     # Salva %rbx
    movq %r12, -16(%rbp)                    # Salva %r12
    movq %r13, -24(%rbp)                    # Salva %r13

    movl $0, %r12d                          # %r12d -> int j = 0
    movq $50, %r13                          # %r13 -> long drop = 50

    # double copy[5] -> -64(%rbp)

    movl $0, %ebx
for1:
    cmpl $5, %ebx                           # if(i >= 5) -> endFor1
    jge endFor1

    movq $vets, %r8
    movlq %ebx, %r9
    imulq $4, %r9
    addq %r8, %r9

    cvtsi2sd (%r9), %xmm1

    mulsd factor, %xmm1                       # %xmm1 -> double tmp = vets[i] * factor;

if:
    cvttsi2sd %r13, %xmm0                     # %xmm0 -> (double)drop
    ucomisd %xmm0, %xmm1                      if(tmp >= drop) -> endif
    jae endif

    incl %r12d

    leaq -64(%rbp), %xmm0
    cvtsi2sd %r12d, %xmm2
    mulsd $8, %xmm2
    addsd %xmm0, %xmm2
    movsd (%xmm2), %xmm0

    movsd %xmm1, %xmm2
endif:

endFor1:

for2:

endFor2:


    movq -8(%rbp), %rbx                     # Devolve %rbx
    movq -16(%rbp), %r12                    # Devolve %r12
    movq -24(%rbp), %r13                    # Devolve %r13

    leave
    ret