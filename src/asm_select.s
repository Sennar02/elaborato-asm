/**
 * @file asm_select.s
 *
 * @brief Verifica in quale intervallo si trova un determinato valore.
 *
 * @param Valore da controllare.
 * @param Array di interi che rappresentano le soglie.
 * @return L'intervallo di appartenenza del valore.
 */

.text

/* Esportazione della funzione "asm_select". */
.global asm_select
.type asm_select, @function

asm_select:
    select_prologue:
        /* Salvataggio base ptr. */
        push %ebp
        movl %esp, %ebp
        /* Salvataggio registri. */
        push %esi
        push %ebx

    movl 8(%ebp), %ecx      # Copia il valore.
    movl 12(%ebp), %esi     # Copia il puntatore dell'array.
    movl 16(%ebp), %eax     # Copia la lunghezza dell'array.

    movl $4, %edx
    mulb %dl                # Moltiplica la lunghezza per la dimensione di un intero.
    movl %eax, %edx         # Sposta la lunghezza dell'array dentro EDX.

    xorl %eax, %eax

    select_loop:
        movl (%esi, %eax), %ebx     # Prende l'n-esimo valore dell'array.

        cmpl %ebx, %ecx             # Compara il valore dell'array con il parametro passato.
        jle select_return           # Se il parametro passato è minore salta fuori dal ciclo.

        addl $4, %eax               # Aggiorna il contatore.

        cmpl %edx, %eax             # Confronta il contatore con la lunghezza.
        jl select_loop              # Se il contatore è minore continua a ciclare.

        movl %edx, %eax             # Sposta la lunghezza nel registro di ritorno.

    select_return:
        movl $4, %ebx
        divb %bl                    # Divide il valore per la dimensione di un intero.

    select_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
