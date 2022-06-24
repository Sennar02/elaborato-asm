/**
 * @file asm_strsep.s
 *
 * @brief Spezza una stringa sul posto in base ad un certo
 *        carattere separatore.
 *
 * @param ptr Indirizzo della stringa da spezzare.
 * @param sep Carattere separatore.
 *
 * @return Segmento iniziale della stringa.
 */

.text

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
    movb 12(%ebp), %bl      # Copia il carattere separatore.

    movl (%esi), %edi       # Copia il puntatore a stringa dereferenziato in %edi.
    movl %edi, %eax         # ed in %eax.

    test %edi, %edi         # Se la stringa è nulla.
    jz   strsep_epilogue    # allora esce dalla funzione.

    strsep_loop:
        movb (%edi), %dl        # Copia un carattere della stringa.

        test %dl, %dl           # Se il carattere è il terminatore.
        jz   strsep_else        # allora esce dal ciclo.
        cmpb %dl, %bl           # Se il carattere è uguale al separatore.
        je   strsep_repl        # allora esce dal ciclo.

        incl %edi               # Incrementa il puntatore al carattere successivo.
        jmp  strsep_loop

    strsep_repl:
        movb $0, (%edi)         # Termina la stringa.
        incl %edi               # Incrementa il puntatore al carattere successivo.
        movl %edi, (%esi)       # Fa puntare la stringa dopo il separatore.
        jmp  strsep_epilogue

    strsep_else:
        movl $0, (%esi)         # Altrimenti azzera il puntatore.

    strsep_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
