/**
 * @file asm_strlcpy.s
 *
 * @brief Copia un certo numero di caratteri da una stringa
 *        in un altra.
 *
 * Indipendentemente dallo stato della stringa sorgente, quella
 * di destinazione viene terminata sempre al prezzo di un carattere
 * copiato in meno.
 *
 * @param dst Stringa di destinazione.
 * @param src Stringa sorgente.
 * @param num Numero massimo di caratteri da copiare.

 * @return Numero di caratteri copiati effettivamente.
 */

.text

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
    movl 16(%ebp), %ebx     # Copia il numero massimo di caratteri in %ebx.
    movl %ebx, %edx         # ed in %edx.

    strlcpy_loop:
        decl %ebx               # Decrementa il contatore.
        test %ebx, %ebx         # Se sono già stati copiati tutti i caratteri.
        jle  strlcpy_term       # allora esce dal ciclo.

        movb (%esi), %al        # Copia un carattere della stringa sorgente.
        incl %esi               # Incrementa il puntatore al carattere successivo.
        movb %al, (%edi)        # Copia il carattere nella stringa di destinazione.
        incl %edi               # Incrementa il puntatore al carattere successivo.

        test %al, %al           # Se il carattere copiato equivale al terminatore.
        jnz  strlcpy_loop       # allora esce dal ciclo.

    strlcpy_term:
        test %edx, %edx         # Se originariamente doveva copiare 0 caratteri.
        jz   strlcpy_return     # allora esce dal ramo.
        movb $0, (%edi)         # Altrimenti termina la stringa di destinazione.

    strlcpy_return:
        movl 8(%ebp), %edx      # Copia la stringa di destinazione.
        movl %edi, %eax         # Copia il puntatore all'ultimo carattere.
        subl %edx, %eax         # Restituisce la differenza tra i due puntatori.

    strlcpy_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
