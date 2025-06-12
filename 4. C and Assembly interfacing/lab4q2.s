.section    .data
length: .word 0x0;
reverse_str: .space 50


.section .text
.global  reverse_str
.globl  reverse

reverse:
        # addi  sp,sp,-16
        # sd    ra,0(sp)

        la  a1,reverse_str
        li  t0,0
        la  a3,length


loop:   
        add    t2,t0,a0
        lb      t2,0(t2)
        beqz    t2,find_rev
        addi    t0,t0,1
        j       loop

find_rev:

#         la      a2,length
#         sw      t0,0(a2)
#         srli    t3,t0,1 #find size

#         li  t1,0

# loop2: 
#         bge    t1,t3, end
#         add    t4,t1,a0
#         sub    t5,t0,t0
#         addi   t5,t5,-1
#         add    t5,t5,a0
#         lb     t6,0(t4)
#         lb     a3,0(t5)
#         sb     a3,0(t4)
#         sb     t6,0(t5)
#         addi   t1,t1,1
#         j      loop2

# end:
#         mv    a1,a0
#         mv    a0,t0
#         ld    ra,0(sp)
#         addi  sp,sp,16
#         ret
        addi    t1,t0,-1;

        add    a2,a0,t1
        sw     t0,0(a3)

loop2:
        beqz    t0,end
        lb      t3,0(a2)
        sb      t3,0(a1)
        addi    a2,a2,-1
        addi    a1,a1,1
        addi    t0,t0,-1
        j       loop2

end:    
        lw     t0,0(a3)
        mv     a0,t0
        ret





    



