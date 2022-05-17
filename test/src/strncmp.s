.text

/* Esportazione della funzione "strncmp". */
.global asm_strncmp
.type asm_strncmp, @function

asm_strncmp:
    strncmp_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il primo parametro.
    movl 12(%ebp), %edi     # Copia il secondo parametro.
    movl 16(%ebp), %ecx     # Copia il terzo parametro.

    xorl %eax, %eax
    xorl %ebx, %ebx

    strncmp_loop:
        movb (%esi), %al
        incl %esi
        movb (%edi), %bl
        incl %edi

        test %ecx, %ecx         # Confronta il contatore con 0.
        jz   strncmp_diff       # Se è uguale a 0 esce dal ciclo.
        decl %ecx

        test %al, %al           # Confronta il primo carattere con '\0'.
        jz   strncmp_diff       # Se è uguale a '\0' esce dal ciclo.
        cmpb %al, %bl           # Confronta il primo carattere con il secondo.
        jne  strncmp_diff       # Se sono diversi esce dal ciclo.

        jmp  strncmp_loop

    strncmp_diff:
        subl %ebx, %eax     # Restituisce la differenza tra i due caratteri puntati.

    strncmp_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
