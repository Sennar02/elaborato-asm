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

    movl $0, %eax           # Azzera il risultato.
    movl 8(%ebp), %ebx      # Puntatori a carattere.
    movl 12(%ebp), %ecx
    movl 16(%ebp), %edx     # Quantità massima di iterazioni.

    strncmp_loop:
        cmpl $0, %edx           # Confronta il contatore con 0.
        jle  strncmp_diff       # Se è minore o uguale a 0 esce dal ciclo.
        decl %edx               # Decrementa il contatore.
        movb (%ebx), %al        # Copia il primo puntato.
        cmpb $0, %al            # Confronta il primo puntato con '\0'
        je   strncmp_diff       # Se è uguale a '\0' calcola la differenza.
        cmpb (%ecx), %al        # Confronta il primo puntato con il secondo.
        jne  strncmp_diff       # Se sono diversi calcola la differenza.
        incl %ebx               # Incrementa i puntatori.
        incl %ecx
        jmp strncmp_loop

    strncmp_diff:
        movb (%ebx), %al    # Copia il primo valore puntato.
        subb (%ecx), %al    # Restituisce la sottrazione.

    strncmp_epilogue:
        /* Ripristino dei registri. */
        pop %edx
        pop %ecx
        pop %ebx
        /* Ripristino del base ptr. */
        pop %ebp
        ret
