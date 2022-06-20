/**
 * @file asm_strlen.s
 *
 * @brief Calcola la lunghezza di una stringa
 *        escludendo il carattere terminatore.
 *
 * @param str Stringa su cui operare.
 *
 * @return La lunghezza.
 */

.text

.global asm_strlen
.type asm_strlen, @function

asm_strlen:
    strlen_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi

    movl 8(%ebp), %eax      # Copia la stringa in %eax.
    movl %eax, %esi         # ed in %esi.

    strlen_loop:
        cmpb $0, (%eax)         # Se il carattere equivale al terminatore.
        je   strlen_diff        # allora esce dal ciclo.
        incl %eax               # Incrementa il puntatore al carattere successivo.
        jmp  strlen_loop

    strlen_diff:
        subl %esi, %eax         # Restituisce la differenza tra i due puntatori.

    strlen_epilogue:
        /* Ripristino registri. */
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
