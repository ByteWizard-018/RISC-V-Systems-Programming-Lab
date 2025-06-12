.section .text
.global main

.align 4
main:

        #clear the 11th and 12th bit in the mstatus to jump to usermode 
        li      t0, 0x1800
        csrc    mstatus, t0

        
        #setting the val of mtimecmp 

        li      t0, 10000
        li      t1, 0x2004000
        sw      t0, 0(t1) 

                
        # set 3rd bit of mstatus which is MIE =1   

        li      t0, 0x8
        csrs    mstatus, t0 

        #set 7th bit of mie so, that we accept timmer interrupt
        li      t0, 0x80
        csrs    mie, t0      

        #setting the mtvec so, we know where to go when interrupt occurs

        la      t0, context_switch
        csrw    mtvec, t0        

        #setting the mepc to get into user mode

        la      t0, Task_A
        csrw    mepc, t0      

        mret      

.align 4
context_switch:

		# save the context of the interrupted task by looking at the task id (jump to relavent label)

        la   t0, current
        ld   t1, 0(t0)

        beqz  t1, save_context_A
        j      save_context_B 


save_context_A:

        la      sp, stack_a

        csrr    t0, mepc
        sd      t0, 0(sp)

        sd      a0, 8(sp)

        la      t0, flag_b 
        ld      t1, 0(t0)

        beqz    t1, initial_switch_to_B
        j       switch_to_B
	
save_context_B:
		# save all the registers and PC value in stack_b

        la      sp, stack_b

        csrr    t0, mepc
        sd      t0, 0(sp)

        sd      a0, 8(sp)

        j       switch_to_A

switch_to_A:
		# restore the values of registers and PC from stack_a

        la      sp, stack_a
        ld      t0, 0(sp)

        ld      a0, 8(sp)

        csrw    mepc ,t0

        la      t0, current
        li      t1, 0
        sd      t1, 0(t0)

        j       switch

switch_to_B:
		# restore the values of registers and PC from stack_b

        la      sp, stack_b
        ld      ra, 0(sp)

        ld      a0, 8(sp)

        csrw    mepc, ra

        la      t0, current
        li      t1, 1
        sd      t1, 0(t0)

        j       switch

initial_switch_to_B:
		# switching to Task B for the first time

        la      t0, Task_B
        csrw    mepc, t0

        la      t0, flag_b
        li      t1, 1
        sd      t1, 0(t0)

        la      t0, current
        li      t1, 1
        sd      t1, 0(t0)

        j       switch

switch:
		# set the value of mtimecmp and switch to your preferred task
        li      t0, 0x2004000
        ld      t1, 0(t0)
        li      t2, 10000
        add     t1,t1,t2
        sd      t1, 0(t0)

        mret

Task_A:
		# increment your reg 
        
        li     a0, 0

loop_a: 
        addi    a0,a0,1
        li      t0, 0x0fffffff
        beq     a0 , t0 ,finish_a
        j       loop_a



finish_a:
    j finish_a

Task_B:
		li  a0,0x03ffffff

loop_b: 

        addi    a0,a0,-1
        beqz    t0, finish_b
        j       loop_b
finish_b:
    j finish_b

.data
.align 4
stack_a:  .space  64
stack_b:  .space  64
current:  .dword  0x0
flag_b:   .dword  0x0

