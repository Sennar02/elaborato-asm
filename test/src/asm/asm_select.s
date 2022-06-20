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

    movl 8(%ebp), %eax      # Copia il valore.
    movl 12(%ebp), %esi     # Copia il puntatore dell'array.
    movl 16(%ebp), %ecx     # Copia la lunghezza dell'array.

    incl %ecx

    select_loop:
        test %ecx, %ecx
        jz   select_return
        decl %ecx

        movl (%esi), %ebx           # Prende l'n-esimo valore dell'array.
        addl $4, %esi

        cmpl %ebx, %eax             # Compara il valore dell'array con il parametro passato.
        jle  select_return           # Se il parametro passato è minore salta fuori dal ciclo.
        jmp  select_loop

    select_return:
        movl 16(%ebp), %eax             # Divide il valore per la dimensione di un intero.
        subl %ecx, %eax

    select_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
