/******************************************************************************
* Lab 1
* CS 413
* Menon - 01
* Tyler Goodwyn
******************************************************************************/
.data

.balign 4
 welcomePrint: .asciz "Welcome. Please select a shape.\n"
.balign 4
 selection: .word 0
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
 squareArea: .asciz "The area of the square is %d\n"
.balign 4
 rectangleArea: .asciz "The area of the rectangle is %d\n"
.balign 4
 trapezoidArea: .asciz "The area of the trapezoid is %d\n"
.balign 4
 triangleArea: .asciz "The area of the triangle is %d\n"
 .balign 4
invalidPrint: .asciz "Invalid choice. Type square, rectangle, triangle, or trapezoid . Or exit r\n"
 .balign 4
againPrint: .asciz "Choose another. Or exit r\n"

.balign 4 
squareLPrompt  .asciz   “Enter square length: \n”
.balign 4 
rectLPrompt  .asciz   “Enter recentagle length: \n”
.balign 4 
rectHPrompt .asciz   “Enter recentagle height: \n”
.balign 4 
triLPrompt .asciz   “Enter triangle length: \n”
.balign 4 
triHPrompt .asciz   “Enter triangle height: \n”
.balign 4 
trapAPrompt .asciz   “Enter trapezoid length A: \n”
.balign 4 
trapBPrompt  .asciz   “Enter trapezoid length B: \n”
.balign 4 
trapHPrompt  .asciz   “Enter trapezoid height: \n”

sqL  .word 0
rectL  .word 0
rectH .word 0
triL .word 0
triH .word 0
trapA .word 0
trapB  .word 0
trapH  .word 0

.global main
main:
b welcome_print
@ b go_again

welcome_print:
    ldr r0, =welcomePrint
    bl  printf
    b get_input 
invalid_print:
    ldr r0, =invalidPrint
    bl  printf
    b get_input 
go_again:
    ldr r0, =againPrint
    bl  printf
    b get_input 
@-----------------------------------------------------------------------------------------
@ TODO
@ if you have two different input prompts
@ (welcome and go again)
@ you need to explicitly branch to get_input from each
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
    b branch_selection:

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
    cmp r1, r3
    beq square_sr

    @ rectangle
    ldr r2, =rectangle    
    ldr r3, [r2] 
    cmp r1, r3
    beq rectangle_sr

  
    @ trapezoid
    ldr r2, =trapezoid    
    ldr r3, [r2] 
    cmp r1, r3
    beq trapezoid_sr

    @ triangle
    ldr r2, =triangle  
    ldr r3, [r2] 
    cmp r1, r3
    beq triangle_sr

    @ invalid choice, return user to selection prompt  
    b invalid_print

@-----------------------------------------------------------------------------------------
@
@ main subroutines for each shape
@ 
@
@-----------------------------------------------------------------------------------------
/*
sub sp, sp, #4  /* sp ← sp - 8. This enlarges the stack by 8 bytes */
str lr, [sp]    /* *sp ← lr */
... // Code of the function
ldr lr, [sp]    /* lr ← *sp */
add sp, sp, #8  /* sp ← sp + 8
*/
square_sr:
    sub sp, sp, #4 
    bl square_sr_params
    bl square_sr_area
    bl square_sr_print
rectangle_sr:
    bl rectangle_sr_params
    bl rectangle_sr_area
    bl rectangle_sr_print
trapezoid_sr:
    bl trapezoid_sr_params
    bl trapezoid_sr_area
    bl trapezoid_sr_print
triangle_sr:
    bl triangle_sr_params
    bl triangle_sr_area
    bl triangle_sr_print

evaluate_selection:

@-----------------------------------------------------------------------------------------
@
@ get parameters
@ registers r4-r6 store the parameters before calling calculate_area
@ registers r7-r9 store the parameters after  calling calculate_area
@
@-----------------------------------------------------------------------------------------
/*
sub sp, sp, #8  /* sp ← sp - 8. This enlarges the stack by 8 bytes */
str lr, [sp]    /* *sp ← lr */
... // Code of the function
ldr lr, [sp]    /* lr ← *sp */
add sp, sp, #8  /* sp ← sp + 8
*/
get_params:
square_sr_params

    push {lr}
    
    ldr r0, =squareLPrompt
    bl  printf

    ldr r0, =intInputFormat
    ldr r1, =sqL                              
    bl  scanf 
    add sp, sp, #4
    str r0, [sp]
    sub sp, sp, #4

 

    pop {pc}


rectangle_sr_params
    @ prompt for length, height
    ldr r0, =invalidChoice
    bl  printf
    ldr r0, =invalidChoice
    bl  printf

    beq rectangle_sr_area


trapezoid_sr_params
    beq trapezoid_sr_area


triangle_sr_params
    beq triangle_sr_area


@-----------------------------------------------------------------------------------------
@
@ calculate areas
@
@
@-----------------------------------------------------------------------------------------

calculate_area:

square_sr_area:
    beq square_sr_print


rectangle_sr_area:
    beq rectangle_sr_print


trapezoid_sr_area:
    beq trapezoid_sr_print


triangle_sr_area:
    beq triangle_sr_print


@-----------------------------------------------------------------------------------------
@
@ print result
@
@
@-----------------------------------------------------------------------------------------

square_sr_print   :
    mov r1, #4
    ldr r0, =squareArea
    bl  printf 

rectangle_sr_print:
    mov r1, #4
    ldr r0, =rectangleArea
    bl  printf 
trapezoid_sr_print:
    mov r1, #4
    ldr r0, =trapezoidArea
    bl  printf 
triangle_sr_print  :
    mov r1, #4
    ldr r0, =triangleArea
    bl  printf 
print_area:



