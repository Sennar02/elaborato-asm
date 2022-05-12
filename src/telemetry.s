.data
fmt: .ascii "%s\n\0"

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

invalid_pilot_str: .ascii "Invalid\0"

.text

.global telemetry
.type telemetry, @function

telemetry:
    telemetry_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Allocazione variabili. */
        subl $80, %esp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    leal pilot_19_str, %esi
    movl %esi, -4(%ebp)
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

    movl %ebp, %ebx
    subl $80, %ebx
    leal pilot_12_str, %esi

    push %esi
    push $20
    push %ebx
    call arrnfind
    addl $16, %esp

    telemetry_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Deallocazione variabili. */
        movl %ebp, %esp
        /* Ripristino base ptr. */
        pop %ebp
        ret
