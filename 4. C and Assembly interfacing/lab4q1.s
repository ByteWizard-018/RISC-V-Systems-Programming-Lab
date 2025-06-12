.section    .data

first_name: .asciz "Bharath"
last_name:  .asciz "Yanadi"
course_name: .space 30

.section    .text

.globl      main

main:

        addi    sp,sp,-16
        sd      ra,0(sp)

        call    getcourse

        mv      a2,a0

        la      a0,first_name
        la      a1,last_name

        call    displayStudentProfile

        ld      ra,0(sp)
        addi    sp,sp,16
        ret

        

