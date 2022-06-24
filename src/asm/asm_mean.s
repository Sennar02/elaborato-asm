/**
 * @file asm_mean.s
 *
 * @brief Calcola un'approssimazione della media di un insieme di numeri.
 *
 * @param sum Somma di tutti i valori.
 * @param cnt Quantità di valori.
 *
 * @return La media approssimata per difetto.
 */

.text

.global asm_mean
.type asm_mean, @function

asm_mean:
    mean_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %ebx

    movl 8(%ebp), %eax      # Copia la somma.
    movl 12(%ebp), %ebx     # Copia la lunghezza.

    xorl %edx, %edx

    mean_calc:
        divl %ebx           # Divide la somma per la lunghezza.

    mean_epilogue:
        /* Ripristino registri. */
        pop %ebx
        /* Ripristino base ptr. */
        pop %ebp
        ret
