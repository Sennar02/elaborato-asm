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

    movl 8(%ebp), %esi      # Copia il primo parametro.
    movl 12(%ebp), %edi     # Copia il secondo parametro.
    movl 16(%ebp), %ecx     # Copia il terzo parametro.

    xorl %eax, %eax

    strncmp_loop:
        movb (%esi), %al

        test %al, %al           # Confronta il primo carattere con '\0'.
        jz   strncmp_diff       # Se è uguale a '\0' esce dal ciclo.
        cmpb %al, (%edi)        # Confronta il primo carattere con il secondo.
        jne  strncmp_diff       # Se sono diversi esce dal ciclo.

        incl %esi
        incl %edi

        test %ecx, %ecx         # Confronta il contatore con 0.
        jz   strncmp_diff       # Se è uguale a 0 esce dal ciclo.
        decl %ecx
        jmp  strncmp_loop

    strncmp_diff:
        xorl %ecx, %ecx
        movb (%edi), %cl
        subl %ecx, %eax     # Restituisce la differenza tra i due caratteri puntati.

    strncmp_epilogue:
        /* Ripristino registri. */
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
