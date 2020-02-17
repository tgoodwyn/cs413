/******************************************************************************
* @file array.s
* @brief simple array declaration and iteration example
*
* Simple example of declaring a fixed-width array and traversing over the
* elements for printing.
*
* @author Christopher D. McMurrough
******************************************************************************/
 
.global main
.func main
   
main:

readloop:

    BL  _printf             @ branch to print 
    
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   
.data

.balign 4
a:              .skip       400
printf_str:     .asciz      "a = \n"
exit_str:       .ascii      "Terminating program.\n"