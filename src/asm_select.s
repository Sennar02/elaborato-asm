/**
 * @file asm_select.s
 *
 * @brief Verifica in quale intervallo si trova un determinato valore.
 *
 * @param val Valore su cui operare.
 * @param arr Array di valori che determinano le soglie.
 * @param len Lunghezza dell'array.
 *
 * @return L'indice dell'intervallo in cui si trova il valore.
 */

.text

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

    movl 8(%ebp), %eax      # Copia il valore da confrontare.
    movl 12(%ebp), %esi     # Copia il puntatore all'array.
    movl 16(%ebp), %ecx     # Copia la lunghezza dell'array in %ecx.
    movl %ecx, %edx         # ed in %edx.

    select_loop:
        test %ecx, %ecx         # Se sono stati confrontati tutti i valori.
        jz   select_default     # Allora esce dal ciclo.
        decl %ecx               # Altrimenti decrementa il contatore.

        movl (%esi), %ebx       # Copia un valore valore dall'array.
        addl $4, %esi           # Incrementa il puntatore all'intero successivo.

        cmpl %ebx, %eax         # Se il valore è minore od uguale alla soglia.
        jle  select_return      # Allora esce dal ciclo.
        jmp  select_loop

    select_return:
        movl %edx, %eax         # Copia la lunghezza dell'array.
        subl %ecx, %eax         # Restituisce la differenza tra i due.
        jmp  select_epilogue

    select_default:
        movl %edx, %eax

    select_epilogue:
        /* Ripristino registri. */
        pop %ebx
        pop %esi
        /* Ripristino base ptr. */
        pop %ebp
        ret
