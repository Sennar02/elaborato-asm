/**
 * @file asm_strtoi.s
 *
 * @brief Converte una stringa in un intero.
 *
 * @param str Stringa da convertire.
 * @param base Base della conversione.
 * @return Numero intero.
 */

.text

/* Esportazione della funzione "asm_strtoi". */
.global asm_strtoi
.type asm_strtoi, @function

asm_strtoi:
    strtoi_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    movl 8(%ebp), %esi      # Copia la stringa.
    movl 12(%ebp), %ecx     # Copia la base.

    xorl %eax, %eax
    xorl %ebx, %ebx

    strtoi_loop:
        movb (%esi), %bl        # Copia il primo carattere della stringa in BL.
        subb $48, %bl           # Sottrae 48 per convertilo da ASCII a numero.

        cmpb $0, %bl            # Confronta il valore con 0.
        jl   strtoi_epilogue    # Se è minore di 0 termina la funzione.
        cmpb $9, %bl            # Confronta il valore con 9.
        jg   strtoi_epilogue    # Se è maggiore di 9 termina la funzione.

        mull %ecx               # Sfasa il risultato.
        addl %ebx, %eax         # Aggiunge il valore al risultato sfasato.
        incl %esi               # Incrementa il puntatore del carattere.
        jmp  strtoi_loop

    strtoi_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
