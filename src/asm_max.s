/**
 * @file asm_mean.s
 *
 * @brief Calcola la media.
 *
 * @param Somma di tutti i valori.
 * @param Numero di elementi.
 * @return Media approssimata per difetto.
 */

.text

/* Esportazione della funzione "asm_max". */
.global asm_max
.type asm_max, @function

asm_max:
    max_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %ebx

    movl 8(%ebp), %eax      # Copia il valore.
    movl 12(%ebp), %ebx     # Copia il massimo.

    max_body:
        cmpl %ebx, %eax     # Confronta il massimo con
        jl max_return       # Se il valore è minore scambia il massimo.

    max_return:
        movl %ebx, %eax     # Scambia il valore del massimo.

    max_epilogue:
        /* Ripristino registri. */
        pop %ebx
        /* Ripristino base ptr. */
        pop %ebp
        ret
