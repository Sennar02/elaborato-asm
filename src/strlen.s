.text

/* Esportazione della funzione "strlen". */
.global strlen
.type strlen, @function

strlen:
    strlen_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %ebx

    movl $0, %eax           # Azzera il risultato.
    movl 8(%ebp), %ebx      # Puntatore a carattere.

    strlen_loop:
        cmpl $0, %ebx           # Confronta il puntatore con NULL.
        je   strlen_diff        # Se è uguale a NULL esce dal ciclo.
        cmpb $0, (%ebx)         # Confronta il puntato con '\0'.
        je   strlen_diff        # Se è uguale a '\0' esce dal ciclo.
        incl %ebx               # Incrementa il puntatore.
        jmp  strlen_loop

    strlen_diff:
        movl 8(%ebp), %eax
        subl %eax, %ebx         # Calcola la distanza tra i puntatori.
        movl %ebx, %eax         # Restituisce la differenza.

    strlen_epilogue:
        /* Ripristino dei registri. */
        pop %ebx
        /* Ripristino del base ptr. */
        pop %ebp
        ret
