# Para testar, compile o programa junto com o arquivo "main.c":
#   gcc -no-pie -o e1-asm main02.c aux02.s

.data

# Definição da variável 'str'
.globl str
.align 1

str: .string "BEBAMUITOCAFE"


.text

.globl process

process:

   pushq %rbp

   movq  %rsp, %rbp

   # Inicialização de 'ptr'
   # char *ptr = str;
   movq $str, %r8 

beginwhile:

   cmpb $0, (%r8)
   je endwhile
   # Bloco do while

   # *ptr = *ptr + 32;
   addq $32, (%r8)
   # *ptr++;
   incq %r8

   jmp beginwhile

endwhile:

   leave

   ret

