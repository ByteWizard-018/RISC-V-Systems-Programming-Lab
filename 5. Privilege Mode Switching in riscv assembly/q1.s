.section    .text
.globl      main
main:

    li      t0,0x1000
    csrc    mstatus,t0

    li      t0,0x100
    csrs    medeleg,t0

    li      t0,0x800
    csrs    mstatus,t0

    la      t1,mtrap_handler
    csrw    mtvec,t1  

    la      t2,scode
    csrw    mepc,t2


    mret

mtrap_handler:

    csrr    a1,mepc
    csrr    a2,mcause


    csrr    t3,mepc
    addi    t3,t3,4
    csrw    mepc,t3

    mret



scode:

    li      t0,0x100
    csrc    sstatus,t0

    la      t0,strap_handler
    csrw    stvec,t0

    la      t0,ucode
    csrw    sepc,t0

    sret

strap_handler:

    csrr    a3,sepc
    csrr    a4,scause

    ecall

    sret



ucode:

    li      t5,0
    addi    t5,t5,1

    ecall

