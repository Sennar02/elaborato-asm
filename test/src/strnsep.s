.text

.global asm_strnsep
.type asm_strnsep, @function

asm_strnsep:
    strnsep_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il puntatore all'array risultato.
    movl 12(%ebp), %ecx     # Copia la lunghezza dell'array.
    movl 16(%ebp), %edi     # Copia il puntatore a stringa da modificare.
    movl 20(%ebp), %ebx     # Copia il carattere separatore.

    xorl %edx, %edx

    strnsep_loop:
        push %edx

        push %ebx
        push %edi
        call asm_strsep
        addl $8, %esp

        pop %edx

        movl %eax, (%esi)
        addl $4, %esi

        test %eax, %eax
        jz   strnsep_repeat
        incl %edx

        strnsep_repeat:
            loop strnsep_loop

    movl %edx, %eax

    strnsep_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
