.data
str1: .ascii "ciao\0"
str2: .ascii "ciaa\0"

.text
.global main

main:
    push $4
    leal str2, %esi
    push %esi
    leal str1, %esi
    push %esi

    call strncmp
    addl $12, %esp

    _start_prologue:
        movl $1, %eax
        movl $0, %ebx
        int $0x80
