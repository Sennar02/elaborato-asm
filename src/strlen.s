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

    movl 8(%ebp), %ebx      # Copia il puntatore a carattere.

    subl $1, %ebx           # Decrementa il puntatore.
    movl $0, %eax           # Azzera il risultato.

    strlen_loop:
        addl $1, %ebx           # Incrementa il puntatore.
        cmpl $0, %ebx           # Confronta il puntatore con NULL.
        je strlen_diff          # Se è uguale esce dal ciclo.
        cmpb $0, (%ebx)         # Confronta il puntato con '\0'.
        jne strlen_loop         # Se è uguale esce dal ciclo.

    strlen_diff:
        movl 8(%ebp), %eax      # Copia il puntatore originale.
        subl %eax, %ebx         # Calcola la differenza tra i due.
        movl %ebx, %eax         # Salva la differenza nel risultato.

    strlen_epilogue:
        /* Ripristino dei registri. */
        pop %ebx
        /* Ripristino del base ptr. */
        pop %ebp
        ret
