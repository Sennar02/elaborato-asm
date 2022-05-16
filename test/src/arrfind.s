.text

/* Esportazione della funzione "arrfind". */
.global asm_arrfind
.type asm_arrfind, @function

asm_arrfind:
    arrfind_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    movl 8(%ebp), %esi      # Copia il primo parametro.

    xorl %ebx, %ebx

    arrfind_loop:
        cmpl %ebx, 12(%ebp)     # Confronta il contatore con "len".
        je   arrfind_default    # Se è uguale a "len" esce dal ciclo.

        push 16(%ebp)           # Carica i parametri nello stack.
        call strlen             # Chiama la funzione strlen.
        addl $4, %esp           # Scarica i parametri dallo stack.

        incl %eax

        push %eax               # Carica i parametri nello stack.
        push (%esi)
        push 16(%ebp)
        call asm_strncmp        # Chiama la funzione strncmp.
        addl $12, %esp          # Scarica i parametri dallo stack.

        test %eax, %eax         # Confronta il risultato con 0.
        jz   arrfind_result     # Se è uguale a 0 esce dal ciclo.
        incl %ebx
        addl $4, %esi
        jmp  arrfind_loop

    arrfind_result:
        movl %ebx, %eax         # Restituisce il contatore.
        jmp  arrfind_epilogue

    arrfind_default:
        movl $-1, %eax          # Restituisce -1.

    arrfind_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
