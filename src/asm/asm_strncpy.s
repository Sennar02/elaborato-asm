/**
 * @file asm_strncpy.s
 *
 * @brief Copia un certo numero di caratteri da una stringa
 *        in un altra.
 *
 * Solamente se il numero di caratteri da copiare supera la
 * lunghezza della stringa sorgente, allora viene copiato
 * anche il terminatore.
 *
 * @param dst Stringa di destinazione.
 * @param src Stringa sorgente.
 * @param num Numero massimo di caratteri da copiare.
 *
 * @return Numero di caratteri copiati effettivamente.
 */

.text

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

    movl 8(%ebp), %edi      # Copia la stinga di destinazione in %edi.
    movl %edi, %edx         # ed in %edx.
    movl 12(%ebp), %esi     # Copia la stringa sorgente.
    movl 16(%ebp), %ebx     # Copia il numero massimo di caratteri.

    strncpy_loop:
        test %ebx, %ebx         # Se sono già stati copiati tutti i caratteri.
        jle  strncpy_return     # allora esce dal ciclo.
        decl %ebx               # Altrimenti decrementa il contatore.

        movb (%esi), %al        # Copia un carattere della stringa sorgente.
        incl %esi               # Incrementa il puntatore al carattere successivo.
        movb %al, (%edi)        # Copia il carattere nella stringa di destinazione.
        incl %edi               # Incrementa il puntatore al carattere successivo.

        test %al, %al           # Se il carattere copiato equivale al terminatore.
        jnz  strncpy_loop       # allora esce dal ciclo.

    strncpy_return:
        movl %edi, %eax         # Copia il puntatore all'ultimo carattere.
        subl %edx, %eax         # Restituisce la differenza con il puntatore originale.

    strncpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
