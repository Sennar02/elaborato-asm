/**
 * @file asm_strncpy.s
 *
 * @brief Copia num caratteri da src a dst.
          Se si passa un numero di caratteri minore della lunghezza
          non viene aggiunto alcun carattere di terminazione.
          Viceversa se num è maggiore alla lunghezza di src la stringa
          dst viene terinata.
 *
 * @param dst Stringa di destinazione.
 * @param src Stringa sorgente.
 * @param num Numero di caratteri da copiare.
 * @return Numero di caratteri copiati.
 */

.text

/* Esportazione della funzione "asm_strncpy". */
.global asm_strncpy
.type asm_strncpy, @function

asm_strncpy:
    strncpy_prologue:
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

    movl %ebx, %edx

    strncpy_loop:
        test %ebx, %ebx         # Confronta la lunghezza con 0.
        jle  strncpy_return     # Se è uguale a 0 esce dal ciclo.
        decl %ebx               # Decrementa di 1 la lunghezza.

        movb (%esi), %al        # Copia l'n-esimo carattere della stringa sorgente in AL.
        incl %esi               # Incrementa il puntatore del carattere.
        movb %al, (%edi)        # Carica il carattere nella stringa di destinazione.

        incl %edi               # Incrementa il puntatore del carattere.

        test %al, %al           # Confronta il carattere con '\0'.
        jnz  strncpy_loop       # Se non è uguale a '\0' la stringa non è terminata.

    strncpy_return:
        movl %edi, %eax         # Copia il puntatore all'ultimo carattere.
        subl 8(%ebp), %eax      # Restituisce la differenza tra i due puntatori.

    strncpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
