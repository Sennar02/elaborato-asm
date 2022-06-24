/**
 * @file asm_telemetry_line.s
 *
 * @brief Assegna ai tre valori di arr una targhetta tra
 *        LOW, MEDIUM, HIGH salvando le stringhe in dst.
 *
 * @param arr Array di interi.
 * @param dst Puntatore alla destinazione.
 * @param pnts Array contenente le soglie dei dati.
 * @param strs Array di stringhe indicanti la soglia.
 * @return Il numero di caratteri aggiunti alla destinazione.
 */

.text

/* Esportazione della funzione "telemetry_line". */
.global telemetry_line
.type telemetry_line, @function

telemetry_line:
    telemetry_line_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

    movl 8(%ebp), %esi      # Copia il puntatore all'array.
    movl 12(%ebp), %edi     # Copia la stringa destinazione.

    movl %edi, %ebx         # Salva il puntatore alla stringa destinazione.

    xorl %ecx, %ecx

    telemetry_line_loop:
        /* Calcola il valore puntato da ths. */
        movl 16(%ebp), %edx     # Carica il puntatore a ths.
        push %ecx               # Salva il contatore per recuperarlo successivamente.
        movl %ecx, %eax         # Prepara il contatore per la moltiplicazione.
        movl $8, %ecx
        mulb %cl                # Moltiplica il contatore per 8.
        addl %eax, %edx         # Somma il risultato a ths.

        /* Chiama la funzione select. */
        push %edx               # Carica il puntatore a ths.
        movl (%esi), %eax       # Estrae l'elemento dall'array.
        push %eax               # Carica l'elemento estratto.
        call asm_select         # Chiama la funzione asm_select.
        addl $8, %esp           # Scarica i parametri dallo stack.
        addl $4, %esi           # Aggiorna l'indice dell'array.

        /* Estrae la stringa da aggiungere a dst. */
        movl $4, %ecx
        xorl %edx, %edx
        mull %ecx               # Moltiplica il selettore per 4.
        addl 20(%ebp), %eax     # Somma al risultato il puntatore ad out.
        movl (%eax), %edx       # Carica da memoria la stringa.

        /* Calcola la dimensione della stringa. */
        push %edx               # Carica la stringa.
        call asm_strlen         # Chiama la funzione ams_strlen.
        addl $4, %esp           # Scarica i parametri dallo stack.

        /* Copia la stringa nella destinazione. */
        push %eax               # Carica la dimensione della stringa.
        push %edx               # Carica la stringa.
        push %edi               # Carica il puntatore alla destinazione.
        call asm_strncpy        # Chiama la funzione asm_strncpy.
        addl $12, %esp          # Scarica i parametri dallo stack.
        addl %eax, %edi         # Sposta il puntatore alla stringa.

        /* Aggiorna il contatore. */
        pop %ecx                # Recupera il contatore.
        incl %ecx               # Incrementa il contatore.

        /* Controlla se siamo all'ultimo carattere. */
        cmpl $3, %ecx               # Confronta i contatore con 3.
        je telemetry_line_term      # se sono ugauli esce dal ciclo.

        /* Aggunge il carattere ','. */
        movl $44, (%edi)        # Inserisce il carattere ','.
        incl %edi               # Incrementa il puntatore di dst.

        jmp telemetry_line_loop

    telemetry_line_term:
        /* Inserisce il carattere '\n'. */
        movl $10, (%edi)        # Inserisce il carattere '\n'.
        incl %edi               # Incrementa il puntatore di dst.

        /* Calcola il numero di caratteri aggiunti. */
        movl %edi, %eax
        subl %ebx, %eax

    telemetry_line_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %edi
        pop %esi
        /* Deallocazione variabili. */
        movl %ebp, %esp
        /* Ripristino base ptr. */
        pop %ebp
        ret
