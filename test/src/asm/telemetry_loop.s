
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
    addl $12, %esi
    mov (%esi), -56(%ebp)

    tloop_loop:
        push %ecx
        /* Separa riga per riga. */
        push $10
        push %esi
        call asm_strsep
        addl $8, %esp
        /* Se la riga non è null. */
        test %eax, %eax
        jz   tloop_index
        /* Ottiene l'array e l'indirizzo della riga. */
        leal %eax, %edi
        movl %ebp, %ebx
        subl $20, %ebx
        /* Separa un'intera riga per la virgola. */
        push $44
        push %edi
        push $5
        push %ebx
        call asm_strnsep
        addl $16, %esp

        tloop_index:
            /* Traduce ad intero l'indice. */
            push -16(%ebp)
            call asm_strtoi
            addl $4, %esp
            /* Se è uguale all'indice da cercare. */
            cmpl %eax, 8(%ebp)
            jne  tloop_finish

            /* Traduce e riordina la prima stringa. */
            push -8(%ebp)
            call asm_strtoi
            movl %eax, -36(%ebp)
            /* Traduce e riordina la seconda stringa. */
            push -4(%ebp)
            call asm_strtoi
            movl %eax, -32(%ebp)
            /* Traduce e riordina la terza stringa. */
            push -12(%ebp)
            call asm_strtoi
            movl %eax, -28(%ebp)
            /* Copia il tempo. */
            push $7
            push -20(%ebp)
            push 16(%ebp)
            call asm_strncpy
            addl $12, %esp
            /* Sposta il puntatore esattamente di quanti
               caratteri ha copiato nella stringa. */
            addl %eax, 16(%ebp)
            /* Inserisce la virgola dopo il tempo. */
            movl 16(%ebp), %edi
            movb $44, (%edi)
            /* Ottiene l'indirizzo dell'array riordinato. */
            movl %ebp, %edi
            subl $36, %edi
            /* Chiama la funzione telemetry line. */
            push 16(%ebp)
            push %edi
            //! call telemetry_line
            addl $8, %esp
            /* Sposta il puntatore esattamente di quanti
               caratteri ha copiato nella stringa. */
            addl %eax, 16(%ebp)
            /* Calcola il massimo tra il valore memorizzato
               e quello appena tradotto. */
            push -36(%ebp)
            push -52(%ebp)
            call asm_max
            addl $8, %esp
            movl %eax, -52(%ebp)
            /* Calcola il massimo tra il valore memorizzato
               e quello appena tradotto. */
            push -32(%ebp)
            push -48(%ebp)
            call asm_max
            addl $8, %esp
            movl %eax, -48(%ebp)
            /* Calcola il massimo tra il valore memorizzato
               e quello appena tradotto. */
            push -28(%ebp)
            push -44(%ebp)
            call asm_max
            addl $8, %esp
            movl %eax, -44(%ebp)
            /* Calcola il massimo tra il valore memorizzato
               e quello appena tradotto. */
            push -28(%ebp)
            push -40(%ebp)
            call asm_max
            addl $8, %esp
            movl %eax, -40(%ebp)

            pop %ecx
            incl %ecx

    tloop_finish:
        xorl %edx, %edx
        movl -40(%ebp), %eax
        divl %ecx
        movl %eax, -40(%ebp)

        push 16(%ebp)
        push -56(%ebp)
        push -52(%ebp)
        //! call telemetry_last
        addl $12, %esp

    tloop_epilogue:
        /* Ripristino registri. */
        push %ebx
        push %edi
        push %esi
        /* Deallocazione variabili. */
        movl %ebp, %esp
        /* Ripristino base ptr. */
        pop %ebp
        ret
