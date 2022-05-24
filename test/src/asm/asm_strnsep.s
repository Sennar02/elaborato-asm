/**
 * @file asm_strsep.s
 *
 * @brief Separa una stringa num volte ad ogni occcorrenza del separatore,
          se non sono presenti abbastanza separatori le celle rimanenti vengono
          svuotate.
 *
 * @param arr Array su cui salvare le stringhe.
 * @param num Lunghezza dell'array.
 * @param ptr Puntatore alla stringa da modificare.
 * @param sep Carattere separatore.
 * @return Numero di separazioni che hanno dato un puntatore.
 */

.text

.global asm_strnsep
.type asm_strnsep, @function

asm_strnsep:
    strnsep_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il puntatore all'array risultato.
    movl 12(%ebp), %ecx     # Copia la lunghezza dell'array.
    movl 16(%ebp), %edi     # Copia il puntatore alla stringa da modificare.
    movl 20(%ebp), %ebx     # Copia il carattere separatore.

    xorl %edx, %edx

    strnsep_loop:
        test %ecx, %ecx
        jz   strnsep_return
        decl %ecx

        push %edx               # Salva il valore di EDX.

        # Separa la stringa
        push %ebx               # Carica il carattere separatore.
        push %edi               # Carica il puntatore alla stringa.
        call asm_strsep         # Chiama la funzione asm_strsep.
        addl $8, %esp           # Scarica i parametri dallo stack.

        pop %edx                # Riprende il valore di EDX.

        movl %eax, (%esi)       # Aggiorna il puntatore della stringa.
        addl $4, %esi           # Incrementa l'indice dell'array.

        test %eax, %eax         # Confronta l'indirizzo con NULL.
        jz   strnsep_repeat     # Se è diverso da NULL.
        incl %edx               # Incrementa l'indirizzo.

        strnsep_repeat:
            jmp strnsep_loop

    strnsep_return:
        movl %edx, %eax

    strnsep_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
