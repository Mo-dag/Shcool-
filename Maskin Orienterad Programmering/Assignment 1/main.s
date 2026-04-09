
.globl main # Make main function visible to startup code
main:
    ###########################################################################
    # Assignment 1: Calculate t0 = a + b
    # =================================================
    # Check that you have the correct value in t0 using "register list"
    # in the debugger
    ###########################################################################

    ###########################################################################
    # Assignment 3: Store the value of t0 into variable c
    # ==================================================================
    # What is the address of c?
    # Open the memory view in the debugger to check that c has the correct value
    # If not, or if your simserver yells at you, check the hint in assignment 2
    ###########################################################################

	#\,,/(^_^)\,,/

    #----- My solution ----#
    # I can not directly use the memory address of (a,b) variables to do arithmetic operations.
    # RISC-V : Works only with registers.First I load the memory address to the registerz
    # Then load the value to the register to use it in further operations.


    la t0, a		#Load address of 'a' variable to t0 register.
    lhu t0, 0(t0)	#Load the value to use it.
    la t1, b		#Load address of 'b' variable to t1 register.
    lb t1, 0(t1)	#Load the value to use it with addition.
    add t0, t1, t0	#Add the values of a and b and store result in register t0. Assignment 1 is accomplished.
    la t2, c		#Load &C into t2.
    sw t0, 0(t2)	#Store a+b into C 

end: j end  # End with a forever loop
	#,,!,,(^_^),,!,,
.align 1
a: .hword 10
b: .byte 20
.align 2		## Here I do an alignment because we changed the data type and .word needs to be allocated correctly in memory.
			## Changing the data type to word or halfword needs alignment.
c: .word 1000		## Here I initiated 4 bytes integer to 1000.
###########################################################################
# Assignment 2: Declare a variable c that is a signed 4-byte integer and
#               initialize it to 1000
# =================================================
# (hint: don't forget about alignment!)
###########################################################################
