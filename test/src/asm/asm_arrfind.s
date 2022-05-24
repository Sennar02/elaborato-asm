/**
 * @file asm_arrfind.s
 *
 * @brief Cerca la chiave dentro l'array e restituisce
          la sua relativa posizione.
 *
 * @param arr Array di stringhe.
 * @param len Lunghezza dell'array.
 * @param key Chiave da ricercare.
 * @return Posizione della stringa nell'array.
 */

.text

/* Esportazione della funzione "asm_arrfind". */
.global asm_arrfind
.type asm_arrfind, @function

asm_arrfind:
    arrfind_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    movl 8(%ebp), %esi      # Copia l'indirizzo dell'array.

    xorl %ebx, %ebx         # Inizializzazione dell'indice.

    arrfind_loop:
        cmpl %ebx, 12(%ebp)     # Confronta il contatore con la lunghezza dell'array.
        je   arrfind_default    # Se è uguale a "len" esce dal ciclo.

        # Calcola la lunghezza della chiave.
        push 16(%ebp)           # Carica la chiave nello stack.
        call asm_strlen         # Chiama la funzione asm_strlen.
        addl $4, %esp           # Scarica i parametri dallo stack.

        # Confronta le due stringhe.
        push %eax               # Carica la lunghezza della seconda stringa nello stack.
        push (%esi)             # Carica l'indirizzo dell'elemento dell'array.
        push 16(%ebp)           # Carica la chiave.
        call asm_strncmp        # Chiama la funzione asm_strncmp.
        addl $12, %esp          # Scarica i parametri dallo stack.

        test %eax, %eax         # Confronta il risultato con 0.
        jz   arrfind_result     # Se è uguale a 0 esce dal ciclo.
        incl %ebx               # Incremeta il contatore.
        addl $4, %esi           # Sposta il puntatore dell'array all'elemento successivo.
        jmp  arrfind_loop

    arrfind_result:
        movl %ebx, %eax         # Restituisce il contatore.
        jmp  arrfind_epilogue

    arrfind_default:
        movl $-1, %eax          # Restituisce -1.

    arrfind_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
