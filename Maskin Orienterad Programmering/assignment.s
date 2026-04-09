############################################################
# Lecture 02 - Exercise 2
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

############################################################
# Assignment 1
#
# Input:
#   a0 = integer a
#
# Task:
#   Return:
#       a * 2
#
############################################################
question1:
# TODO
    ## a0 is a register that holds the first argument
    #and at the same time it ironically store the return value.
    slli a0, a0, 1      #Here I am shifting it to the left in binary system så it is 2¹ shift left by 1 bit.
    
    ret 


############################################################
# Assignment 2
#
# Input:
#   a0 = integer a
#   a1 = integer b
#
# Task:
#   Return (put answer in a0):  
#       a * b
#
############################################################
question2:
    # TODO
    #While the a0 holds the first argument, a1 holds the other one. 
    mul a0, a0, a1
    ret


############################################################
# Assignment 3
#
# Input:
#   a0 = integer a
#
# Task:
#   Return (put answer in a0):  
#       a*a + 10
#
############################################################
question3:
    # TODO
    mul a0, a0, a0          # Multiply directly because the value is already in a register.
    addi a0, a0, 10        ##add immediate, the immediate is 10.
    ret


############################################################
# Assignment 4
#
# Input:
#   a0 = short x   (passed as a signed 32-bit integer)
#
# Task:
#   Return (put answer in a0):  
#       1   if x is negative
#       0   if x is positive or zero
#
# Notes:
#   * Do NOT use branches.
#   * Detect negativity by examining the sign bit.
#
############################################################
question4:
    # . : * : . . : * : . . : * : . . : * : . . : * : . . : * : . . : * : . . : * : . #
    #Logic behind the solusion is 2 steps. 
    #Shift the MSB to the right :
    #From    1000 0000 0000 0000 0000 0000 0000 0000
    #To      0000 0000 0000 0000 0000 0000 0000 0001

    #Then Mask the two num. The LSB will be 1 with an AND operator. 
    srli a0, a0, 31             
    andi a0, a0, 0x00000001
    ret


############################################################
# Assignment 5  (Challenge)
#
# Input:
#   a0 = integer a
#
# Task:
#   Return (put answer in a0):  
#       a * 7
#
# Rules:
#   * Do NOT use 'mul'
#   * Only shifts and adds/subs allowed
############################################################
question5:
## ## ### #### ##### ###### ####### ######## ######### ##########
#                          Solution                             #------------------------
# -- -- To do this, we can think that multiplications is a repetition of addition.-------
#       My approuch is to shift the number to left 3 steps. It will qual mult with 8 ----
#       0000 0000 0000 0000 0000 0000 0000 0³0²0¹0⁰
#                                          2³2²2¹2⁰
#                                          8 4 2 1
#       Then i will subtract it with it self once to get the right value.-----------------
    mv t0, a0 #I am doing a copy of a0 because I need the original value to do subtraction
    slli a0, a0, 3 # Multiplication with 8 is happning here.
    sub a0, a0, t0 # Subtraction with the original a0 make it *7 instead of *8.-----------

    # TODO
    ret