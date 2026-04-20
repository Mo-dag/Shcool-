###############################################################################
# Lecture 03 - Example 02
# ============================================================================
# The C standard library (which this program links against) provides the 
# functions: 
# 
# int putchar(int c) - Prints the ASCII character corresponding to c.
#                      Returns -1 on error, otherwise returns the character 
#                      printed.
# 
# Use this function to write another function: 
# void print_string(address, length)
# 
# You need to connect a console to USART1 in the simulator.
###############################################################################
.section .text
.global main

# These lines tell the assembler that these functions are defined elsewhere
.extern putchar

print_string: 
### De ger oss två saker. Adress & Lengd. 
# Adress kommer vi att använda för två saker. 1- Dra värde för nuvarande bokstav
# 2- Öka den med en plats för att anpassa till nästa bokstav. 

## Lengden används bara för antal loopar.- beqz a1, slut / addi a1, a1, -1
## med de två lines, löser jag loopens huvud problem.


    ## The main idea here is : 

    // Your code here
    # Jag kommer att skapa en loop. 
    # Loopen omfattas av : 
    # loop: ## Label 
    # Villkor ## om < length
    # DO ## putchar
    # Ändra räknare : ++ eller -- 
    # j loop : gör om.

       # Vi kommer att kalla en funk inne i en annan funktion. 
       # Registrar kan skrivas över by funktionen. Därför kommer jag att 
       # reservera plats på stack pekaren för att spara info.

    addi sp, sp, -12
    sw ra, 8(sp)    # varje register är 4 bytes. 
    sw s0, 4(sp)
    sw s1, 0(sp) 
    mv s1, a1   # Length
    mv s0, a0   # Adress
loop:
    # Skapar jag villkor till loopen : 
    beqz s1, slut # Om lengden blir noll hoppa intern till en funk som heter slut som avslutar print_string.

    lbu a0, 0(s0)   # a0 används som argument till funk.
    call putchar
    
    addi s0, s0, 1    # addi t0, t0, 1 Kan orsaka fel. För att t0 kan skrivas över by the function.

    addi s1, s1, -1 # addi a1, a1, -1 Kan orsaka fel också. För att a1 kan skrivas över by the function.
    j loop


slut:
    lw s1, 0(sp)
    lw s0, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    ret

main:

loop2: 

    la a0, string1      # Load address of string1
    li a1, 4            # Length of string1
    call print_string

    la a0, string2      # Load address of string2
    li a1, 3            # Length of string2
    call print_string

    la a0, string3      # Load address of string3
    li a1, 5            # Length of string3
    call print_string

    j loop2

string1: .ascii "MOP\n"
string2: .ascii "is\n"
string3: .ascii "fun!\n"

