/**
 * @file asm_strnrev.s
 *
 * @brief Ribalta una stringa di num caratteri.
 *
 * @param str Stringa.
 * @param num Numero di caratteri da ribaltare.
 * @return Stringa ribaltata di num caratteri passati.
 */

.text

/* Esportazione della funzione "asm_strnrev". */
.global asm_strnrev
.type asm_strnrev, @function

asm_strnrev:
    strnrev_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia la stringa.

    movl %esi, %edi         # Copia la stringa in EDI.
    addl 12(%ebp), %edi     # Somma alla stringa in EDI il numero di caratteri.

    strnrev_loop:
        cmpl %edi, %esi         # Confronta le due stringhe.
        jge  strnrev_return     # Se la stringa in EDI è maggiore di quella
                                # in ESI termina la funzione.

        # Scambia i caratteri
        movb (%esi), %al        # Salva il carattere puntato da ESI in AL.
        movb (%edi), %bl        # Salva il carattere puntato da EDI in BL.
        movb %bl, (%esi)
        movb %al, (%edi)

        incl %esi               # Incrementa il puntatore del carattere di ESI.
        decl %edi               # Decrementa il puntatore del carattere di EDI.
        jmp  strnrev_loop

    strnrev_return:
        movl 8(%ebp), %eax

    strnrev_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
