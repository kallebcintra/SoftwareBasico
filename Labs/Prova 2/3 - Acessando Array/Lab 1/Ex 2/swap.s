.data

# long last = 0;
.globl last
.align 8

last: .quad 0

# long values[5] = {50,-10,60,-20,70};
.globl values
.align 8

values: .quad 50, -10, 60, -20, 70

.text

.globl sum

sum:

    pushq %rbp

    movq  %rsp, %rbp

    # Seu código aqui...

    # int i;
    movl $0, %ecx

    # int j = 4;
    movl $4, %edx

    # for (i = 0; i >= j; i++, j--)
for:

    cmpl %edx, %ecx
    jge endFor

    # long tmp = values[i];
    movq $0, %r8

    movq $values %rdx
    movslq %ecx, %rcx
    imulq $8, %rcx
    addq %rdx, %rcx

    movq (%rcx), %r8  

    # values[i] = values[j];
    movq $values, %r9
    movslq %edx, %r10
    imulq $8, %r10
    addq %r9, %r10
    movl (%r10), %r11   # r11 = nums[j]

    movq $values %rdi
    movslq %ecx, %rsi
    imulq $8, %rsi
    addq %rdi, %rsi

    movq %r11, (%rsi)   # nums[i] = r11

    # values[j] = tmp;
    movq $values, %r9
    movslq %edx, %r10
    imulq $8, %r10
    addq %r9, %r10

    movq %r8, (%10)

    incl %ecx # i++
    decl %edx # j--

    jmp for

endFor:

    # last = values[4];
    movq $values, %rdi
    movq 32(%rdi), %rax
    movq %rax, last

    leave

    ret
