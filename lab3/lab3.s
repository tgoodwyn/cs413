/******************************************************************************
* 
* This is a template for
* prompt -> scan -> print w/ input 
* sections
* 
******************************************************************************/

/**************************** data **************************************************/
.data
.balign 4
welcomeMsg: .asciz "Hello and welcome to Tyler Goodwyn's vending machine. Please select what snack you would like...\n"
.balign 4
scannedStmt: .word 0

.balign 4
intInputFmt:.asciz "%d"
.balign 4
strInputFmt:.asciz "%s"
.balign 4
chrInputFmt: .asciz "%c"

.balign 4
mandmDispense: .asciz "Dispensing m & m's\n"
.balign 4
crackDispense: .asciz "Dispensing peanuts\n"
.balign 4
peanutDispense: .asciz "Dispensing cheese crackers\n"
.balign 4
gumDispense: .asciz "Dispensing gum\n"
.balign 4
printStmt: .asciz "You typed: %d\n"

.balign 4
generic_error_message: .asciz "Improper input. Resetting program... \n"

.balign 4
gumInventory: .word 2
.balign 4
gumInvPrint:.asciz "Gum inventory is %d\n"

/**************************** program **************************************************/
.text
.global main
main:

welcome:

@prompt
ldr r0, =welcomeMsg
bl  printf     

@ scan and load into r0
ldr r0, =intInputFmt
ldr r1, =scannedStmt
bl  scanf
ldr r0, =scannedStmt
ldr r1, [r0]

@ send user to pump screen
cmp r1, #'m'
beq mandm_sr

    @ rectangle
cmp r1, #'c'
beq crack_sr

  
cmp r1, #'p'
beq peanut_sr

@ send user to hidden screen
cmp r1, #'h'
beq gum_sr

@added
ldr r0, =gumInventory
str r1, [r0]

ldr r1, [r0]
@print out input
ldr r0, =gumInvPrint 
bl  printf

mandm_sr:
b confirm_mandm
@ following two lines copy to other 3, w correct prices
@ mov r0, #55 (price)
@ b get_payment
@ get_payment will get payment, dispense change, and pop pc back to here
@ purposefully comes before printing "dispensing <snack>"
ldr r0, =mandmDispense
blprintf
b stop
crack_sr:
b confirm_crack
ldr r0, =crackDispense
blprintf
b stop
peanut_sr:
b confirm_peanut
ldr r0, =peanutDispense
blprintf
b stop
gum_sr:
b confirm_gum
ldr r0, =gumDispense
blprintf
b stop
confirm_mandm:
push {lr}
ldr r0, =
bl ynPrompt
cmp r0, #"y"
pop {r2}
mov lr, r2
moveq pc, lr
cmp r0, #"n"
beq welcome
b invalid_input

confirm_crack:
push {lr}
ldr r0, =
bl ynPrompt
cmp r0, #"y"
pop {r2}
mov lr, r2
moveq pc, lr
cmp r0, #"n"
beq welcome
b invalid_input

confirm_peanut:
push {lr}
ldr r0, =
bl ynPrompt
cmp r0, #"y"
pop {r2}
mov lr, r2
moveq pc, lr
cmp r0, #"n"
beq welcome
b invalid_input

confirm_gum:
push {lr}
ldr r0, =
bl ynPrompt
cmp r0, #"y"
pop {r2}
mov lr, r2
moveq pc, lr
cmp r0, #"n"
beq welcome
b invalid_input

ynPrompt:
push {lr}
ldr r0, =charInputFmt
ldr r1, =scannedStmt
bl  scanf
ldr r1, =scannedStmt
ldr r0, [r1]
pop {pc}

invalid_input:
ldr r0, =generic_error_message
b welcome
/******************************************************************************
* 
* gum inventory part
* (working @ 11:32pm)
******************************************************************************/

@prompt
ldr r0, =gumInventory
ldr r1, [r0]
ldr r0, =gumInvPrint 
bl  printf     

@ scan and load into r0
ldr r0, =intInputFmt
ldr r1, =scannedStmt
bl  scanf
ldr r0, =scannedStmt
ldr r1, [r0]

@added
ldr r0, =gumInventory
str r1, [r0]

ldr r1, [r0]
@print out input
ldr r0, =gumInvPrint 
bl  printf


@ bl  printf  

stop:

mov r7, #0x01 
svc 0    
