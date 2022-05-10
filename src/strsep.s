.text

/* Esportazione della funzione "strsep". */
.global strsep
.type strsep, @function

strsep:
    strsep_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Allocazione variabili. */
        subl $4, %esp
        /* Salvataggio registri. */
        push %ebx
        push %edx

    movl 8(%ebp), %eax      # Puntatore a stringa.
    movb 12(%ebp), %dl      # Carattere separatore.

    cmpl $0, %eax           # Confronta il puntatore con NULL.
    je   strsep_epilogue    # Se è uguale a NULL esce dalla funzione.
    cmpb $0, (%eax)         # Confronta il valore puntato con NULL.
    je   strsep_epilogue    # Se è uguale a NULL esce dalla funzione.

    movl (%eax), %ebx       # Copia l'indirizzo del primo carattere.
    movl %ebx, -4(%ebp)     # Salva l'indirizzo del primo carattere.

    strsep_loop:
        cmpl $0, %ebx           # Confronta il puntatore con NULL.
        je   strsep_if          # Se è uguale a NULL esce dal ciclo.
        cmpb $0, (%ebx)         # Confronta il valoure puntato con '\0'.
        je   strsep_if          # Se è uguale a '\0' esce dal ciclo.
        cmpb %dl, (%ebx)        # Confronta il puntato con il separatore.
        je   strsep_if          # Se è uguale al separatore esce dal ciclo.
        incl %ebx               # Incrementa il puntatore.
        jmp strsep_loop

    strsep_if:
        cmpb $0, (%ebx)         # Confronta il valore puntato con '\0'.
        je   strsep_else        # Se è uguale a '\0' prende l'altro ramo.
        movb $0, (%ebx)         # Termina la stringa con '\0'.
        addl $1, %ebx           # Incrementa il puntatore.
        movl %ebx, (%eax)       # Sostituisce l'indirizzo del primo carattere.
        jmp  strsep_ret

    strsep_else:
        movl $0, (%eax)         # Azzera il puntatore a stringa.

    strsep_ret:
        movl -4(%ebp), %eax     # Restituisce il vecchio puntatore.

    strsep_epilogue:
        /* Ripristino dei registri. */
        pop %edx
        pop %ebx
        /* Deallocazione variabili. */
        movl %ebp, %esp
        /* Ripristino del base ptr. */
        pop %ebp
        ret
