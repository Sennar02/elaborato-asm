/**
 * @file asm_arrfind.s
 *
 * @brief Cerca una particolare chiave all'interno di un array.
 *
 * @param arr Array di stringhe.
 * @param len Lunghezza dell'array.
 * @param key Chiave da ricercare.
 *
 * @return -1 se non è presente, altrimenti la posizione
 *         della stringa nell'array.
 */

.text

.global asm_arrfind
.type asm_arrfind, @function

asm_arrfind:
    arrfind_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia l'indirizzo dell'array.
    movl 12(%ebp), %ecx     # Copia la lunghezza dell'array in %ecx.
    movl %ecx, %ebx         # ed in %ebx.
    movl 16(%ebp), %edi     # Copia la chiave da ricercare.

    /* Calcola la lunghezza. */
    push %edi               # Carica la chiave nello stack.
    call asm_strlen         # Ne calcola la lunghezza.
    addl $4, %esp           # Scarica il parametro dallo stack.
    movl %eax, %edx

    arrfind_loop:
        test %ecx, %ecx         # Se ha già confrontato tutte le stringhe.
        jz   arrfind_default    # allora esce dal ciclo.
        decl %ecx               # Altrimenti decrementa il contatore.

        push %ecx               # Salva il valore nello stack.

        /* Confronta le stringhe. */
        push %edx               # Carica la lunghezza della chiave nello stack.
        push (%esi)             # Carica l'indirizzo dell'elemento dell'array.
        push %edi               # Carica la chiave.
        call asm_strncmp        # Confronta le due stringhe.
        addl $8, %esp           # Scarica i parametri dallo stack.

        addl $4, %esi           # Incrementa il puntatore alla stringa successiva.
        pop %edx                # Riprende il valore dallo stack.
        pop %ecx                # Riprende il valore dallo stack.

        test %eax, %eax         # Se le due stringhe sono uguali.
        jz   arrfind_result     # allora esce dal ciclo.
        jmp  arrfind_loop

    arrfind_result:
        movl %ebx, %eax         # Copia la lunghezza dell'array.
        incl %ecx               # Incrementa il contatore.
        subl %ecx, %eax         # Restituisce la differenza tra i due.
        jmp  arrfind_epilogue

    arrfind_default:
        movl $-1, %eax          # Restituisce -1.

    arrfind_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
