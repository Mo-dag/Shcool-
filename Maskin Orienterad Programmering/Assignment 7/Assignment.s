###########################################################
# Lecture 03 - Exercise 1
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

############################################################
# Assignment 1
#
# Input:
#   a0 = base (a)
#   a1 = exponent (b)
#
# Task:
#   Return (leave in a0 before `ret`):
#       a^b
#
# Notes:
#   * Assume b >= 0
#   * a^0 must return 1
#   * Use a loop
#
############################################################
question1:

    beqz a1, done

    li t0, 1
    beq a1, t0, end
    mv t1, a0
loop:   

    beq a1, t0, end    

    mul a0, a0, t1

    addi a1, a1, -1

    j loop


done: 
    li a0, 1
    ret

end:
    ret

############################################################
# Assignment 2
#
# Inputs:
#   a0 = a
#   a1 = b
#
# Task:
#   Return (leave in a0 before `ret`):
#   the smaller value of a and b.
#
# IMPORTANT:
#   a and b are *unsigned* values.
#
############################################################
question2:

    bgtu a0, a1, end

    ret
end:
    mv a0, a1
    ret
############################################################
# Assignment 3
#
# Inputs:
#   a0 = a
#   a1 = b
#   a2 = c
#   a3 = d
#
# Task:
#   Return (leave in a0 before `ret`):
#   the smallest value of the four inputs.
#
# Rules:
#   * You MUST call question2(a, b) for comparisons.
#   * Do not rewrite the comparison code here.
#
############################################################
question3:
## De vill att jag anropa question2 funktion. 
# Om jag anropa den med j : jump and link. Så jag förlorar retur aderss. 
# Jag och de vill att anropa den using call function.
# Call can förstöra retur adress, a0-a3 registrar värde. 
# Då skulle jag spara de i stackpekaren. 
# Därför skulle jag spara bara de som skulle jag använda efter varje anrop.
# 3 call behöver jag för att jämföra alla de värderna. 

# Jag kommer att spara
    # ra, a2, a3 
    addi sp, sp, -12 
    sw ra ,8(sp)
    sw s0 ,4(sp) 
    sw s1 ,0(sp)

    mv s0, a2
    mv s1, a3

    call question2

    mv a1, s0
    call question2

    mv a1, s1
    call question2






    # innan jag avslutar hela denna funk, skulle jag returnera ra värde
    #  lw s1, 0(sp)
    #   lw s0 osv.

    lw s1, 0(sp)
    lw s0, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12

    ret


############################################################
# Assignment 4
#
# C function:
#   int question4(int a, int b, int c, int d)
#
# Task:
#   Compute:
#   Return (leave in a0 before `ret`):    
#       the maximum of a, b, c, and d.
#
# Rules:
#   • You MUST use the provided function:
#         int max(int,int);
#     (this is called exactly as you would if it was defined 
#      assembly code in this file)
############################################################

.extern max

question4:

    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)

    mv s0, a2
    mv s1, a3


    call max
    mv a1, s0
    call max
    mv a1, s1
    

    lw s1, 0(sp) 
    lw s0, 4(sp)
    lw ra, 8(sp)
    addi sp,sp, 12 



    ret


############################################################
# Assignment 5
#
# Task:
#   Iterate over the array "numbers" and return
#   the largest value.
#
# Notes:
#   • numbers contains signed 32-bit integers.
#   • array_len contains the number of elements.
#   • Use a loop.
#
############################################################

question5:

    la t0, array_len 
    lw t0, 0(t0)          # Antal siffror i arrayen

    la t1, numbers        # Adressen. Jag ska addera 4 bytes för att öka index för arrayen
    lw t2, 0(t1)          # Ladda första element
    addi t0, t0, -1       # Minska antal elements. Vi har användts den första 

loop:
    beqz t0, end
    
    addi t1, t1, 4
    lw t3, 0(t1)
    addi t0, t0, -1
    bgt t3, t2, modify


    j loop

modify: 
    mv t2, t3
    j loop
end:    
    mv a0, t2
    ret


.align 2
numbers:
    .word 10, 5, -2, 36, 42, 18, 4, 39
array_len: 
    .word 8

############################################################
# Assignment 6
#
# Inputs:
#   a0: the address to array of signed 8-bit integers
#   a1: length of the array
#   
# Task:
#   Return the sum of all elements in the array.
############################################################
question6:

    li t2, 0        # Förbereda t2. 

loop:
    beqz a1, end    # Villkor. Antal element = 0 , avsluta.
    lb t1, 0(a0)    # Ladda värdet.
    addi a0, a0, 1  # Öka index.

    add t2, t2, t1 # Addera elements.

    addi a1, a1, -1 # Minska antal elements.

    j loop

end: 
    mv a0, t2
    ret 
