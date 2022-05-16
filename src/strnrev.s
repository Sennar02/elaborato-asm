.text

/* Esportazione della funzione "strnrev". */
.global asm_strnrev
.type asm_strnrev, @function

asm_strnrev:
    strnrev_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi
    movl 8(%ebp), %edi

    addl 12(%ebp), %edi

    strnrev_loop:
        cmpl %edi, %esi
        jge  strnrev_return

        movb (%esi), %al
        movb (%edi), %bl
        movb %bl, (%esi)
        movb %al, (%edi)

        incl %esi
        decl %edi
        jmp  strnrev_loop

    strnrev_return:
        movl 8(%ebp), %eax

    strnrev_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
