
.section .text
.globl main
main:

la a0,val1
la a1,val2
la a2,result


ld t0,0(a0)
ld t1,8(a0)
ld t2,0(a1)
ld t3,8(a1)

mul t4,t0,t2
mulhu t5,t0,t2

sd t4,0(a2);# fist 64 bits

mul t4,t3,t0
mulhu t6,t3,t0

mul a3,t1,t2
mulhu a4,t1,t2

mul a5,t1,t3
mulhu a6,t1,t3

add t0,t4,a3
sltu t2,t0,t4

add  a7,t0,t5
sltu t3,a7,t0

add t2,t3,t2

add  t6,t2,t6
sltu t2,t6,t2

add t6,t6,a4
sltu t3,t6,a4

add t2,t3,t2
add a5,t6,a5
sltu t3,a5,t6

add t2,t2,t3

add a6,t2,a6


sd a7,8(a2)

sd a5,16(a2)
sd a6,24(a2)

li a7, 93 
ecall 

.section .data

val1: .dword 0x1234567887654321,0x1234567887654321
val2: .dword 0x8765432112345678,0x8765432112345678
result: .dword 0,0,0,0












    





