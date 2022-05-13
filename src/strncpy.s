.text

/* Esportazione della funzione "strncpy". */
.global strncpy
.type strncpy, @function

strncpy:
    strncpy_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi
    movl 12(%ebp), %edi
    movl 16(%ebp), %ebx

    movl %ebx, %edx

    test %ebx, %ebx
    jz   strncpy_return

    strncpy_loop:
        test %ebx, %ebx
        jz   strncpy_return
        decl %ebx

        movb (%esi), %al
        incl %esi
        movb %al, (%edi)
        incl %edi

        test %al, %al
        jnz  strncpy_loop

    strncpy_return:
        movl 12(%ebp), %eax

    strncpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
