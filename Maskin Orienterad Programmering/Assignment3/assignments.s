############################################################
# Lecture 02 - Exercise 3
# ==========================================================
#
# This is the only file you should edit for the excercise. 
# The file main.c is a test harness to help you test your code.
#
# Before you start: 
# Start simserver and choose Server->IO Setup
# For "Serial Communication Interface 1", choose "06 Console"
# Then run the program with F5 (if it breaks on main, 
# continue with F5 again)
# You should see output on the simserver console telling you 
# which assignments are passed. 
#
############################################################
    .text
    .global question1
    .global question2
    .global question3
    .global question4
    .global question5
    .global question6
    .global question7
    .global shared_value

############################################################
# Global variables (you are NOT meant to modify these)
############################################################

    .data
    .align 2
shared_value:
    .word 0
signed_byte:    
    .byte -5
    .byte 0
    .byte 0
    .byte 0
unsigned_half: 
    .half -30000
    .half 0
.text


############################################################
# Assignment 1
#
# Task:
#   Store the value 42 into the global variable 'shared_value'
#
############################################################
question1:
    # TODO
    #_.~"~._.~"~._.~"~._.~"~._# Solution #_.~"~._.~"~._.~"~._.~"~._#
    # First I will get the address of 'shared_value' 
    # Store the value in a register. Then store the value into the address of shared value. 

    la t0, shared_value
    addi t1, x0, 42             #Not knowing the trash value of register t1 preventing us from
    sw t1, 0(t0)                #Adding 42 directly to it. Så I use x0 register to get clean value.

    ret


############################################################
# Assignment 2
#
# Task:
#   Load the value from 'shared_value' and
#   return it in a0.
#
############################################################
question2:
    # TODO
    ## We can not load the value directly from the adress if it sits in memory
    ## So we load the adress into a register, then load the value into another register
    ## Finally can we store the value to the register a0
    la t0, shared_value
    lw t1, 0(t0)
    addi a0, t1, 0          # mv instruction does the same. mv a0, t1
    ret

############################################################
# Assignment 3
#
# Task:
#   Read the word stored at address 0x20010000
#   and write the same word to address 0x20010004.
#
# Notes:
#   Both addresses are guaranteed to be valid SRAM
#   locations. Do not use the stack.
#
############################################################
question3:
    # TODO
    # To load the adress into a register, I will use load immediate, that comes från addi rd, rs, imm
    # but actually it uses x0 as rs: source register. 
    # Then I load the word from it into the same register. I do not need the adress anymore.
    # Then I load the adress 0x20010004 into t1. Lastly I use the sw that need an adress as 
    # destination register. When t1 hold the adress, though it will work to store the value.
    li t0, 0x20010000 
    lw t0,0(t0)
    li t1, 0x20010004
    sw t0, 0(t1)
    ret

############################################################
# Assignment 4
#
# Input:
#   a0 = integer x
#
# Task:
#   Store x into shared_value.
#
############################################################
question4:
    # TODO
    # All we need here is : the adress of shared_value stored in a register.
    # Så we can use sw.
    la t0, shared_value
    sw a0, 0(t0)
    ret


############################################################
# Assignment 5
#
# Task:
#   Load 'shared_value', add 22 to it, and
#   return the result in a0.
#
############################################################
question5:
    # TODO
    # All we need to get the value of shared_value into a register
    # It fits perfectly with addi 
    # With addi can we do all the math. addi destination register(a0), source register(t0), immediate(22)
    # Done xD
    la t0, shared_value
    lw t0, 0(t0)
    addi a0, t0, 22
    ret

############################################################
# Assignment 6
#
# Task:
#   Read the value at label 'signed_byte' 
#   and return it.
#   
# Notes:
#   * 'signed_byte' is a signed 8-bit value.
#
############################################################
question6: 
    la t0, signed_byte
    lb t0,0(t0)
    mv a0, t0
    # Or we can just : lb a0, 0(t0) directly
    ret    

############################################################
# Assignment 7
#
# Task:
#   Read the value at label 'unsigned_half' and subtract
#   the value in a0 and return.
#
#   I.e. a0 = unsigned_half - a0
#
# Notes:
#   * 'unsigned_half' is an unsigned 16-bit value.
#
############################################################
question7:
    # TODO
    la t0, unsigned_half
    lhu t1, 0(t0)
    sub a0, t1, a0
    ret    
