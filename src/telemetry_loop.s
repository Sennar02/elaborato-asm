
.text

.global telemetry_loop
.type telemetry_loop, @function

telemetry_loop:
    tloop_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Allocazione variabili. */
        subl $60, %esp
        // -4  &src
        // -8  cpy

        // -12 str[4]
        // -16 str[3]
        // -20 str[2]
        // -24 str[1]
        // -28 str[0]

         // -32 val[3]
         // -36 val[2]
         // -40 val[1]
         // -44 val[0]

         // -48 acc[3]
         // -52 acc[2]
         // -56 acc[1]
         // -60 acc[0]

        /* Salvataggio registri. */
        push %esi
        push %edi
        push %ebx

   movl 16(%ebp), %edi  # Copia la stringa di destinazione.
   movl %ebp, %esi      # Copia l'indirizzo di base.
   addl $12, %esi       # Calcola l'indirizzo della stringa sorgente.

   movl (%esi), %eax    # Copia la stringa in %eax.
   movl %eax, -4(%ebp)  # e le assegna un indirizzo nello stack.

   xorl %ebx, %ebx

   /* Azzera l'array di accumulazione. */
   movl $0, -60(%ebp)
   movl $0, -56(%ebp)
   movl $0, -52(%ebp)
   movl $0, -48(%ebp)

   tloop_loop:
        movl (%esi), %eax
        test %eax, %eax      # Se la stringa è esaurita.
        jz  tloop_finish     # allora esce dal ciclo.

        /* Separa riga per riga. */
        push $10             # Carica il carattere '\n'.
        push %esi            # Carica l'indirizzo della stringa sorgente.
        call asm_strsep      # Separa la stringa.
        addl $8, %esp        # Scarica i parametri dallo stack.

    test %eax, %eax      # Se la stringa è nulla.
    jz   tloop_index     # allora esce dal ciclo.

    movl %eax, -8(%ebp)  # Assegna un indirizzo al risultato.

    movl %ebp, %eax      # Copia l'indirizzo di base.
    subl $8, %eax        # Calcola l'indirizzo della riga.
    movl %ebp, %ecx      # Copia l'indirizzo di base.
    subl $28, %ecx       # Calcola l'indirizzo dell'array di stringhe.

    /* Separa un'intera riga una
       virgola alla volta. */
    push $44             # Carica il carattere ','.
    push %eax            # Carica l'indirizzo della riga.
    push $5              # Carica la lunghezza dell'array.
    push %ecx            # Carica l'indirizzo dell'array.
    call asm_strnsep     # Separa tutta la riga.
    addl $16, %esp       # Scarica i parametri dallo stack.

    tloop_index:
        cmpl $0, -24(%ebp)      # Se l'identificatore non è presente.
        je   tloop_loop         # allora esce dal ciclo.

        push -24(%ebp)          # Carica la stringa corrispondente all'ID.
        call asm_strtoi         # Traduce l'ID ad intero.
        addl $4, %esp           # Scarica i parametri dallo stack.

        cmpl %eax, 8(%ebp)      # Se l'indice è diverso al parametro.
        jne  tloop_loop         # allora passa all'iterazione successiva.

        incl %ebx               # Incrementa il contatore.

        /* Traduce ad intero str[3] e mette
           il risultato in val[0]. */
        push -16(%ebp)          # Carica str[3].
        call asm_strtoi         # Lo traduce ad intero.
        addl $4, %esp           # Scarica il parametro dallo stack.

        movl %eax, -44(%ebp)    # Copia il risultato in val[0].

        /* Traduce ad intero str[4] e mette
           il risultato in val[1]. */
        push -12(%ebp)           # Carica str[4].
        call asm_strtoi         # Lo traduce ad intero.
        addl $4, %esp           # Scarica il parametro dallo stack.

        movl %eax, -40(%ebp)    # Copia il risultato in val[1].

        /* Traduce ad intero str[2] e mette
           il risultato in val[2]. */
        push -20(%ebp)          # Carica str[2].
        call asm_strtoi         # Lo traduce ad intero.
        addl $4, %esp           # Scarica il parametro dallo stack.

        movl %eax, -36(%ebp)    # Copia il risultato in val[2].

        /* Calcola la lunghezza della stringa. */
        push -28(%ebp)          # Carica la stringa in questione.
        call asm_strlen         # Ne calcola la lunghezza.
        addl $4, %esp           # Scarica il paramaetro dallo stack.

        /* Ricopia l'istante di tempo nella stringa
           di output e ne sposta il puntatore. */
        push %eax               # Carica la quantità da copiare.
        push -28(%ebp)          # Carica la stringa da copiare.
        push %edi               # Carica la stringa nella quale scrivere.
        call asm_strncpy        # Copia la stringa.
        addl $12, %esp          # Scarica i parametri dallo stack.

        addl %eax, %edi         # Sposta il puntatore in base al risultato.

        /* Scrive una virgola all'interno della stringa. */
        movb $44, (%edi)        # Copia il carattere ',' nella stringa.
        incl %edi               # Sposta il puntatore al carattere successivo.

        movl %ebp, %eax         # Copia l'indirizzo di base.
        subl $44, %eax          # Calcola l'indirizzo dell'array riordinato.

        /* Gestisce la singola riga. */
        push 24(%ebp)           # Carica l'array di stringhe.
        push 20(%ebp)           # Carica l'array di soglie.
        push %edi               # Carica la stringa nella quale scrivere.
        push %eax               # Carica l'indirizzo dell'array riordinato.
        call telemetry_line     # Delega la gestione della riga.
        addl $16, %esp          # Scarica i parametri dallo stack.

        addl %eax, %edi         # Sposta il puntatore in base al risultato.

        /* Calcola il massimo tra il nuovo valore
           ed il precedente. */
        push -44(%ebp)          # Carica un valore.
        push -60(%ebp)          # Carica il massimo.
        call asm_max            # Calcola il massimo tra i due.
        addl $8, %esp           # Scarica i parametri dallo stack.

        movl %eax, -60(%ebp)    # Aggiorna il massimo con il risultato.

        /* Calcola il massimo tra il nuovo valore
           ed il precedente. */
        push -40(%ebp)          # Carica un valore.
        push -56(%ebp)          # Carica il massimo.
        call asm_max            # Calcola il massimo tra i due.
        addl $8, %esp           # Scarica i parametri dallo stack.

        movl %eax, -56(%ebp)    # Aggiorna il massimo con il risultato.

        /* Calcola il massimo tra il nuovo valore
           ed il precedente. */
        push -36(%ebp)          # Carica un valore.
        push -52(%ebp)          # Carica il massimo.
        call asm_max            # Calcola il massimo tra i due.
        addl $8, %esp           # Scarica i parametri dallo stack.

        movl %eax, -52(%ebp)    # Aggiorna il massimo con il risultato.

        /* Accumula la velocità. */
        movl -36(%ebp), %eax    # Copia la velocità.
        addl %eax, -48(%ebp)    # E la somma all'accumulatore.

        jmp tloop_loop

    tloop_finish:
        /* Calcola la media. */
        xorl %edx, %edx
        movl -48(%ebp), %eax    # Copia la somma delle velocità.
        divl %ebx               # Divide per il contatore.
        movl %eax, -48(%ebp)    # Copia il risultato nell'array.

    tloop_last:
        movl %ebp, %eax      # Copia l'indirizzo di base.
        subl $60, %eax       # e calcola l'indirizzo dell'array finale.

        push %edi            # Carica la stringa di destinazione.
        push -4(%ebp)        # Carica la stringa di appoggio.
        push %eax            # Carica l'indirizzo dell'array.
        call telemetry_last  # Copia l'ultima riga.
        addl $12, %esp       # Scarica i parametri dallo stack.

    tloop_epilogue:
        /* Ripristino registri. */
        push %ebx
        push %edi
        push %esi
        /* Deallocazione variabili. */
        movl %ebp, %esp
        /* Ripristino base ptr. */
        pop %ebp
        ret
