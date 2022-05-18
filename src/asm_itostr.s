/**
 * @file asm_itostr.s
 *
 * @brief Converte un intero a stringa.
 *
 * @param num Numero intero da convertire.
 * @param str Stringa su cui salvare il numero.
 * @param base Base della conversione.
 * @return Numero in formato stringa.
 */

.text

/* Esportazione della funzione "asm_itostr". */
.global asm_itostr
.type asm_itostr, @function

asm_itostr:
    itostr_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi

    movl 8(%ebp), %eax      # Copia l'intero.
    movl 12(%ebp), %esi     # Copia la stringa.
    movl 16(%ebp), %ecx     # Copia la base.

    movl %esi, %edi         # Copia della stringa in EDI.

    test %eax, %eax         # Confronta l'intero con 0.
    jz   itostr_zero        # Se è uguale a 0 salta il ciclo.

    itostr_loop:
        xorl %edx, %edx
        divl %ecx           # Divide il numero per la base.
        addl $48, %edx      # Somma 48 al resto per covertirlo in ASCII.
        movb %dl, (%esi)    # Carica il carattere nella stringa.

        incl %esi           # Incrementa il puntatore del carattere.

        test %eax, %eax     # Controlla se la parte intera è 0.
        jz   itostr_term    # Se è uguale a 0 termina la stringa.
        jmp  itostr_loop

    itostr_zero:
        movb $48, (%esi)    # Aggiunge il carattere 0 alla stringa.
        incl %esi           # Incrementa il puntatore del carattere.

    itostr_term:
        movb $0, (%esi)     # Aggiungere il carattere di terminazione alla stringa.

    # Calcola la lunghezza della stringa.
    movl %esi, %eax         # Carica il puntatore incrementato in EAX.
    subl %edi, %eax         # Sottrae il puntatore originale al puntatore incrementato.
    decl %eax               # Decrementa il puntatore.

    # Ribaltamento della stringa.
    push %eax               # Carica la lunghezza della stringa.
    push %edi               # Carica la stringa di partenza.
    call asm_strnrev        # Chiama la funzione asm_strnrev.
    addl $8, %esp

    itostr_epilogue:
        /* Ripristino registri. */
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
