.data

.balign 4
strInputFormat: .asciz "%s"
.balign 4
intInputFormat: .asciz "%d"
.balign 4
rectangleArea_mini: .asciz "The area of a rectangle is %d\n"
.balign 4
rectangleArea: .asciz "The area of a rectangle with length %d and height %d is %d\n"

.balign 4 
rectLPrompt:  .asciz   "Enter recentagle length: \n"
.balign 4 
rectHPrompt: .asciz   "Enter recentagle height: \n"

.balign 4 
exit_str:       .asciz      "Terminating program.\n"

rectL:  .word 0
rectH: .word 0

.text
.global main
main:

rectangle_sr:
    @ allot stack space for params
     sub sp, sp, #8 
    @ branch to get_params subroutine
    bl rectangle_sr_params
    @ load params into register 4 - 6
    ldr r5, [sp], #4 @ height into r5
    ldr r4, [sp], #4 @ length into r4


    mov r1, r4 @ length into r1
    mov r2, r5 @ height into r2
    mov r3, #30
    ldr r0, =rectangleArea_mini
    bl printf
    b _exit

rectangle_sr_params:
    
     push {lr}  
    add sp, sp, #8

    mov r1, #10
    str r1, [sp], #-4

    mov r2, #3
    str r2, [sp], #-4
    pop {pc}



_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall