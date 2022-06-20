/**
 * @file asm_strncmp.s
 *
 * @brief Confronta un certo numero di caratteri di due stringhe.
 *
 * @param str1 Stringa da confrontare.
 * @param str2 Stringa con cui confrontare.
 * @param num  Numero massimo di caratteri da confrontare.
 *
 * @return 0 se sono uguali, -1 se str1 è minore di str2,
 *         1 se str1 è maggiore di str2.
 */

.text

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

    movl 8(%ebp), %esi      # Copia la stringa da confrontare.
    movl 12(%ebp), %edi     # Copia la stringa con cui confrontare.
    movl 16(%ebp), %ecx     # Copia il numero massimo di caratteri.

    xorl %eax, %eax
    xorl %ebx, %ebx

    strncmp_loop:
        movb (%esi), %al        # Copia un carattere della prima stringa.
        incl %esi               # Incrementa il puntatore al carattere successivo.
        movb (%edi), %bl        # Copiaun carattere della seconda stringa.
        incl %edi               # Incrementa il puntatore al carattere successivo.

        test %ecx, %ecx         # Se sono già stati confrontati tutti i caratteri.
        jz   strncmp_diff       # allora esce dal ciclo.
        decl %ecx               # Altrimenti decrementa il contatore.

        test %al, %al           # Se il primo carattere equivale al terminatore.
        jz   strncmp_diff       # allora esce dal ciclo.
        cmpb %al, %bl           # Se i due caratteri sono diversi.
        jne  strncmp_diff       # allora esce dal ciclo.

        jmp strncmp_loop

    strncmp_diff:
        subl %ebx, %eax     # Restituisce la differenza tra i due caratteri.

    strncmp_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
