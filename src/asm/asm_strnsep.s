/**
 * @file asm_strnsep.s
 *
 * @brief Spezza una stringa sul posto in base ad un certo
 *        carattere separatore più volte.
 *
 * @param arr Array in cui salvare i segmenti.
 * @param num Lunghezza dell'array.
 * @param ptr Indirizzo della stringa da spezzare.
 * @param sep Carattere separatore.
 *
 * @return Numero di separazioni non nulle.
 */

.text

.global asm_strnsep
.type asm_strnsep, @function

asm_strnsep:
    strnsep_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il puntatore all'array.
    movl 12(%ebp), %ecx     # Copia la lunghezza dell'array.
    movl 16(%ebp), %edi     # Copia il puntatore alla stringa.
    movl 20(%ebp), %ebx     # Copia il carattere separatore.

    xorl %edx, %edx

    strnsep_loop:
        test %ecx, %ecx         # Se sono state riempite tutte le celle.
        jz   strnsep_return     # esce dal ciclo.
        decl %ecx               # Altrimenti decrementa il contatore.

        push %edx               # Salva il valore nello stack.

        push %ebx               # Carica il carattere separatore.
        push %edi               # Carica il puntatore alla stringa.
        call asm_strsep         # Spezza la stringa.
        addl $8, %esp           # Scarica i due parametri dallo stack.

        pop %edx                # Riprende il valore dallo stack.

        movl %eax, (%esi)       # Inserisce il segmento nell'array.
        addl $4, %esi           # Incrementa l'array al puntatore successivo.

        test %eax, %eax         # Se il segmento non è nullo.
        jnz  strnsep_repeat     # allora ricomincia il ciclo.
        incl %edx               # Altrimenti incrementa il contatore di risultati non nulli.

        strnsep_repeat:
            jmp strnsep_loop

    strnsep_return:
        movl %edx, %eax         # Restituisce il numero di risultati non nulli.

    strnsep_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
