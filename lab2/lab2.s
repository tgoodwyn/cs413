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
 areaPrint: .asciz “The area is: %d \n”
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

@ put in b done at end of area calls
main:

prompt_selection:
input_loop:
    ldr r0, =choicePrompt
    bl  printf              

    @ prompt choice
    ldr r0, =strInputFormat 
    ldr r1, =choice                              
    bl  scanf 
      
    @ load input into r2
    ldr r2, =choice     
    ldr r1, [r2]  

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

calculate_area:


square_sr    :
    mov r0, #4
    ldr r0, =squareArea
    bl  printf 

rectangle_sr:
    mov r0, #4
    ldr r0, =rectangleArea
    bl  printf 
trapezoid_sr:
    mov r0, #4
    ldr r0, =trapezoidArea
    bl  printf 
triangle_sr  :
    mov r0, #4
    ldr r0, =triangleArea
    bl  printf 
print_area:



