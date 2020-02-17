/******************************************************************************
*
* the file where we see what we can take away and still produce error (test4 is checkpoint)
*
******************************************************************************/
.data

.balign 4
 welcomePrint: .asciz "Welcome. Please select a shape.\n"
.balign 4
 selection: .space 128
.balign 4
 strInputFormat: .asciz "%s"
 .balign 4
 intInputFormat: .asciz "%d"
.balign 4
 rectangleArea: .asciz "The area of a rectangle with length %d\n"
.balign 4 
squareLPrompt:  .asciz   "Enter square length: \n"
.balign 4
exit_str:       .asciz      "Terminating program.\n"
.balign 4
sqL:  .word 0



.global main
main:
b welcome_print

welcome_print:
    ldr r0, =welcomePrint
    bl  printf

get_input:
    ldr r0, =strInputFormat 
    ldr r1, =selection                              
    bl  scanf 



rectangle_sr:

    @ branch to get_params subroutine
    bl rectangle_sr_params
    mov r1, #2 @ length into r1
    ldr r0, =rectangleArea
    bl printf
    b _exit
  
rectangle_sr_params:
    push {lr}    
    ldr r0, =squareLPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =sqL           
    bl  scanf
    ldr r1, =sqL     
    ldr r0, [r1]  
    add sp, sp, #4
    str r0, [sp]
    sub sp, sp, #4
    pop {pc}


_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
