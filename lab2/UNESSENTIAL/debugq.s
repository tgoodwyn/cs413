/******************************************************************************
* Lab 1
* CS 413
* Menon - 01
* Tyler Goodwyn
******************************************************************************/
.data


.balign 4
 squareArea: .asciz "The area of a square of length %d is %d\n"
.balign 4
squareLPrompt:  .asciz   "Enter square length: \n"
.balign 4
exit_str:       .asciz      "Terminating program.\n"

sqL:  .word 0

.text
.global main
main:


square_sr:
    sub sp, sp, #4 
    bl square_sr_params
    ldr r4, [sp]
    mov r0, r4
    bl square_sr_area
    ldr r4, [sp]
    mov r1, r7
    mov r2, r4
    ldr r0, =squareArea
    b _exit
   
square_sr_params:

    push {lr}    
    add sp, sp, #4
    mov r0, #5  
    str r0, [sp]
    sub sp, sp, #4
    pop {pc}


square_sr_area:
    push {r4, lr}
    mul r1, r0, r0
    add sp, sp, #8
    @mov r1, #9
    str r1, [sp]
    sub sp, sp, #8
    pop {r7, pc}



_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
