.text
.global strlen

.type strlen, @function

strlen:
    push %ebp
    movl %esp, %ebp

    push %ebx

    movl $0, %eax
    movl -8(%ebp), %ebx
    decl %ebx

    strlen_loop:
        incl %ebx
        cmpl $0, %ebx
        je strlen_exit
        cmpl $0, (%ebx)
        jne strlen_loop

        subl -8(%ebp), %ebx
        movl %ebx, %eax

    strlen_exit:
        pop %ebx
        pop %ebp
        ret
