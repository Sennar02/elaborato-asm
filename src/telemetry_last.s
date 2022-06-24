/**
 * @file telemetry_last.s
 *
 * @brief Prende un vettore di interi e li trasforma in stringa
 *        separando i numeri con una ','.
 *
 * @param arr Array di interi.
 * @param src Puntatore alla destinazione.
 * @param dst Puntatore alla sorgente.
 */

.text

/* Esportazione della funzione "telemetry_last". */
.global telemetry_last
.type telemetry_last, @function

telemetry_last:
    telemetry_last_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il puntatore del primo elemento dell'array.
    movl 12(%ebp), %edi     # Copia il puntatore a src.
    movl 16(%ebp), %ebx     # Copia il puntatore a dst.

    movl $4, %ecx           # Inizializza il contatore a 4.
    movl $10, %edx          # Carica la base.

    telemetry_last_loop:
        push %ecx           # Salva il contatore.
        push %edx           # Salva la base.
        push %edi           # Carica la sorgente.
        push (%esi)         # Carica l'n-esimo valore dell'array.
        call asm_itostr     # Chiama la funzione asm_itostr.
        addl $8, %esp       # Scarica i parametri dallo stack.
        pop %edx            # Ripristina la base.
        pop %ecx            # Ripristina il contatore.

        push %edi           # Carica il numero convertito in stingra.
        call asm_strlen     # Chiama la funzione asm_strlen.
        addl $4, %esp       # Scarica i parametri dallo stack.

        push %edx           # Salva la base.
        push %eax           # Carica la dimensione di src.
        push %edi           # Carica il puntatore a src.
        push %ebx           # Carica il puntatore a dst.
        call asm_strncpy    # Chiama la funzione asm_strncpy.
        addl $12, %esp      # Scarica i parametri dallo stack.
        pop %edx            # Ripristina la base.

        addl %eax, %ebx     # Incrementa il puntatore della destinazione.

        decl %ecx           # Decrementa il contatore.

        test %ecx, %ecx         # Confronta il contatore con 0.
        jz telemty_last_term    # Se è uguale a 0, salta fuori dal ciclo.

        movl $44, (%ebx)        # Inserisce il carattere ','.

        addl $4, %esi           # Aggiorna l'indice dell'array.

        incl %ebx               # Incrementa il puntatore di dst.

        jmp telemetry_last_loop

    telemty_last_term:
        movl $10, (%ebx)        # Inserisce il carattere '\n'.
        incl %ebx               # Incrementa il puntatore di dst.

    telemetry_last_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
