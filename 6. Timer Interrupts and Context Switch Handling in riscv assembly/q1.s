.section .text

.globl main
main:

    li      t0, 0x1800
    csrc    mstatus, t0

    li      t0, 0x8
    csrs    mstatus, t0

    li      t0, 0x2004000
    li      t1, 10000
    sd      t1, 0(t0)

    li      t0, 0x80
    csrs    mie, t0

    la      t0, mtrap
    csrw    mtvec, t0

    la      t0, user
    csrw    mepc ,t0

    mret
.align 4
mtrap:

    li      t0, 0x2004000
    li      t1, 10000
    ld      t2, 0(t0)
    add     t2, t2, t1
    sd      t2, 0(t0)

    csrr    a3, mcause

    mret

user:

    li      a0, 0x2004000
    li      a1, 0x200bff8

loop:

    ld      s1, 0(a0)
    ld      s2, 0(a1)
    j       loop
    
