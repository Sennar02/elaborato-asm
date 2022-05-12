.data
base: .long 10

.text

/* Esportazione della funzione "strtoi". */
.global strtoi
.type strtoi, @function

strtoi:
    strtoi_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    movl 8(%ebp), %esi

    xorl %eax, %eax
    xorl %edx, %edx

    strtoi_loop:
        xorl %ebx, %ebx
        movb (%esi), %bl
        subb $48, %bl

        cmpb $0, %bl
        jl   strtoi_epilogue
        cmpb $9, %bl
        jg   strtoi_epilogue

        mull base
        addl %ebx, %eax
        incl %esi
        jmp  strtoi_loop

    strtoi_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
