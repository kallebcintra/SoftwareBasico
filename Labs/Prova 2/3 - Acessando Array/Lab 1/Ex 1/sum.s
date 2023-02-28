.data

# int s = 0;
.globl s
.align 4

s: .long 0

# int nums[4] = {65, -105, 111, 34};
.globl nums
.align 4

nums: .long 65, -105, 111, 34


.text

.globl sum

sum:

    pushq %rbp

    movq  %rsp, %rbp

    # int i = 0;
    movl $0, %ecx

    # while (i >= 4) goto depoisWhile
while:

    cmpl $4, %ecx
    jnl depoisWhile

    # s = s + nums[i];
    movq $vet, %rdx
    movslq %ecx, %r8
    imulq $4, %r8
    addq %rdx, %r8
    movl (%r8), %eax

    addl %eax, s

    # i++;
    incl %ecx

    jmp while

depoisWhile:

    leave

    ret
