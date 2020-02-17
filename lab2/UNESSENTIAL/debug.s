.data

.balign 4
 strInputFormat: .asciz "%s"
 .balign 4
 intInputFormat: .asciz "%d"

.balign 4
 rectangleArea: .asciz "The area of a rectangle with length %d and height %d is %d\n"
.balign 4


.balign 4 
rectLPrompt:  .asciz   "Enter recentagle length: \n"
.balign 4 
rectHPrompt: .asciz   "Enter recentagle height: \n"

exit_str:       .asciz      "Terminating program.\n"
rectL:  .word 0
rectH: .word 0

.text
.global main
main:

rectangle_sr:
    sub sp, sp, #8 
    bl rectangle_sr_params
    ldr r4, [sp], #4 @ hight into r4
    ldr r5, [sp] @length into r5
    mov r0, r4
    mov r1, r5

    bl rectangle_sr_area
    ldr r4, [sp]
    mov r1, r7
    mov r2, r8
    mov r3, r4
    ldr r0, =rectangleArea
    @bl printf
    b _exit

rectangle_sr_params:
    
    push {lr}  
    @ return sp to fp
    add sp, sp, #8
    @@@ prompt for param 1  
    mov r1, #5
    @ store this in fp -4
    str r1, [sp], #-4
    @@@ prompt for param 2
    mov r2, #6
    @ store this in fp -8
    str r2, [sp], #-4
    pop {pc}

rectangle_sr_area:
    push {r4, r5, lr}
    mul r2, r0, r1
    add sp, sp, #12
    str r2, [sp]
    sub sp, sp, #12
    pop {r7, r8, pc}

_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall