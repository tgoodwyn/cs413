.data

.balign 4
strInputFormat: .asciz "%s"
.balign 4
intInputFormat: .asciz "%d"

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
    ldr r5, [sp], #4
    ldr r4, [sp], #4
    @ allot stack space for return value of area call
    @sub sp, sp, #4 
    @ put parameters into parameter registers
    @ branch to get_area
    @bl rectangle_sr_area
    @ get return from stack
    @ldr r4, [sp]
    @ put saved parameters into read positions for print
    @  mov r4, #4
    @  mov r5, #5
    @ mov r4, #20

    mov r1, r4
    mov r2, r5
    @ put return value from area calc in last position
    mov r3, #30
    ldr r0, =rectangleArea
    bl printf
    b _exit

rectangle_sr_params:
    
     push {lr}  
@     @ return sp to fp
    add sp, sp, #8
@     @@@ prompt for param 1  
@     ldr r0, =rectLPrompt
@     bl  printf
@     ldr r0, =intInputFormat
@     ldr r1, =rectL           
@     bl  scanf
@     ldr r0, =rectL
@     @ store param 1 in r1     
@     ldr r1, [r0] 
@     @ store this in fp -4
    mov r1, #10
    str r1, [sp], #-4

@     @@@ prompt for param 2 
@     ldr r0, =rectHPrompt
@     bl  printf
@     ldr r0, =intInputFormat
@     ldr r1, =rectH           
@     bl  scanf
@     ldr r1, =rectH
@     @ store param 2 in r2     
@     ldr r2, [r0]
@     @ store this in fp -8
    mov r2, #3
    str r2, [sp], #-4
     pop {pc}

@ rectangle_sr_area:
@     push {r4, r5, lr}
@     mul r2, r0, r1
@     add sp, sp, #12
@     str r2, [sp]
@     sub sp, sp, #12
@     pop {r7, r8, pc}

_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall