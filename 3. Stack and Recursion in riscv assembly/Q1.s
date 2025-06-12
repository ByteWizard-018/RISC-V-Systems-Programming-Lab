.section    .data

n:      .word 5
hsp:    .dword 0
lsp:    .dword 0
sum:    .word 0

.section    .text
.globl      main
main:

        la      t3,n
        lw      t3,0(t3)
        la      t5,hsp
        sd      sp,0(t5)
        la      a6,lsp
        sd      sp,0(a6)
        # li      a0,4
        la      a2,sum
        lw      a3,0(a2) 
        li      t4,0 
        li      a0,0

loop:   
        beq    t4,t3,end

        addi    sp,sp,-16
        sw      ra,12(sp)
        sw      a0,8(sp)

        la      a5,lsp
        ld     s1,0(a5)
        blt     s1,sp,base1
        sd      sp,0(a5)
base1:

        jal     ra,fib
        add     a3,a3,a0


        addi    t4,t4,1
        add    a0,zero,t4

        lw      ra,12(sp)
        addi    sp,sp,16

        j       loop

        



end:    
        mv      a0,a3
        la      t1,lsp
        ld      t1,0(t1)
        la      t2,hsp
        ld      t2,0(t2)
        sub     a1,t2,t1
        li      a7,93
        ecall

.section    .text
.globl      fib

fib:

        addi    sp,sp,-16
        sw      ra,12(sp)
        sw      a0,8(sp)

        la      a5,lsp
        ld      s1,0(a5)
        blt     s1,sp,base
        sd      sp,0(a5)
base:
        # base case 1

        beqz    a0,case1

        # base case 2

        li      t0,1
        beq     a0,t0,case2

        # recursive cal f(n-1)

        addi    a0,a0,-1
        jal     ra,fib
        sw      a0,4(sp)

        #f(n-2)

        lw      a0,8(sp)
        addi    a0,a0,-2
        jal     ra,fib

        lw      t1,4(sp)
        add     a0,a0,t1

        lw      ra,12(sp)
        addi    sp,sp,16
        ret

    case1:

        li      a0,0
        lw      ra,12(sp)
        addi    sp,sp,16
        ret
    
    case2:

        li      a0,1
        lw      ra,12(sp)
        addi    sp,sp,16
        ret




