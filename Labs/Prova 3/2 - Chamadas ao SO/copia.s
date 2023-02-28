# struct handler_s
#
# 0    4    8      16       24
# +----+----+------+---------+
# | fd |####| size | *buffer |
# +----+----+------+---------+


.section .rodata


.data


.text

.globl myopen
myopen:

    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %r8

    movq %rsi, %rdi
    movq %edx, %esi
    movq $0, %rdx
    movq $2, %rax
    syscall

    movl %eax, 0(%rdi)

    leave
    ret

.globl myread
myread:

    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %r8

    movl 0(%r8), %edi
    movq 16(%r8), %rsi
    movq 8(%r8), %rdx
    movq $0, %rax
    syscall

    leave
    ret

.globl mywrite
mywrite:

    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %r8
    movq %rsi, %r9

    movl 0(%r8), %edi
    movq 16(%r8), %rsi
    movq %r9, %rdx
    movq $1, %rax
    syscall

    leave
    ret

.globl myclose
myclose:

    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %r8

    movq 0(%r8), %edi
    movq $3, %rax
    syscall

    leave
    ret