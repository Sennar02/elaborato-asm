.text
.global strlen

.type strlen, @function

strlen:
    push %ebp               # Salva il valore di %ebp
    movl %esp, %ebp         # Copia %esp in %ebp

    push %ebx               # Salva il valore di %ebx

    movl -8(%ebp), %ebx     # Copia due valori indietro rispetto a %ebp in %ebx
    movl $0, %eax           # Azzera %eax
    decl %ebx               # Decrementa %ebx

    strlen_loop:
        incl %ebx               # Incrementa %ebx
        cmpl $0, %ebx           # Confronta il puntatore con NULL
        je strlen_exit          # Se equivale esce
        cmpl $0, (%ebx)         # Confronta il valore con '\0'
        jne strlen_loop         # Se non equivale riparte

	movl -8(%ebp), %eax     # Copia il puntatore in %eax
    subl %eax, %ebx         # Sottrae ad %ebx il valore di %eax
	movl %ebx, %eax         # Sposta il risultato in %eax

    strlen_exit:
        pop %ebx    # Riprende %ebx
        pop %ebp    # Riprende %ebp
        ret         # Torna al chiamante
