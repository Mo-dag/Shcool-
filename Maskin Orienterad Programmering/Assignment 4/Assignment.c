############################################################
# Lecture 02 - Exercise 4
# ==========================================================
#
# This is the only file you should edit for the exercise. 
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


############################################################
# Global variables
# Return here for Assignment 5
############################################################

.data
.align 2
# TODO: add global variables here
# Task:
#   Go to the line 34 of this file and allocate memory
#   for the following variables with initial values:    
#   signed char x = -45;
x: .byte -45        ## Signed or Unsigned, it is .byte
#   unsigned char y = 210;
y: .byte 210
#   unsigned int z = 4000;
.align 2
z: .word 4000


.text
############################################################
# Assignment 1
#
# Input:
#   a0 = char ascii_code
#
# Task:
#   Convert input ´ascii_code´ into a decimal value 
#   the code represents, put answer in a0 and return.
#
# Hint: Link to ASCII table: 
#      https://www.asciitable.com/
#
############################################################
question1:
    # TODO
    # Assignment 1 is bit challenging because it not saying so much.
    # My approuch is to make nr : '0' as base value and subtract every 
    # wanted value from '0'. '0' is 48
    addi a0, a0, -48
    ret


############################################################
# Assignment 2
#
# Input:
#   a0 = char digit1
#   a1 = char digit2
#   a2 = char digit3
#                           
# Task:
#   Registers a0-a2 contain digits (0-9) in ASCII code.
#   Convert ASCII into corresponding decimals and form
#   a single integer out of them.
#
#   Example: a0='1', a1='2', a2='3' => a0 = 123
#
#   Hint1: 123 = 1*100 + 2*10 + 3
#
############################################################
question2:
    # TODO
    # The same approuch in the previous assignment.
    # Mul does not work with immediate. 
    # The hint made the assignment much easier.
    li t0, -48
    add a0, a0, t0
    add a1, a1, t0
    add a2, a2, t0
    li t1, 100
    li t2, 10
    mul a0, a0, t1
    mul a1, a1, t2
    add a0, a0, a1
    add a0, a0, a2
    ret

############################################################
# Assignment 3
#             
# Input:              
#   a0 = unsigned char pattern
#
# Task:
#   Given a one-byte pattern in a0, fill all the bytes of a0
#   with that pattern.
#
#   Save the result in a0.
#  
# Example: a0=0x55 => a0=0x55555555
#
############################################################
question3:
    # TODO
    # I want to save the value first. 
    # Shift to left, OR the value
    # Copy the value 
    # Shift and OR again
    lbu t0, 0(a0) #the value is already in a register. All i need is LOAD
    slli a0, a0, 1
    or a0, a0, t0
    lhu t0, 0(a0)
    slli a0, a0, 1
    or a0, a0, t0    
    ret

############################################################
# Assignment 4
#             
# Input:              
#   a0 = unsigned char value
#
# Task:
#   Calculate the number of ones in a0.
#   You do not need loops for this.
#
#   Save the result in a0.
#  
# Example: a0=0b00001101 => a0=3
#
# Hint: how can you isolate the first bit?
#
# Hint2: after you implement this, ask your favourite AI tool
#        to solve this, and get your mind blown.
#
############################################################
question4:
    # TODO
    # Because a0 already has the value. Therefor I do not need to (Load the adress or the unsigned byte).
    # We can just copy the value to a temporary register.Use mv directly. mv is : addi rd, rs, 0
    mv t0, a0
    # Since we will not use a loop, I check one bit at time.
    # Basically. I isolate the LSB with AND 1. (Save the value =(1/0) > Shift again. Compare (AND) > Save > add > repeat.)
    # To get the value uppgraded after every skift I will save it in the same register, otherwise it 
    # will skift the same value again and again. srli t0, t0, 1
    andi t2, t0, 0x00000001 #0x0000000X
    mv t1, t2
    srli t0, t0, 1
    andi t2, t0, 0x00000001 #0x000000XX
    add t1, t2, t1
    srli t0, t0, 1
    andi t2, t0, 0x00000001 #0x00000XXX
    add t1, t2, t1
    srli t0, t0, 1
    andi t2, t0, 0x00000001 #0x0000XXXX
    add t1, t2, t1
    srli t0, t0, 1
    andi t2, t0, 0x00000001 #0x000XXXXX
    add t1, t2, t1
    srli t0, t0, 1
    andi t2, t0, 0x00000001 #0x00XXXXXX
    add t1, t2, t1
    srli t0, t0, 1
    andi t2, t0, 0x00000001 #0x0XXXXXXX
    add t1, t2, t1
    srli t0, t0, 1
    andi t2, t0, 0x00000001 #0xXXXXXXXX
    add t1, t2, t1
    mv a0, t1

    # This is a simple direct solution. I think there are more complex and developed solutions. 
    # Unfortunately i have so much to do. Other wise there are more mathematical approach.
    # Considering the relation between the numbers and 2⁰¹²³⁴⁵⁶⁷⁸. 
    # The more convenient approach is LOOP. 
    # AI approach is :
    #-> summera i par
    #-> summera paren till 4-bit-grupper
    #-> summera hela byten

    #Maskerna betyder:

    #0x55 = 01010101 → plockar varannan bit
    #0x33 = 00110011 → plockar 2-bitarsgrupper
    #0x0F = 00001111 → behåller slutresultatet

    ret


############################################################
# Assignment 5 (with a curve ball)
#
# Task:
#   Go to the line 34 of this file and allocate memory
#   for the following variables with initial values:    
#   signed char x = -45;
#   unsigned char y = 210;
#   unsigned int z = 4000;
#
#   Then implement operation:
#       a0 = (x & 0x0FF0) - z + y 
#
############################################################

question5:
    # TODO
    la t0, x
    lb t0, 0(t0)  # t0 = *X
    li t1, 0x0FF0 # t1 = 0x0FF0
    and t0, t0, t1 # t0 = x & 0x0FF0
    la t2, z
    lw t2, 0(t2)  # t2 = *Z
    sub t0, t0, t2    # t0 = (x & 0x0FF0)-z ::DONE::
    la t1, y
    lbu t1, 0(t1) # t1 = *y
    add t0, t0, t1
    mv a0, t0
    ret
    
