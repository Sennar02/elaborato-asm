.data
string: .ascii "ciao\0"

.text
.global main

main:
    leal string, %esi
    push %esi
    call strlen

    movl $4, %eax
    movl $1, %ebx
    int $0x80
