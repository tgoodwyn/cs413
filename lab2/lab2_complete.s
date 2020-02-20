/******************************************************************************
* Lab 2
* CS 413
* Menon - 01
* Tyler Goodwyn
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
 areaPrint: .asciz "The area is: %d \n"
.balign 4
 rectangle: .asciz "rectangle"
.balign 4
 square: .asciz "square"
.balign 4
 trapezoid: .asciz "trapezoid"
.balign 4
 triangle: .asciz "triangle"
.balign 4
exit_choice: .asciz "exit"
.balign 4
 squareArea: .asciz "The area of a square of length %d is %d\n"
.balign 4
 rectangleArea: .asciz "The area of a rectangle with length %d and height %d is %d\n"
.balign 4
 trapezoidArea: .asciz "The area of a trapezoid with combined lengths %d and height %d is %d\n"
.balign 4
 triangleArea: .asciz "The area of a triangle with length %d and height %d is %d\n"
 .balign 4
invalidPrint: .asciz "Invalid choice. Type square, rectangle, triangle, or trapezoid . Or exit \n"
 .balign 4
generic_error_message: .asciz "Improper input. Please enter a positive integer. Resetting program... \n"
 .balign 4
overflowString: .asciz "Beware you have an overflow \n"

.balign 4
positiveIntPrompt: .asciz "Please enter a positive integer. \n"

.balign 4 
squareLPrompt:  .asciz   "Enter square length: \n"
.balign 4 
rectLPrompt:  .asciz   "Enter recentagle length: \n"
.balign 4 
rectHPrompt: .asciz   "Enter recentagle height: \n"
.balign 4 
triLPrompt: .asciz   "Enter triangle length: \n"
.balign 4 
triHPrompt: .asciz   "Enter triangle height: \n"
.balign 4 
trapAPrompt: .asciz   "Enter trapezoid length A: \n"
.balign 4 
trapBPrompt:  .asciz   "Enter trapezoid length B: \n"
.balign 4 
trapHPrompt:  .asciz   "Enter trapezoid height: \n"
.balign 4
exit_str:       .asciz      "Terminating program.\n"
.balign 4
sqL:  .word 0
.balign 4
rectL:  .word 0
.balign 4
rectH: .word 0
.balign 4
triL: .word 0
.balign 4
triH: .word 0
.balign 4
trapA: .word 0
.balign 4
trapB:  .word 0
.balign 4
trapH:  .word 0
.balign 4
dump:  .word 0

.global main
main:
mov fp, sp
b welcome_print

welcome_print:
	mov sp, fp
    ldr r0, =welcomePrint
    bl  printf
    b get_input 
invalid_print:
    ldr r0, =invalidPrint
    bl  printf
    b get_input 


@-----------------------------------------------------------------------------------------
@ 
@ get user selection
@ 
@
@-----------------------------------------------------------------------------------------

get_input:
    @ scanf boilerplate
    ldr r0, =strInputFormat 
    ldr r1, =selection                              
    bl  scanf 
      
    @ load input into r0
    ldr r2, =selection     
    ldr r0, [r2]  

    @ as a parameter for
    b branch_selection

@-----------------------------------------------------------------------------------------
@
@ evaluate selection
@ (compare it to possibilities)
@
@-----------------------------------------------------------------------------------------

branch_selection:
    @ square
    ldr r2, =square     
    ldr r3, [r2] 
    cmp r0, r3
    beq square_sr

    @ rectangle
    ldr r2, =rectangle    
    ldr r3, [r2] 
    cmp r0, r3
    beq rectangle_sr

  
    @ trapezoid
    ldr r2, =trapezoid    
    ldr r3, [r2] 
    cmp r0, r3
    beq trapezoid_sr

    @ triangle
    ldr r2, =triangle  
    ldr r3, [r2] 
    cmp r0, r3
    beq triangle_sr

    @ exit
    ldr r2, =exit_choice 
    ldr r3, [r2] 
    cmp r0, r3
    beq _exit

    @ invalid choice, return user to selection prompt  
    b invalid_print

@-----------------------------------------------------------------------------------------
@
@ main subroutines for each shape
@ 
@
@-----------------------------------------------------------------------------------------


square_sr:
    @ allot stack space for params
    sub sp, sp, #4 
    @ branch to get_params subroutine
    bl square_sr_params
    @ load params into register 4 - 6
    ldr r4, [sp]
    @ reuse allotted stack space for return value of area call
    @ put parameters into parameter registers
    mov r0, r4
    @mov r0, #4
    @ branch to get_area
    bl square_sr_area
    @ get return from stack
    ldr r4, [sp]
    @ put saved parameters into read positions for print
    mov r1, r7
    @ put return value from area calc in last position
    mov r2, r4
ldr r0, =overflowString
cmp r10, #0
blne printf
    ldr r0, =squareArea
    bl printf
    b welcome_print
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
ldr r0, =overflowString
cmp r10, #0
blne printf
    ldr r0, =rectangleArea
    bl printf
    b welcome_print

trapezoid_sr:
    @ branch to get_params subroutine
    bl trapezoid_sr_params
    @ load params into register 4 - 6
    ldr r6, [sp], #4
    ldr r5, [sp], #4 @ height into r5
    ldr r4, [sp] @ length into r4

    @ put parameters into parameter registers
    mov r0, r4 @ length A into r0
    mov r1, r5 @ length B into r1
    mov r2, r6 @ height into r1

    @ branch to get_area
    bl trapezoid_sr_area

    @ get return from stack
    ldr r4, [sp]

    @ put saved parameters into read positions for print
    add r1, r7, r8
    mov r2, r9 @ height into r2
    @ put return  in last position
    mov r3, r4
ldr r0, =overflowString
cmp r10, #0
blne printf
    ldr r0, =trapezoidArea
    bl printf
    b welcome_print

triangle_sr:
    @ branch to get_params subroutine
    bl triangle_sr_params
    @ load params into register 4 - 6
    ldr r5, [sp], #4 @ height into r5
    ldr r4, [sp] @ length into r4

    @ put parameters into parameter registers
    mov r0, r4 @ length into r0
    mov r1, r5 @ height into r1

    @ branch to get_area
    bl triangle_sr_area

    @ get return from stack
    ldr r4, [sp]
    @ put saved parameters into read positions for print
    mov r1, r7 @ length into r1
    mov r2, r8 @ height into r2
    @ put return  in last position
    mov r3, r4
ldr r0, =overflowString
cmp r10, #0
blne printf
    ldr r0, =triangleArea
    bl printf
    b welcome_print


@-----------------------------------------------------------------------------------------
@
@ get parameters
@
@
@-----------------------------------------------------------------------------------------

get_params:

square_sr_params:

    push {lr}    
    ldr r0, =squareLPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =sqL           
    bl  scanf
cmp r0, #0
beq generic_error

    ldr r1, =sqL     
    ldr r0, [r1]

cmp r0, #0
ble invalid_parameter_sqL
 
    add sp, sp, #4
    str r0, [sp]
    sub sp, sp, #4
    pop {pc}
    
rectangle_sr_params:

    push {lr}  

    @@@ prompt for param 1  
    ldr r0, =rectLPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =rectL           
    bl  scanf
cmp r0, #0
beq generic_error
    ldr r1, =rectL   
    ldr r0, [r1]
cmp r0, #0
ble invalid_parameter_rectL
mov r4, r0

    @@@ prompt for param 2 
    ldr r0, =rectHPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =rectH           
    bl  scanf
cmp r0, #0
beq generic_error
    ldr r1, =rectH   
    ldr r0, [r1]
cmp r0, #0
ble invalid_parameter_rectH
mov r5, r0

    @ return sp to fp
    add sp, sp, #8
    @ store param 1 in fp -4
    str r4, [sp], #-4
    @ store this in fp -8
    str r5, [sp], #-4

    pop {pc}


triangle_sr_params:
    push {lr}  

    @@@ prompt for param 1  
    ldr r0, =triLPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =triL           
    bl  scanf
cmp r0, #0
beq generic_error
    ldr r1, =triL
    @ store param 1 in r4    
    ldr r0, [r1]
cmp r0, #0
ble invalid_parameter_triL
mov r4, r0


    @@@ prompt for param 2 
    ldr r0, =triHPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =triH           
    bl  scanf
cmp r0, #0
beq generic_error
    ldr r1, =triH
    @ store param 2 in r5    
    ldr r0, [r1]
cmp r0, #0
ble invalid_parameter_triH
mov r5, r0
    @ return sp to fp
    add sp, sp, #8
    @ store param 1 in fp -4
    str r4, [sp], #-4
    @ store param 2 in fp -8
    str r5, [sp], #-4

    pop {pc}


trapezoid_sr_params:
    push {lr}  

    @@@ prompt for param 1  
    ldr r0, =trapAPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =trapA           
    bl  scanf
cmp r0, #0
beq generic_error
    ldr r1, =trapA
    @ store param 1 in r4    
    ldr r0, [r1]
cmp r0, #0
ble invalid_parameter_trapA
mov r4, r0

    @@@ prompt for param 2 
    ldr r0, =trapBPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =trapB           
    bl  scanf
cmp r0, #0
beq generic_error
    ldr r1, =trapB
    @ store param 2 in r5    
    ldr r0, [r1]
cmp r0, #0
ble invalid_parameter_trapB
mov r5, r0
    @@@ prompt for param 3 
    ldr r0, =trapHPrompt
    bl  printf
    ldr r0, =intInputFormat
    ldr r1, =trapH           
    bl  scanf
cmp r0, #0
beq generic_error
    ldr r1, =trapH
    @ store param 3 in r6    
    ldr r0, [r1]
cmp r0, #0
ble invalid_parameter_trapH
mov r6, r0
    @ return sp to fp
    add sp, sp, #12
    @ store param 1 in fp -4
    str r4, [sp], #-4
    @ store param 2 in fp -8
    str r5, [sp], #-4
    @ store param 3 in fp -8
    str r6, [sp], #-4

    pop {pc}

@-----------------------------------------------------------------------------------------
@
@ generic error routine
@
@
@-----------------------------------------------------------------------------------------

generic_error:

ldr r0,=generic_error_message
bl printf
ldr r0, = strInputFormat
sub sp, sp, #4
mov r1, sp
bl scanf
ldr r1, [sp, #0]
add sp, sp, #4
b welcome_print

@-----------------------------------------------------------------------------------------
@
@ invalid parameters
@
@
@-----------------------------------------------------------------------------------------

invalid_parameter_sqL:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =sqL           
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =sqL     
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_sqL
	pop {pc}

invalid_parameter_rectL:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =rectL           
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =rectL     
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_rectL
	pop {pc}

invalid_parameter_rectH:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =rectH           
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =rectH     
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_rectH
	pop {pc}

invalid_parameter_triL:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =triL          
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =triL    
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_triL
	pop {pc}
invalid_parameter_triH:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =triH           
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =triH     
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_triH
	pop {pc}
invalid_parameter_trapA:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =trapA           
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =trapA     
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_trapA
	pop {pc}
invalid_parameter_trapB:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =trapB           
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =trapB    
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_trapB
	pop {pc}
invalid_parameter_trapH:
	push {lr}
	ldr r0, =positiveIntPrompt
	bl  printf
	ldr r0, =intInputFormat
	ldr r1, =trapH           
	bl  scanf
cmp r0, #0
beq generic_error
	ldr r1, =trapH    
	ldr r0, [r1]
	cmp r0, #0
	ble invalid_parameter_trapH
	pop {pc}


@-----------------------------------------------------------------------------------------
@
@ flush string
@
@
@-----------------------------------------------------------------------------------------
flush_string:

ldr r0,=strInputFormat
ldr r1,=dump
bl scanf
b invalid_parameter_sqL


@-----------------------------------------------------------------------------------------
@
@ calculate areas
@
@
@-----------------------------------------------------------------------------------------
calculate_area:
square_sr_area:
    push {r4, lr}
    umull r1,r10, r0, r0
    add sp, sp, #8
    @mov r1, #9
    str r1, [sp]
    sub sp, sp, #8
    pop {r7, pc}



rectangle_sr_area:
    @      length \- height \- lr -\ (tos)
    push { r4,       r5,       lr }
    umull r2, r10, r0, r1
    add sp, sp, #12
    str r2, [sp]
    sub sp, sp, #12
    @ (tos) /- length /- height /- lr
    pop      { r7,       r8,       pc }



trapezoid_sr_area:
    @ length A \-, length B \- height \- lr -\ (tos)
    push { r4,      r5,     r6,     lr }
    add r1, r0, r1
    mov r1, r1, ASR #1
    umull r3, r10, r2, r1
    add sp, sp, #16
    str r3, [sp]
    sub sp, sp, #16
    @ (tos) /- length A /- length B /- height /- lr
    pop { r7,      r8,     r9,     pc }


triangle_sr_area:
    @      length \- height \- lr -\ (tos)
    push { r4,       r5,       lr }
    umull r2, r10, r0, r1
    mov r2, r2, ASR #1
    add sp, sp, #12
    str r2, [sp]
    sub sp, sp, #12
    @ (tos) /- length /- height /- lr
    pop      { r7,       r8,       pc }

_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
@-----------------------------------------------------------------------------------------
@
@ print result
@
@
@-----------------------------------------------------------------------------------------
/*
pi@raspberrypi:~ $ ./lab2
Welcome. Please select a shape.
invalid
Invalid choice. Type square, rectangle, triangle, or trapezoid . Or exit 
square
Enter square length: 
0
Please enter a positive integer. 
-10
Please enter a positive integer. 
abc
Improper input. Please enter a positive integer. Resetting program... 
Welcome. Please select a shape.
square
Enter square length: 
10
The area of a square of length 10 is 100
Welcome. Please select a shape.
rectangle
Enter recentagle length: 
10
Enter recentagle height: 
15
The area of a rectangle with length 10 and height 15 is 150
Welcome. Please select a shape.
triangle
Enter triangle length: 
10
Enter triangle height: 
50
The area of a triangle with length 10 and height 50 is 250
Welcome. Please select a shape.
trapezoid
Enter trapezoid length A: 
10
Enter trapezoid length B: 
25
Enter trapezoid height: 
50
The area of a trapezoid with combined lengths 35 and height 50 is 875
Welcome. Please select a shape.
square
Enter square length: 
600000000
Beware you have an overflow 
The area of a square of length 0 is 1
Welcome. Please select a shape.
exit
Terminating program.
*/



