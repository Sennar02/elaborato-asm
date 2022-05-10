.data
string: .ascii "ciao\0"

.text
.global main

main:
    push string
    call strlen

    main_exit:
        movl $1, %eax
        movl $0, %ebx
        int $0x80
