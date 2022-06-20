/**
 * @file asm_strnrev.s
 *
 * @brief Ribalta un certo numero di caratteri di una stringa.
 *
 * @param str Stringa su cui operare.
 * @param num Numero di caratteri da ribaltare.
 *
 * @return Un puntatore alla stringa stessa.
 */

.text

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

    movl 8(%ebp), %esi      # Copia la stringa da ribaltare in %esi.
    movl %esi, %edi         # ed in %edi.

    addl 12(%ebp), %edi     # Sposta il secondo puntatore di num caratteri.

    strnrev_loop:
        cmpl %edi, %esi         # Se i due puntatori si incrociano.
        jge  strnrev_return     # allora esce dal ciclo.

        movb (%esi), %al        # Copia un carattere dall'inizio.
        movb (%edi), %bl        # Copia un carattere dalla fine.
        movb %bl, (%esi)        # Mette il carattere finale in testa.
        incl %esi               # Incrementa il puntatore al carattere successivo.
        movb %al, (%edi)        # Mette il carattere iniziale in coda.
        decl %edi               # Decrementa il puntatore al carattere precedente.
        jmp  strnrev_loop

    strnrev_return:
        movl 8(%ebp), %eax      # Restituisce il puntatore originale.

    strnrev_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
