.text

/* Esportazione della funzione "strncpy". */
.global mstrncpy
.type mstrncpy, @function

mstrncpy:
    strncpy_prologue:
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

    strncpy_loop:
        cmpl $0, %ebx
        jle  strncpy_return
        decl %ebx

        movb (%esi), %al
        incl %esi
        movb %al, (%edi)

        incl %edi

        test %al, %al
        jnz  strncpy_loop

    strncpy_return:
        movl %edi, %eax
        subl 8(%ebp), %eax

    strncpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
