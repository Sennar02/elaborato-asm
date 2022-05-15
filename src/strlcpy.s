.text

/* Esportazione della funzione "strlcpy". */
.global strlcpy
.type strlcpy, @function

strlcpy:
    strlcpy_prologue:
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
    jz   strlcpy_term

    strlcpy_loop:
        decl %ebx
        test %ebx, %ebx
        jz   strlcpy_term

        movb (%esi), %al
        incl %esi
        movb %al, (%edi)

        incl %edi
        
        test %al, %al
        jnz  strlcpy_loop

    strlcpy_term:
        test %edx, %edx
        jz   strlcpy_return
        movb $0, (%edi)

    strlcpy_return:
        movl 12(%ebp), %eax

    strlcpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
