/******************************************************************************
* temp doc for storing old lab3 (before cutting and pasting from test1.s
******************************************************************************/


/******************************************************************************
* 
* Data
* 
******************************************************************************/
.data

/*******************************display strings*****************************************/
.balign 4
welcomeMsg: .asciz "Hello and welcome to Tyler Goodwyn's candy vending machine.\n"
@Please select what candy you would like by typing the letter that the candy starts with. \n"

/*******************************numeric variables*****************************************/
.balign 4
gumInventory: .word 2
@ .balign 4
@ peanutInventory: .word 2
@ .balign 4
@ crackerInventory: .word 2
@ .balign 4
@ mandmInventory: .word 2

.balign 4
amountInserted: .word 0

.balign 4
intInputFmt:.asciz "%d"
.balign 4
strInputFmt:.asciz "%s\n"
.balign 4
charInputFmt: .asciz "%c"

.balign 4
gumInvPrint:.asciz "Gum inventory is %d\n"

/******************************************************************************
* 
* Program
* 
******************************************************************************/
.text
.global main
main:
/******************************************************************************
* 
* Welcome, and prompt
* 
******************************************************************************/
welcome:

get_candy_selection:
@prompt
ldr r0, =welcomeMsg 
bl  printf     

@ scan and load into r0
ldr r0, =intInputFmt
ldr r1, =scannedStmt
bl  scanf
ldr r0, =scannedStmt
ldr r1, [r0]

@print out input
ldr r0, =printStmt 
bl  printf

ldr r0, =gumInventory
ldr r1, [r0]
@print out input
ldr r0, =gumInvPrint 
bl  printf            


@ scan and load into r0
ldr r0, =intInputFmt
ldr r1, =amountInserted
bl  scanf
ldr r0, =gumInventory
ldr r2, =amountInserted
ldr r1, [r2]
str r1, [r0]
ldr r1, [r0]

@ ldr r0, =gumInventory
@ ldr r1, [r0]
@print out input
ldr r0, =gumInvPrint 
bl  printf  





@ TODO write test program that whatever amount user inputs gets added to a variable
@ that has been initialized in memory
@ then retrieved from memory and printed out

/******************************************************************************
* 
* compare and branch
* 
******************************************************************************/
branch_selection:
    @ square
    ldr r2, =square     
    ldr r3, [r2] 
    cmp r0, r3
    beq mandm_sr

    @ rectangle
    ldr r2, =rectangle    
    ldr r3, [r2] 
    cmp r0, r3
    beq crack_sr

  
    @ trapezoid
    ldr r2, =trapezoid    
    ldr r3, [r2] 
    cmp r0, r3
    beq peanut_sr

    @ triangle
    ldr r2, =triangle  
    ldr r3, [r2] 
    cmp r0, r3
    beq gum_sr

    @ exit
    ldr r2, =exit_choice 
    ldr r3, [r2] 
    cmp r0, r3
    beq _exit

    @ invalid choice, return user to selection prompt  
    b invalid_print

/******************************************************************************
* 
* set the initial inventory to two of each kind
* 
******************************************************************************/

/******************************************************************************
* 
* prompt
* 
* 
******************************************************************************/

@ TODO make strings in data
@ edit for new lab

stop:

mov r7, #0x01 
svc 0 