/**
 * @file asm_mean.s
 *
 * @brief Restituisce il massimo tra due interi.
 *
 * @param val Primo valore.
 * @param max Secondo valore.
 *
 * @return Il valore massimo.
 */

.text

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

    max_compare:
        cmpl %ebx, %eax     # Se il primo valore è minore del secondo.
        jl   max_return     # allora restituisce il secondo.
        jmp  max_epilogue   # Altrimenti restituisce il primo.

    max_return:
        movl %ebx, %eax     # Restituisce il secondo valore.

    max_epilogue:
        /* Ripristino registri. */
        pop %ebx
        /* Ripristino base ptr. */
        pop %ebp
        ret
