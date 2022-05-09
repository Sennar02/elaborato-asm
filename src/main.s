.data
stirng: .ascii "ciao\0"

.text
.global main

main:
    push string
    call strlen

    movl $4, %eax
    movl $1, %ebx
    int $0x80
