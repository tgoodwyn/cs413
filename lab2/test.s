.data

.balign 4
strInputFormat: .asciz "%s"
.balign 4
intInputFormat: .asciz "%d"

.balign 4
rectangleArea_mini: .asciz "The area of a rectangle is %d\n"
.balign 4
rectangleArea_proper: .asciz "The area of a rectangle with length %d and height %d is %d\n"
.balign 4 
rectLPrompt:  .asciz   "Enter recentagle length: \n"
.balign 4 
rectHPrompt: .asciz   "Enter recentagle height: \n"

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
    sub sp, sp, #4
    bl rectangle_sr_params
    ldr r0, =rectangleArea_mini
    bl printf
    b _exit

rectangle_sr_params:
    
    push {lr}  
    add sp, sp, #4
    @ ldr r0, =rectLPrompt
    @ bl  printf
    @ ldr r0, =intInputFormat
    @ ldr r1, =rectL           
    @ bl  scanf
    mov r1, #10


    pop {pc}



_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall