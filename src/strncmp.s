.text

/* Esportazione della funzione "strncmp". */
.global strncmp
.type strncmp, @function

strncmp:
    strncmp_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ecx

    movl 8(%ebp), %esi      # Copia il primo parametro.
    movl 12(%ebp), %edi     # Copia il secondo parametro.
    movl 16(%ebp), %ecx     # Copia il terzo parametro.

    xorl %eax, %eax

    strncmp_loop:
        test %ecx, %ecx         # Confronta il contatore con 0.
        jz   strncmp_diff       # Se è uguale a 0 esce dal ciclo.
        decl %ecx

        movb (%esi), %al

        test %al, %al           # Confronta il primo carattere con '\0'.
        jz   strncmp_diff       # Se è uguale a '\0' esce dal ciclo.
        cmpb %al, (%edi)        # Confronta il primo carattere con il secondo.
        jne  strncmp_diff       # Se sono diversi esce dal ciclo.
        incl %esi
        incl %edi
        jmp  strncmp_loop

    strncmp_diff:
        subb (%edi), %al    # Restituisce la differenza tra i due caratteri puntati.

    strncmp_epilogue:
        /* Ripristino registri. */
        pop %ecx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
