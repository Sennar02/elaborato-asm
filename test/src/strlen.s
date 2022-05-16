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
        push %esi

    movl 8(%ebp), %esi      # Copia il primo parametro.

    movl %esi, %eax

    strlen_loop:
        cmpb $0, (%esi)         # Confronta il carattere con '\0'.
        je   strlen_diff        # Se è uguale a '\0' esce dal ciclo.

        incl %esi
        jmp  strlen_loop

    strlen_diff:
        subl %eax, %esi         # Calcola la differenza tra i puntatori.
        movl %esi, %eax         # Restituisce la differenza.

    strlen_epilogue:
        /* Ripristino registri. */
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
