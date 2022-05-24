/**
 * @file asm_strncmp.s
 *
 * @brief Confronta due stringhe e controlla se sono uguali.
 *
 * @param str1 Prima stringa.
 * @param str2 Seconda stringa.
 * @param num Numero di caratteri da controllare.
 * @return 0 se sono uguali altrimenti la differenza del primo
           carattere dissimile.
 */

.text

/* Esportazione della funzione "asm_strncmp". */
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

    movl 8(%ebp), %esi      # Copia la prima stringa.
    movl 12(%ebp), %edi     # Copia la prima stringa.
    movl 16(%ebp), %ecx     # Copia la lunghezza.

    xorl %eax, %eax
    xorl %ebx, %ebx

    strncmp_loop:
        movb (%esi), %al        # Copia il primo carattere della prima stringa in AL.
        incl %esi               # Incrementa il puntatore del carattere.
        movb (%edi), %bl        # Copia il primo carattere della seconda stringa in BL.
        incl %edi               # Incrementa il puntatore del carattere.

        test %ecx, %ecx         # Confronta la lunghezza con 0.
        jz   strncmp_diff       # Se è uguale a 0 esce dal ciclo.
        decl %ecx

        test %al, %al           # Confronta il primo carattere con '\0'.
        jz   strncmp_diff       # Se è uguale a '\0' esce dal ciclo.
        cmpb %al, %bl           # Confronta il primo carattere con il secondo.
        jne  strncmp_diff       # Se sono diversi esce dal ciclo.

        jmp strncmp_loop

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
