/**
 * @file asm_strtoi.s
 *
 * @brief Converte una stringa in un intero di base 10.
 *
 * @param str Stringa da convertire.
 *
 * @return Numero intero nella base specificata.
 */

.text

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

    movl 8(%ebp), %esi      # Copia la stringa da convertire.

    xorl %eax, %eax
    xorl %ebx, %ebx
    movl $10, %ecx          # Copia la base del numero.

    strtoi_loop:
        movb (%esi), %bl        # Copia un carattere della stringa.
        subb $48, %bl           # Trasforma il carattere ASCII nel suo valore.

        cmpb $0, %bl            # Se il carattere è minore di 0.
        jl   strtoi_epilogue    # esce dalla funzione.
        cmpb $9, %bl            # Se il carattere è maggiore di 9.
        jg   strtoi_epilogue    # esce dalla funzione.

        mull %ecx               # Altrimenti moltiplica il numero per la base.
        addl %ebx, %eax         # Aggiunge il carattere
        incl %esi               # Incrementa il puntatore del carattere.
        jmp  strtoi_loop

    strtoi_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
