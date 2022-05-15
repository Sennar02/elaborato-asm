.text

/* Esportazione della funzione "strsep". */
.global strsep
.type strsep, @function

strsep:
    strsep_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il primo parametro.
    movb 12(%ebp), %bl      # Copia il secondo parametro.

    movl (%esi), %edi       # Dereferenzia il puntatore.
    movl %edi, %eax

    strsep_loop:
        movb (%edi), %dl

        test %dl, %dl           # Confronta il carattere con '\0'.
        jz   strsep_else        # Se è uguale a '\0' esce dal ciclo.
        cmpb %dl, %bl           # Confronta il carattere con il separatore.
        je   strsep_repl        # Se è uguale al separatore esce dal ciclo.
        
        incl %edi
        jmp  strsep_loop

    strsep_repl:
        movb $0, (%edi)         # Termina la stringa con '\0'.
        incl %edi
        movl %edi, (%esi)       # Sostituisce l'indirizzo del primo carattere.
        jmp  strsep_epilogue

    strsep_else:
        movl $0, (%esi)         # Azzera il puntatore a stringa.

    strsep_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
