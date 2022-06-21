
.text

.global telemetry_loop
.type telemetry_loop, @function

telemetry_loop:
    tloop_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Allocazione variabili. */
        subl $68, %esp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    xorl %ecx, %ecx

    movl %ebp, %esi
    addl $8, %esi

    tloop_loop:
        /* Separa riga per riga. */
        push $10
        push %esi
        call asm_strsep
        /* Verifica che */
        test %eax, %eax
        jz   tloop_index

        leal %eax, %edi
        movl %ebp, %ebx
        subl $20, %ebx

        push $44
        push %edi
        push $5
        push %ebx
        call asm_strnsep

        tloop_index:


    tloop_epilogue:
        /* Ripristino registri. */
        /* Deallocazione variabili. */
        movl %ebp, %esp
        /* Ripristino base ptr. */
        pop %ebp
        ret
