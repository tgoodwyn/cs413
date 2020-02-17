.data

.balign 4
strInputFormat: .asciz "%s"
.balign 4
intInputFormat: .asciz "%d"

.balign 4
rectangleArea: .asciz "The area of a rectangle with length %d and height %d is %d\n"

.balign 4 
rectLPrompt:  .asciz   "Enter rectangle length: \n"
.balign 4 
rectHPrompt: .asciz   "Enter rectangle height: \n"

.balign 4 
exit_str:       .asciz      "Terminating program.\n"
.balign 4
rectL:  .word 0
.balign 4
rectH: .word 0

.text
.global main
main:

rectangle_sr:

    @ branch to get_params subroutine
    bl rectangle_sr_params
    @ load params into register 4 - 6
    ldr r5, [sp], #4 @ height into r5
    ldr r4, [sp] @ length into r4

    @ put parameters into parameter registers
    mov r0, r4 @ length into r0
    mov r1, r5 @ height into r1

    @ branch to get_area
    bl rectangle_sr_area

    @ get return from stack
    ldr r4, [sp]
    @ put saved parameters into read positions for print
    mov r1, r7 @ length into r1
    mov r2, r8 @ height into r2
    @ put return  in last position
    mov r3, r4
    ldr r0, =rectangleArea
    bl printf
    b _exit

rectangle_sr_params:
    
    push {lr}  

    @@@ prompt for param 1  
    ldr r0, =rectLPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =rectL           
    bl  scanf
    ldr r0, =rectL
    @ store param 1 in r4    
    ldr r4, [r0]



    @@@ prompt for param 2 
    ldr r0, =rectHPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =rectH           
    bl  scanf
    ldr r0, =rectH
    @ store param 2 in r5    
    ldr r5, [r0]

    @ return sp to fp
    add sp, sp, #8
    @ store param 1 in fp -4
    str r4, [sp], #-4
    @ store this in fp -8
    str r5, [sp], #-4

    pop {pc}

rectangle_sr_area:
    @ length -> height -> lr
    push {r4, r5, lr}
    mul r2, r0, r1
    add sp, sp, #12
    str r2, [sp]
    sub sp, sp, #12
    @ length <- height <- pc
    pop {r7, r8, pc}

_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall