/**
 * @brief Inserisce i valori presenti in arr nella stringa dst.
 *
 * @param arr Array in cui vengono salvati i valori massimi
 *            di rpm, temperatura e velocità aggiungendo
 *            la velocità media.
 * @param src Stringa sorgente.
 * @param dst Stringa di destinazione.
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

    movl 8(%ebp), %esi      # Copia l'indirzzo del primo elemento dell'array.
    movl 12(%ebp), %edi     # Copia l'indirizzo della stringa sorgente.
    movl 16(%ebp), %ebx     # Copia l'indirizzo della stringa destinazione.

    movl $4, %ecx           # Inizializza il contatore a 4.
    movl $10, %edx          # Carica la base.

    telemetry_last_loop:
        push %ecx           # Salva il contatore.
        push %edx           # Salva la base.
        push %edi           # Carica l'indirizzo della stringa sorgente.
        push (%esi)         # Carica l'elemento dell'array.
        call asm_itostr     # Convete l'elemento da intero a stringa.
        addl $8, %esp       # Scarica i parametri dallo stack.
        pop %edx            # Ripristina la base.
        pop %ecx            # Ripristina il contatore.
        addl $4, %esi       # Aggiorna l'indice dell'array.

        push %edi           # Carica l'elemento convertito in stringa.
        call asm_strlen     # Calcola la lunghezza della stringa.
        addl $4, %esp       # Scarica i parametri dallo stack.

        push %edx           # Salva la base.
        push %eax           # Carica la dimensione di src.
        push %edi           # Carica l'indirizzo della stringa sorgente.
        push %ebx           # Carica l'indirizzo della stringa di destinazione.
        call asm_strncpy    # Copia la stringa sorgente.
        addl $12, %esp      # Scarica i parametri dallo stack.
        pop %edx            # Ripristina la base.

        addl %eax, %ebx     # Incrementa l'indirizzo della stringa destinazione.

        decl %ecx           # Decrementa il contatore.

        test %ecx, %ecx         # Se il contatore è uguale a 0
        jz telemty_last_term    # salta fuori dal ciclo.

        movl $44, (%ebx)        # Inserisce il carattere ','.

        incl %ebx               # Incrementa l'indirizzo della stringa di destinazione.

        jmp telemetry_last_loop

    telemty_last_term:
        movl $10, (%ebx)        # Inserisce il carattere '\n'.
        incl %ebx               # Incrementa l'indirizzo della stringa di destinazione.

    telemetry_last_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
