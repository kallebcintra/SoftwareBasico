# struct Temperatura
#
# 0       1       8       16         24
# +-------+-------+-------+----------+
# | scale |#######| value | repeated |
# +-------+-------+-------+----------+

# struct Data
#
# 0     4      8
# +-----+------+
# | sum | fail |
# +-----+------+


.section .rodata

.align 4
sum: .float 0.0

.align 1
fmt .string "Fail: sum = %f, limit = %f, count = %d\n"

.data


.text

.globl collect

collect:

    pushq %rbp
    movq %rsp, %rbp

    subq $64, %rsp

    
    movss sum, %xmm5                        # float sum = 0.0

    # temperatura *t -> -52(%rbp)

    movq %rbx, -8(%rbp)                     # Salva %rbx
    movl $0, %ebx                           # %ebx -> int i = 0


    movss %xmm5, -12(%rbp)                  # Salva %xmm5 -> sum
    movq %rdi, -20(%rbp)                    # Salva %rdi -> Data *prt
    movss %xmm0, -24(%rbp)                  # Salva %xmm0 -> float limit
    movl %esi, -28(%rbp)                    # Salva %esi -> int count

    leaq -52(%rbp), %rdi                    # %rdi -> &t
    call t_init

    movss -12(%rbp), %xmm5                  # Recupera %xmm5 -> sum
    movq -20(%rbp), %rdi                    # Recupera %rdi -> Data *prt
    movss -24(%rbp), %xmm0                  # Recupera %xmm0 -> float limit
    movl -28(%rbp), %esi                    # Recupera %esi -> int count

while:
    cmpl %esi, %ebx                         # if(i >= count) -> endwhile
    jge endwhile

if:
    leaq %rdi, %r8                          # &prt -> %r8
    movlq %ebx, %r9                         # %r9 -> (long)i
    imulq $8, %r9                           # i * sizeof(ptr)
    addq %r8, %r9                           # %r9 -> &ptr + (i * sizeof(ptr)) | &ptr[i]

    movss 0(%r9), %xmm10                    # %xmm10 -> ptr[i].sum

    ucomiss %xmm0, %xmm10                   # if(ptr[i].sum >= limit) -> endIf
    jae endIf

    leaq -52(%rbp), %r8                     # %r8 -> &t
    cvttsi2ss 16(%r8), %xmm15               # %xmm15 -> (float)t.repeated
    mulss (%r9), %xmm15                     # %xmm10 -> (t.repeated * ptr[i].sum)
    addss %xmm15, %xmm5                     # %xmm5 -> sum + (t.repeated * ptr[i].sum)

else:

    movss %xmm5, -12(%rbp)                  # Salva %xmm5 -> sum
    movq %rdi, -20(%rbp)                    # Salva %rdi -> Data *prt
    movss %xmm0, -24(%rbp)                  # Salva %xmm0 -> float limit
    movl %esi, -28(%rbp)                    # Salva %esi -> int count

    movq $fmt, %rdi                         # %rdi -> "Fail: sum = %f, limit = %f, count = %d\n"

    leaq %rdi, %r8                          # &prt -> %r8
    movlq %ebx, %r9                         # %r9 -> (long)i
    imulq $8, %r9                           # i * sizeof(ptr)
    addq %r8, %r9                           # %r9 -> &ptr + (i * sizeof(ptr)) | &ptr[i]

    cvttss2sd 0(%r9), %xmm0                 # %xmm10 -> ptr[i].sum

    cvtss2ds -24(%rbp), %xmm1

    # %esi -> count

    movl $2, %eax

    call printf

    movss -12(%rbp), %xmm5                  # Recupera %xmm5 -> sum
    movq -20(%rbp), %rdi                    # Recupera %rdi -> Data *prt
    movss -24(%rbp), %xmm0                  # Recupera %xmm0 -> float limit
    movl -28(%rbp), %esi                    # Recupera %esi -> int count

    leaq %rdi, %r8                          # &prt -> %r8
    movlq %ebx, %r9                         # %r9 -> (long)i
    imulq $8, %r9                           # i * sizeof(ptr)
    addq %r8, %r9                           # %r9 -> ptr[i].fail -> &ptr + (i * sizeof(ptr)) | &ptr[i] 

    incl 4(%r9)                             #  ptr[i].fail++

endIf:

    incl %ebx
    jmp while
endwhile:

    movq -8(%rbp), %rbx                     # Salva %rbx
    movss %xmm5, %xmm0                      # return sum

    leave
    ret
