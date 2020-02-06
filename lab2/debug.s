

.data
.balign 4
 areaPrint: .asciz "The area is: %d \n"
.balign 4 
squareLPrompt:  .asciz   "Enter square length: \n"
.balign 4
intInputFormat: .asciz "%d"
.balign 4
exit_str:       .asciz      "Terminating program.\n"
sqL:  .word 0


.global main
.text
main:
square_sr:
    sub sp, sp, #4 
    bl square_sr_params
    add sp, sp, #4
    ldr r1, [sp]
    @mov r1, #4
    ldr r0, =areaPrint
    @bl  printf
    @ bl square_sr_area
    b _exit
    @ bl square_sr_print

square_sr_params:

    push {lr}
    
    ldr r0, =squareLPrompt
    @bl  printf

    @ standard 5 instructions for scanf
    ldr r0, =intInputFormat
    ldr r1, =sqL                              
    @bl  scanf 
    ldr r2, =sqL     
    @ldr r1, [r2]  
    mov r1, #6
    
    add sp, sp, #4
    str r1, [sp]
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

