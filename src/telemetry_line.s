/**
 * @brief Assegna ai tre valori di arr una targhetta tra
 *        LOW, MEDIUM, HIGH in base alla soglia in cui
 *        rientrano salvando le tre stringhe in dst
 *        separate da un virgola.
 *
 * @param arr Array cui vengono salvati i valori rpm,
 *            temperatura e velocità per ogni istante.
 * @param dst Stringa di destinazione.
 * @param treshs Array di soglie.
 * @param levels Array di livelli.
 *
 * @return Il numero di caratteri scritti nella stringa dst.
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

    movl 8(%ebp), %esi      # Copia l'indirizzo all'array.
    movl 12(%ebp), %edi     # Copia la stringa destinazione.

    movl %edi, %ebx         # Salva l'indirizzo alla stringa destinazione.

    xorl %ecx, %ecx

    telemetry_line_loop:
        /* Calcola le soglie del valore. */
        movl 16(%ebp), %edx     # Carica l'indirizzo di treshs.
        push %ecx               # Salva il contatore nello stack.
        movl %ecx, %eax         # Prepara il contatore per la moltiplicazione.
        movl $8, %ecx           # Carica lo sfasamento.
        mulb %cl                # Moltiplica il contatore per 8.
        addl %eax, %edx         # Somma il risultato a treshs.

        /* Chiama la funzione select. */
        movl $2, %ecx           # Copia il numero di valori di treshs
        push %ecx               # e lo carica nello stack.
        push %edx               # Carica l'indirizzo di treshs.
        movl (%esi), %eax       # Estrae l'elemento dall'array.
        push %eax               # e lo carica nello stack.
        call asm_select         # Calcola il l'indice della stringa con il livello.
        addl $12, %esp          # Scarica i parametri dallo stack.
        addl $4, %esi           # Aggiorna l'indice dell'array.

        /* Estrae la stringa che descrive il livello. */
        movl $4, %ecx           # Carica il numero di bytes dell'architettura.
        xorl %edx, %edx
        mull %ecx               # Moltiplica il selettore per il numero di bytes.
        addl 20(%ebp), %eax     # Somma al risultato l'indirizzo della stringa.
        movl (%eax), %edx       # Carica la stringa dalla memoria.

        /* Calcola la dimensione della stringa. */
        push %edx               # Carica la stringa con il livello.
        call asm_strlen         # Calcola la lunghezza della stringa.
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
        movl %edi, %eax         # Copia l'indirizzo modificato.
        subl %ebx, %eax         # Sottrae l'indirizzo di partenza.

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
