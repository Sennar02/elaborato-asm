.text

/* Esportazione della funzione "arrnfind". */
.global arrnfind
.type arrnfind, @function

arrnfind:
    arrnfind_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    movl 8(%ebp), %esi      # Copia il primo parametro.

    xorl %ebx, %ebx

    arrnfind_loop:
        cmpl %ebx, 12(%ebp)     # Confronta il contatore con "len".
        je   arrnfind_default   # Se è uguale a "len" esce dal ciclo.

        push 16(%ebp)           # Carica i parametri nello stack.
        call strlen             # Chiama la funzione strlen.
        addl $4, %esp           # Scarica i parametri dallo stack.

        incl %eax
        
        push %eax               # Carica i parametri nello stack.
        push (%esi)
        push 16(%ebp)
        call strncmp            # Chiama la funzione strncmp.
        addl $12, %esp          # Scarica i parametri dallo stack.

        test %eax, %eax         # Confronta il risultato con 0.
        jz   arrnfind_result    # Se è uguale a 0 esce dal ciclo.
        incl %ebx
        addl $4, %esi
        jmp  arrnfind_loop

    arrnfind_result:
        movl %ebx, %eax         # Restituisce il contatore.
        jmp  arrnfind_epilogue

    arrnfind_default:
        movl $-1, %eax          # Restituisce -1.

    arrnfind_epilogue:
        /* Ripristino dei registri. */
        pop %ebx
        pop %esi
        /* Deallocazione delle variabili. */
        pop %ebp
        ret
