.section    .data #Data section
array:  .word 5,3,4,6,5
.section    .text
.globl  main
main:
la  a0,array
li  t0,0
li  t5,0
li  t1,20

myLoop:
        beq t0,t1,END
        add t2,t0,a0
        lw  t3,0(t2)
        add t4,t3,t5
        sw  t4,0(t2)
        addi t0,t0,4
        addi t5,t5,1
        j   myLoop
END:

        ret

