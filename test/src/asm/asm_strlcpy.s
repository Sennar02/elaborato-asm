/**
 * @file asm_strlcpy.s
 *
 * @brief Copia num caratteri da src a dst e aggiunge il terminatore.
 *
 * @param dst Stringa di destinazione.
 * @param src Stringa sorgente.
 * @param num Numero di caratteri da copiare.
 * @return Numero di caratteri copiati.
 */

.text

/* Esportazione della funzione "asm_strlcpy". */
.global asm_strlcpy
.type asm_strlcpy, @function

asm_strlcpy:
    strlcpy_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %edi      # Copia la stinga di destinazione.
    movl 12(%ebp), %esi     # Copia la stringa sorgente.
    movl 16(%ebp), %ebx     # Copia la lunghezza.

    movl %ebx, %edx         # Copia la lunghezza in EDX.

    strlcpy_loop:
        decl %ebx               # Decrementa di 1 la lunghezza.
        cmpl $0, %ebx           # Confronta la lunghezza con 0.
        jle  strlcpy_term       # Se è uguale a 0 esce dal ciclo.

        movb (%esi), %al        # Copia l'n-esimo carattere della stringa sorgente in AL.
        incl %esi               # Incrementa il puntatore del carattere.
        movb %al, (%edi)        # Carica il carattere nella stringa di destinazione.
        incl %edi               # Incrementa il puntatore del carattere.

        test %al, %al           # Confronta il carattere con '\0'.
        jnz  strlcpy_loop       # Se non è uguale a '\0' la stringa non è terminata.

    strlcpy_term:
        cmpl $0, %edx           # Confronta la lunghezza con 0.
        jle  strlcpy_return     # Se è maggiore di 0
        movb $0, (%edi)         # Termina la stringa.

    strlcpy_return:
        movl %edi, %eax         # Copia il puntatore all'ultimo carattere.
        subl 8(%ebp), %eax      # Restituisce la differenza tra i due puntatori.

    strlcpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
