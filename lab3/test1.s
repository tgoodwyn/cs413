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
welcomeMsg: .asciz "Hello .\n"
.balign 4
scannedStmt: .word 0

.balign 4
intInputFmt:.asciz "%d"
.balign 4
strInputFmt:.asciz "%s"
.balign 4
chrInputFmt: .asciz "%c"

.balign 4
printStmt: .asciz "You typed: %d\n"

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
