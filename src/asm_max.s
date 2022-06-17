/**
 * @file asm_mean.s
 *
 * @brief Controlla qual è il massimo tra due valori.
 *
 * @param Primo valore.
 * @param Secondo valore.
 * @return Valore massimo.
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

    movl 8(%ebp), %eax      # Copia il primo valore.
    movl 12(%ebp), %ebx     # Copia il secondo valore.

    max_body:
        cmpl %ebx, %eax     # Confronta i due valori
        jl max_return       # Se il primo valore è minore lo scambia.

    max_return:
        movl %ebx, %eax     # Scambia il valore del massimo.

    max_epilogue:
        /* Ripristino registri. */
        pop %ebx
        /* Ripristino base ptr. */
        pop %ebp
        ret
