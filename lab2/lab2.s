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
invalidChoice: .asciz "Invalid choice. Type square, rectangle, triangle, or trapezoid . Or exit r\n"

@ put in b done at end of area calls
.global main
main:

prompt_selection:
input_loop:
    ldr r0, =welcomePrint
    bl  printf              

    @ prompt choice
    ldr r0, =strInputFormat 
    ldr r1, =selection                              
    bl  scanf 
      
    @ load input into r2
    ldr r2, =selection     
    ldr r1, [r2]  

@-----------------------------------------------------------------------------------------
@
@ evaluate selection
@ (compare it to possibilities)
@
@-----------------------------------------------------------------------------------------
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
    ldr r0, =invalidChoice
    bl  printf   
    b input_loop

evaluate_selection:

@-----------------------------------------------------------------------------------------
@
@ calculate areas
@
@
@-----------------------------------------------------------------------------------------

get_params:
square_sr_params
    beq square_sr_area


rectangle_sr_params
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



