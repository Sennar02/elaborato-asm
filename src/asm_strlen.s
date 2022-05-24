/**
 * @file asm_strlen.s
 *
 * @brief Calcola la lunghezza di una stringa terminata
          escludendo il carattere '\0'.

 * @param str Stringa.
 * @return Lunghezza della stringa passata.
 */

.text

/* Esportazione della funzione "asm_strlen". */
.global asm_strlen
.type asm_strlen, @function

asm_strlen:
    strlen_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi

    movl 8(%ebp), %esi      # Copia la stringa.

    movl %esi, %eax         # Copia la stringa in EAX.

    strlen_loop:
        cmpb $0, (%esi)         # Confronta il carattere con '\0'.
        je   strlen_diff        # Se è uguale a '\0' esce dal ciclo.

        incl %esi               # Posiziona il puntatore al prossimo carattere.
        jmp  strlen_loop

    strlen_diff:
        subl %eax, %esi         # Calcola la differenza tra i puntatori.
        movl %esi, %eax         # Restituisce la differenza.

    strlen_epilogue:
        /* Ripristino registri. */
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
