.section .data

val1:   .dword 0x1234567887654321
val2:   .dword 0x8765432112345678
result: .dword 0
resultu: .dword 0

.section .text

.globl  main
main:

la a1,val1
la a2,val2
la a3,result
la a4,resultu

ld t1,0(a1)
ld t2,0(a2)

mul t3,t2,t1
mulhu t4,t2,t1

sd t3,0(a3)
sd t4,0(a4)

li a7, 93 
ecall 



