###############################################################################
# Lecture 03 - Example 01
# ============================================================================
# The C standard library (which this program links against) provides the 
# functions: 
# 
# int putchar(int c) - Prints the ASCII character corresponding to c.
#                      Returns -1 on error, otherwise returns the character 
#                      printed.
# 
# int rand(void) - Returns a pseudo-random integer in the range 0 to 32767
# 
# ============================================================================
# Write a program that continually renders random, lower case, letters to 
# the console. 
# 
# You need to connect a console to USART1 in the simulator.
###############################################################################
.section .text
.global main

# These lines tell the assembler that these functions are defined elsewhere
.extern putchar
.extern rand

write_random_char:
    ### ### ### ### För att lösa denna uppgift ska jag : 
    ######## Generera ett slumpmässigt tal genom att kalla : rand som genererar mellan 0 och 32767
    ## För att göra inter vall skulle jag använda modulus operator. 
    # ASCII för low case bokstäver ligger mellan : 97 - 122 
    #>>> intervall [0 - 25] + [97] = [97 - 122]
    ### Sist kallar jag putchar.


    // Your code here
    call rand ##Med denna line of code, returenerar vi ett siffra mellan 0 till 32767 till a0.

    ## Nu vi vill begränsa talet till intervall : [0,25]>>
    ## Vi använder remu : som är remainder unsigned. vi vill få resten utan tecken. 
    ## remu tar registrar. Så laddar jag 26 till t0. 
    li t0, 26
    remu t1, a0, t0
    addi t2, t1, 97     ## Jag adderar genererad siffran till rätt intervall 97. 
                        ## Nu har vi en random ASCII character in i t2 register.
    mv a0, t2           ## Nu ligger ASCII-tecknet i a0, så det kan skickas till putchar.
                        ## Varför ? för att : putchar tar a0 som argument. 

    call putchar        

    ret

main:
    # Infinite loop
.loop:
    call    write_random_char

    j    .loop   
    ret


