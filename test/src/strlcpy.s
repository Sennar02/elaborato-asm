.text

/* Esportazione della funzione "strlcpy". */
.global asm_strlcpy
.type asm_strlcpy, @function

asm_strlcpy:
    strlcpy_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %edi
    movl 12(%ebp), %esi
    movl 16(%ebp), %ebx

    movl %ebx, %edx

    strlcpy_loop:
        decl %ebx
        cmpl $0, %ebx
        jle  strlcpy_term

        movb (%esi), %al
        incl %esi
        movb %al, (%edi)

        incl %edi

        test %al, %al
        jnz  strlcpy_loop

    strlcpy_term:
        cmpl $0, %edx
        jle  strlcpy_return
        movb $0, (%edi)

    strlcpy_return:
        movl %edi, %eax
        subl 8(%ebp), %eax

    strlcpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
