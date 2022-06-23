/**
 * @file asm_itostr.s
 *
 * @brief Converte un intero di base 10 in una stringa.
 *
 * @param num Numero da convertire.
 * @param str Stringa di destinazione.
 *
 * @return Un puntatore alla stringa di destinazione.
 */

.text

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

    movl 8(%ebp), %eax      # Copia l'intero da convertire.
    movl 12(%ebp), %esi     # Copia la stringa in %esi.
    movl %esi, %edi         # ed in %edi.

    movl $10, %ecx          # Copia la base del numero.

    test %eax, %eax         # Se il numero è nullo.
    jz   itostr_zero        # allora evita il ciclo.

    itostr_loop:
        xorl %edx, %edx

        divl %ecx           # Divide il numero per la base.
        addl $48, %edx      # Trasforma il valore nel suo carattere ASCII.
        movb %dl, (%esi)    # Copia il carattere nella stringa.
        incl %esi           # Incrementa il puntatore al carattere successivo.

        test %eax, %eax     # Se il numero è stato consumato completamente.
        jz   itostr_term    # allora esce dal ciclo.
        jmp  itostr_loop

    itostr_zero:
        movb $48, (%esi)    # Copia il carattere '0' nella stringa.
        incl %esi           # Incrementa il puntatore al carattere successivo.

    itostr_term:
        movb $0, (%esi)     # Termina la stringa in ogni caso.

    movl %esi, %eax         # Copia il puntatore modificato.
    subl %edi, %eax         # Calcola la differenza con il puntatore originale.
    decl %eax               # Decrementa la differenza.

    push %eax               # Carica il numero di caratteri da ribaltare.
    push %edi               # Carica il puntatore della stringa.
    call asm_strnrev        # Ribalta la stringa.
    addl $8, %esp           # Scarica i due parametri dallo stack.

    itostr_epilogue:
        /* Ripristino registri. */
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
