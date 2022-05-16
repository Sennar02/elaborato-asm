.text

/* Esportazione della funzione "itostr". */
.global itostr
.type itostr, @function

itostr:
    itostr_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi

    movl 8(%ebp), %eax
    movl 12(%ebp), %esi
    movl 16(%ebp), %ecx

    movl %esi, %edi

    test %eax, %eax
    jz   itostr_zero

    itostr_loop:
        xorl %edx, %edx
        divl %ecx
        addl $48, %edx
        movb %dl, (%esi)
        
        incl %esi

        test %eax, %eax
        jz   itostr_term
        jmp  itostr_loop

    itostr_zero:
        movb $48, (%esi)
        incl %esi

    itostr_term:
        movb $0, (%esi)

    movl %esi, %eax
    subl %edi, %eax
    decl %eax

    push %eax
    push %edi
    call strnrev
    addl $8, %esp

    itostr_epilogue:
        /* Ripristino registri. */
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
