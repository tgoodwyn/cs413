
rectangle_sr:
    @ allot stack space for params
    sub sp, sp, #8 
    @ branch to get_params subroutine
    bl rectangle_sr_params
    @ load params into register 4 - 6
    @ height is top of stack, length beneath it
    ldr r4, [sp], #4 @ hight into r4
    ldr r5, [sp] @length into r5
    @ put parameters into parameter registers
    mov r0, r4
    mov r1, r5
    @ branch to get_area
    bl rectangle_sr_area
    @ get return from stack
    ldr r4, [sp]
    @ put saved parameters into read positions for print
    @ mov r7, #4
    @ mov r8, #5
    @ mov r4, #20

    mov r1, r7
    mov r2, r8
    @ put return value from area calc in last position
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
