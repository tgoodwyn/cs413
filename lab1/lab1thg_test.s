/******************************************************************************
* Lab 1
* CS 413
* Menon - 01
* Tyler Goodwyn
******************************************************************************/
.data

@ still going strong

.balign 4
A:              
.word 4, 10, 4, -10, -6, 10, 6, 3, -6, 4
B:
.word 1, 3, -6, -9, 9, 0, 0, -2, -8, 4
C:
.skip 40
.balign 4
choicePrompt: .asciz "Enter positive, negative, or zero: \n"
choice: .word 0
.balign 4
strInputFormat: .asciz "%s"
.balign 4
p: .asciz "positive"
.balign 4
n: .asciz "negative"
.balign 4
z: .asciz "zero"
.balign 4
invalidChoice: .asciz "invalid choice (use all lowercase)\n"
.balign 4
positiveChosen: .asciz "sum array with only positives: \n"
.balign 4
negativeChosen: .asciz "sum array with only negatives: \n"
.balign 4
zeroChosen: .asciz "sum array with only zeroes: \n"
.balign 4
printf_str:     .asciz      "%c[%d] = %d\n"
.balign 4
digit: .asciz "%d \n"
.balign 4
exit_str:       .asciz      "Terminating program.\n"




.text

.global main
.func main
   
main:

initialization:
    BL init_array_C
calls:
    bl print_init_arrays
    bl prompt_input
    B readdone

@
@
@ subroutine #1
@ print arrays
@
@

print_init_arrays:
    PUSH {LR} 
    LDR R4, =A
    Mov R5, #'A'
    BL _print_arr
    LDR R4, =B
    mov R5, #'B'
    BL _print_arr
    LDR R4, =C
    mov R5, #'C'
    BL _print_arr
    B done
_print_arr:
    PUSH {LR} 
    mov r0, #0
_print_loop:
    CMP R0, #10       
    BEQ done       
    LDR R1, [R4], #4 @change back to r2     
    PUSH {R0}         
    PUSH {R1}         
    PUSH {R2} 
    mov r3, r1        
    MOV R2, R0        
    MOV R1, R5        
    BL  _printf       
    POP {R2}          
    POP {R1}          
    POP {R0}          
    ADD R0, R0, #1    
    B   _print_loop       

@ subroutine #2
@ populate sum array
@

init_array_C:
    PUSH {LR} 
    mov r0, #0
    ldr r1, =A
    ldr r2, =B
    ldr r3, =C
loop:    
    cmp r0, #10           
    beq done     
    @LSL R6, R0, #2     
    @ADD R3, R3, R6 
    LDR R4, [R1], #4
    LDR R5, [R2], #4
    add r4, r4, r5
    str r4, [r3], #4    
    add r0, r0, #1         
    b loop

@added comment

@
@
@ subroutine #3
@ get input
@
@

prompt_input:
    push {LR}
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

    @ negative
    ldr r2, =n     
    ldr r3, [r2] 
    cmp r1, r3
    beq negative

    @ positive
    ldr r2, =p     
    ldr r3, [r2] 
    cmp r1, r3
    beq positive

    @ zero
    ldr r2, =z     
    ldr r3, [r2] 
    cmp r1, r3
    beq zero

    @ invalid choice, return user to selection prompt
    ldr r0, =invalidChoice
    bl  printf   
    b input_loop
    

@
@
@ subroutine(s) #4
@ display selected type
@
@

    positive:
        @ldr r0, =positiveChosen
        @bl  printf  
        ldr r2, =C
        mov r3, #0
    pos_loop:
        cmp r3, #10
        beq done
        ldr r0, =digit
        ldr r1, [r2], #4
        cmp r1, #0
        PUSH {R2}         
        PUSH {R3} 
        blgt printf
        POP {R3}          
        POP {R2}  
        add r3, r3, #1
        b pos_loop
    negative:
        @ldr r0, =zeroChosen
        @bl  printf  
        ldr r2, =C
        mov r3, #0
    neg_loop:
        cmp r3, #10
        beq done
        ldr r0, =digit
        ldr r1, [r2], #4
        cmp r1, #0
        PUSH {R2}         
        PUSH {R3} 
        bllt printf
        POP {R3}          
        POP {R2}  
        add r3, r3, #1
        b neg_loop
    zero:
        @ldr r0, =zeroChosen
        @bl  printf  
        ldr r2, =C
        mov r3, #0
    zero_loop:
        cmp r3, #10
        beq done
        ldr r0, =digit
        ldr r1, [r2], #4
        cmp r1, #0
        PUSH {R2}         
        PUSH {R3} 
        bleq printf
        POP {R3}          
        POP {R2}  
        add r3, r3, #1
        b zero_loop

@
@
@ utility 
@
@ 

done:
    POP { PC }

readdone:
    B _exit                 @ exit if done

_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   

