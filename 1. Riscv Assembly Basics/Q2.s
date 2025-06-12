.section    .data   #Data section
num1: .word 5
num2: .word 10
array: .word 0,0,0,0,0
.section    .text
.globl  main
main:

la  a0,num1
lw  t0,0(a0)
la  a0,num2
lw  t1,0(a0)

add t2,t1,t0
la a0,array
sw t2,0(a0)


sub t3,t1,t0
sw  t3,4(a0)

and t4,t0,t1
sw  t4,8(a0)

or  t5,t0,t1
sw  t5,12(a0)

xor  t6,t1,t0
sw  t6,16(a0)

li a7, 93 
ecall
