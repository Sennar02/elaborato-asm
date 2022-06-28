.data
printfmt: .ascii "%s\n\0"

pilot_00_str: .ascii "Pierre Gasly\0"
pilot_01_str: .ascii "Charles Leclerc\0"
pilot_02_str: .ascii "Max Verstappen\0"
pilot_03_str: .ascii "Lando Norris\0"
pilot_04_str: .ascii "Sebastian Vettel\0"
pilot_05_str: .ascii "Daniel Ricciardo\0"
pilot_06_str: .ascii "Lance Stroll\0"
pilot_07_str: .ascii "Carlos Sainz\0"
pilot_08_str: .ascii "Antonio Giovinazzi\0"
pilot_09_str: .ascii "Kevin Magnussen\0"
pilot_10_str: .ascii "Alexander Albon\0"
pilot_11_str: .ascii "Nicholas Latifi\0"
pilot_12_str: .ascii "Lewis Hamilton\0"
pilot_13_str: .ascii "Romain Grosjean\0"
pilot_14_str: .ascii "George Russell\0"
pilot_15_str: .ascii "Sergio Perez\0"
pilot_16_str: .ascii "Daniil Kvyat\0"
pilot_17_str: .ascii "Kimi Raikkonen\0"
pilot_18_str: .ascii "Esteban Ocon\0"
pilot_19_str: .ascii "Valtteri Bottas\0"

invalid_pilot_str: .ascii "Invalid\n\0"

level_00_str: .ascii "LOW\0"
level_01_str: .ascii "MEDIUM\0"
level_02_str: .ascii "HIGH\0"

point_00_num: .long 5000
point_01_num: .long 10000
point_10_num: .long 90
point_11_num: .long 110
point_20_num: .long 100
point_21_num: .long 250

.text

.global telemetry
.type telemetry, @function

telemetry:
    telem_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Allocazione variabili. */
        subl $116, %esp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    /* Carica tutti i piloti nello stack. */
    leal pilot_19_str, %esi     # Copia l'indirizzo della stringa in %esi.
    movl %esi, -4(%ebp)         # e poi lo copia nello stack.
    leal pilot_18_str, %esi
    movl %esi, -8(%ebp)
    leal pilot_17_str, %esi
    movl %esi, -12(%ebp)
    leal pilot_16_str, %esi
    movl %esi, -16(%ebp)
    leal pilot_15_str, %esi
    movl %esi, -20(%ebp)
    leal pilot_14_str, %esi
    movl %esi, -24(%ebp)
    leal pilot_13_str, %esi
    movl %esi, -28(%ebp)
    leal pilot_12_str, %esi
    movl %esi, -32(%ebp)
    leal pilot_11_str, %esi
    movl %esi, -36(%ebp)
    leal pilot_10_str, %esi
    movl %esi, -40(%ebp)
    leal pilot_09_str, %esi
    movl %esi, -44(%ebp)
    leal pilot_08_str, %esi
    movl %esi, -48(%ebp)
    leal pilot_07_str, %esi
    movl %esi, -52(%ebp)
    leal pilot_06_str, %esi
    movl %esi, -56(%ebp)
    leal pilot_05_str, %esi
    movl %esi, -60(%ebp)
    leal pilot_04_str, %esi
    movl %esi, -64(%ebp)
    leal pilot_03_str, %esi
    movl %esi, -68(%ebp)
    leal pilot_02_str, %esi
    movl %esi, -72(%ebp)
    leal pilot_01_str, %esi
    movl %esi, -76(%ebp)
    leal pilot_00_str, %esi
    movl %esi, -80(%ebp)

    /* Carica tutti i livelli nello stack. */
    leal level_02_str, %esi     # Copia l'indirizzo della stringa in %esi.
    movl %esi, -84(%ebp)        # e poi lo copia nello stack.
    leal level_01_str, %esi
    movl %esi, -88(%ebp)
    leal level_00_str, %esi
    movl %esi, -92(%ebp)

    /* Carica tutti i livelli nello stack. */
    movl point_21_num, %esi     # Copia il valore della soglia in %esi.
    movl %esi, -96(%ebp)        # e poi lo copia nello stack.
    movl point_20_num, %esi
    movl %esi, -100(%ebp)
    movl point_11_num, %esi
    movl %esi, -104(%ebp)
    movl point_10_num, %esi
    movl %esi, -108(%ebp)
    movl point_01_num, %esi
    movl %esi, -112(%ebp)
    movl point_00_num, %esi
    movl %esi, -116(%ebp)

    /* Copia l'indirizzo della stringa sorgente. */
    movl %ebp, %esi     # Copia l'indirizzo di base in %esi.
    addl $8, %esi       # Calcola l'indirizzo della stringa sorgente.

    /* Ottiene la prima riga. */
    push $10            # Carica il carattere '\n'.
    push %esi           # Carica l'indirizzo della stringa.
    call asm_strsep     # La separa.
    addl $8, %esp       # Scarica i parametri dallo stack.

    movl %ebp, %ebx     # Copia l'indirizzo di base in %ebx.
    subl $80, %ebx      # Calcola l'indirizzo dell'array di piloti.

    /* Ricerca l'ID del pilota. */
    push %eax           # Carica il primo segmento della stringa.
    push $20            # Carica la lunghezza dell'array.
    push %ebx           # Carica l'array di piloti.
    call asm_arrfind    # Cerca il pilota all'interno dell'array.
    addl $12, %esp      # Scarica i parametri dallo stack.

    /* Se l'ID è maggiore o uguale a 0. */
    cmpl $0, %eax       # Se l'identificatore è minore di zero.
    jl   telem_invalid  # allora esce dalla funzione.

    movl %ebp, %ebx     # Copia l'indirizzo di base in %ebx.
    subl $92, %ebx      # Calcola l'indirizzo dell'array di livelli.
    movl %ebp, %ecx     # Copia l'indirizzo di base in %ecx.
    subl $116, %ecx     # Calcola l'indirizzo dell'array di soglie.

    /* Chiama la funzione loop. */
    push %ebx           # Carica l'array di livelli.
    push %ecx           # Carica l'array di soglie.
    push 12(%ebp)       # Carica la stringa di destinazione.
    push 8(%ebp)        # Carica la stringa sorgente.
    push %eax           # Carica l'identificatore del pilota.
    call telemetry_loop # Gestisce tutte le righe.
    addl $20, %esp      # Scarica i parametri dallo stack.

    jmp  telem_return

    telem_invalid:
        leal invalid_pilot_str, %esi    # Carica l'indirizzo.

        push $9             # Carica il numero 9.
        push %esi           # Carica la stringa da copiare.
        push 12(%ebp)       # Carica la stringa di destinazione.
        call asm_strlcpy    # Copia la stringa.
        addl $12, %esp      # Scarica i parametri dallo stack.

    telem_return:
        xorl %eax, %eax

    telem_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Deallocazione variabili. */
        movl %ebp, %esp
        /* Ripristino base ptr. */
        pop %ebp
        ret
