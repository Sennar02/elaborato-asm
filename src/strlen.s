.text
.global strlen

.type strlen, @function

strlen:
    push %ebp
    movl %esp, %ebp

    push %ebx
    movl -8(%ebp), %ebx     # Copia il puntatore a carattere in %ebx
    decl %ebx
    movl $0, %eax

    strlen_loop:
        incl %ebx
        cmpl $0, %ebx           # Se il puntatore è uguale a NULL
        je strlen_exit          # esce dal ciclo
        cmpb $0, (%ebx)         # Se il valore puntato è uguale a '\0'
        jne strlen_loop         # controlla il carattere successivo

    incl %ebx
	movl -8(%ebp), %eax     # Copia il puntatore a carattere in %eax
    subl %eax, %ebx         # Sottrae %eax da %ebx
	movl %ebx, %eax

    strlen_exit:
        pop %ebx
        pop %ebp
        ret         # Torna al chiamante
