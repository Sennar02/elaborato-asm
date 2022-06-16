/**
 * @file asm_strsep.s
 *
 * @brief Separa una stringa alla prima occorrenza del carattere passato.
 *
 * @param ptr Puntatore a un stringa.
 * @param sep Carattere separatore.
 * @return Pezzo della stringa dall'inizio fino al carattere passato.
 */

.text

/* Esportazione della funzione "asm_strsep". */
.global asm_strsep
.type asm_strsep, @function

asm_strsep:
    strsep_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il puntatore alla stringa.
    movb 12(%ebp), %bl      # Copia il carattere di separazione.

    movl (%esi), %edi       # Dereferenzia il puntatore.
    movl %edi, %eax         # Copia il puntatore deferenziato per il valore di ritorno.

    test %edi, %edi
    jz   strsep_epilogue

    strsep_loop:
        movb (%edi), %dl        # Copia l'n-esimo carattere della stringa in DL.

        test %dl, %dl           # Confronta il carattere con '\0'.
        jz   strsep_else        # Se è uguale a '\0' esce dal ciclo.
        cmpb %dl, %bl           # Confronta il carattere con il separatore.
        je   strsep_repl        # Se è uguale al separatore esce dal ciclo.

        incl %edi               # Incrementa il puntatore del carattere.
        jmp  strsep_loop

    strsep_repl:
        movb $0, (%edi)         # Termina la stringa con '\0'.
        incl %edi               # Incrementa il puntatore del carattere.
        movl %edi, (%esi)       # Sostituisce l'indirizzo del primo carattere.
        jmp  strsep_epilogue

    strsep_else:
        movl $0, (%esi)         # Azzera il puntatore a stringa.

    strsep_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
