.text

/* Esportazione della funzione "strncmp". */
.global strncmp
.type strncmp, @function

strncmp:
    strncmp_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %ebx
        push %ecx
        push %edx

    movl 8(%ebp), %ebx      # Copia i puntatori a carattere.
    movl 12(%ebp), %edx
    movl 16(%ebp), %ecx     # Copia il numero massimo di iterazioni.

    movl $0, %eax           # Azzera il risultato.

    strncmp_loop:
        cmpl $0, %ecx           # Confronta il contatore con 0.
        jle strncmp_diff        # Se è minore o uguale esce dal ciclo.
        subl $1, %ecx           # Decrementa il contatore.
        movb (%ebx), %al        # Copia il primo puntato.
        cmpb $0, %al            # Confronta il primo puntato con '\0'
        je strncmp_diff         # Se è uguale calcola la differenza.
        cmpb (%edx), %al        # Confronta il primo puntato con il secondo.
        jne strncmp_diff        # Se sono diversi calcola la differenza.
        addl $1, %ebx           # Incrementa i puntatori.
        addl $1, %edx
        jmp strncmp_loop

    strncmp_diff:
        movb (%ebx), %al       # Copia il puntato.
        subb (%edx), %al       # Sottrae il secondo al primo.

    strncmp_epilogue:
        /* Ripristino dei registri. */
        pop %edx
        pop %ecx
        pop %ebx
        /* Ripristino del base ptr. */
        pop %ebp
        ret
