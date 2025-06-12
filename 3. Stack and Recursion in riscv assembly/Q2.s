.section .data
X:      .word   14
Y:      .word   23
N:      .dword  2
message:    .asciz  "Move from rod X to rod Y\n"

.section .text
.global main

main:

        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)
        la      a0,N
        ld      a0,0(a0)

        addi      a1,zero,49       
        addi      a2,zero,50       
        addi      a3,zero,51       
        call    hanoi_prob
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16

        # end program
        ret

hanoi_prob:
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        sd      a1,24(sp)
        sd      a2,16(sp)
        sd      a3,8(sp)

        addi    a0,a0,-1
        sd      a0,0(sp)

        beq     a0,zero,base_case

        ld      a1,24(sp)
        ld      a2,8(sp)
        ld      a3,16(sp)

        call    hanoi_prob

        addi    a0,zero,1
        ld      a1,24(sp)
        ld      a2,16(sp)
        ld      a3,8(sp)

        call    hanoi_prob

        ld      a0,0(sp)
        ld      a1,16(sp)
        ld      a2,8(sp)
        ld      a3,24(sp)
        call    hanoi_prob

        ld      ra,40(sp)
        ld      s0,32(sp)
        addi    sp,sp,48
        ret

    base_case:
            addi    a0,a1,0
            addi    a1,a2,0
            call     print
            ld      ra,40(sp)
            ld      s0,32(sp)
            addi    sp,sp,48
            ret

print:
        la      t5,message
        la      t4,X
        la      t2,Y
        lw      t4,0(t4)
        lw      t2,0(t2)

        add     t3,t5,t4
        sb      a0,0(t3)

        add     t3,t5,t2
        sb      a1,0(t3)

        addi    a0,zero,1
        la      a1,message

        addi      a2,zero,25
        addi      a7,zero,64
        ecall
        ret