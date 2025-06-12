
.section .text
.global main



main:
    # Prepare jump to super mode
    li t1, 1
    slli t1, t1, 11   #mpp_mask
    csrs mstatus, t1
    
    la t4, supervisor       #load address of user-space code
    csrrw zero, mepc, t4    #set mepc to user code
    
    la t5, page_fault_handler
    csrw mtvec, t5
   
    mret

supervisor:
################## Setting up page tables ##############
    # Set value in PTE2 (Initial Mapping)
    li a0,0x81000000
    li a1, 0x82000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 16(a0)

    # To set V.A 0x0 -> P.A 0x0
    li a1, 0x82001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE1 (Initial Mapping)
    li a0,0x82000000
    li a1, 0x83000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set Frame number in PTE0 (Initial Mapping)
    li a0,0x83000000
    li a1, 0x80000
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 0(a0)

    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 8(a0)

    # Set value in PTE1 (Code Mapping)
    li a0,0x82001000
    li a1, 0x83001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE0 (Code Mapping)
    li a0,0x83001000
    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xf9 # D | A | G | U | X | - | - |V
    sd a1, 0(a0)

    # Data Mapping
    li a1, 0x80002
    slli a1, a1, 0xa
    ori a1, a1, 0xf7 # D | A | G | U | - | W | R |V
    sd a1, 8(a0)
    

####################################################################

    # Prepare jump to user mode
    li t1, 0
    slli t1, t1, 8   #spp_mask
    csrs sstatus, t1

    # Configure satp
    la t1, satp_config 
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0       # load VA address of user-space code
    csrrw zero, sepc, t4    # set sepc to user code
    
    sret



###################################################################
##################### ADD CODE ONLY HERE  #########################
###################################################################
.align 4
page_fault_handler:


    li      a0, 12
    csrr    a1, mcause

    bne     a0, a1, data_page_fault

instruct_page_fault:


    li      a0, 0x80001000
    li      a1, 0x80002

    la      a2, var_count
    ld      a2, 0(a2)

    add     a1, a1, a2
    add     t4, a1, zero

    slli    a1, a1, 12  # actual page number

    li      a3, 0x1000


copy_loop:

    ld      a4, 0(a0)
    sd      a4, 0(a1)

    addi    a0, a0, 8
    addi    a1, a1, 8
    addi    a3, a3, -8

    bnez    a3, copy_loop


# update the pointers

    li      t0, 0x83001000
    la      a3, var_count

    ld      a3, 0(a3)
    slli    a3, a3, 4   # to access the next page to point the copied one
    add     t0, t0, a3

    slli    t4, t4, 10  # convetert to ppn
    ori     t4, t4, 0x5b
    sd      t4, 0(t0)

    mret

data_page_fault:


    li      t0, 0x83001000
    la      a3, var_count

    ld      a3, 0(a3)
    slli    a3, a3, 1
    addi    a3, a3, 1
    slli    a3, a3, 3 #mul with 8
    add     t0, t0, a3

    li      a5, 0x80002
    slli    a5, a5, 10
    ori     a5, a5, 0xf7
    sd      a5, 0(t0)

    mret

###################################################################
###################################################################



.align 12
user_code:
    la t1,var_count
    ld t2, 0(t1)
    addi t2, t2, 1
    sd t2, 0(t1)

    la t5, code_jump_position
    ld t3, 0(t5)
    li t4, 0x2000
    add t3, t3, t4
    sd t3, 0(t5)
    
    jalr t0, t3


.data
.align 12
var_count:  .dword  0
code_jump_position: .dword 0x0000


.align 8
# Value to set in satp
satp_config: .dword 0x8000000000081000
