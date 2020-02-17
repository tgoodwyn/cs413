/******************************************************************************
* Lab 2
* CS 413
* Menon - 01
* Tyler Goodwyn
******************************************************************************/


/******************************************************************************
* 
* Data
* 
******************************************************************************/
.data

/*******************************display strings*****************************************/
welcomeMsg: .asciz "Hello and welcome to Tyler Goodwyn's candy vending machine. Please select what candy you would like by typing the letter that the candy starts with. \n"

/*******************************numeric variables*****************************************/
gumInventory: .word 2
peanutInventory: .word 2
crackerInventory: .word 2
mandmInventory: .word 2

/******************************************************************************
* 
* DISPLAY WELCOME MESSAGE
* 
* 
******************************************************************************/
welcome:

ldr r0, =welcomeMsg 
bl  printf              

@ TODO see if this assignment asks us to state the inventory at any point in program (e.g. with a hidden input)
@ ldr r4, =currentInventory
@ ldr r1, [r4]
@ ldr r0, =stateCurrentInventory
@ bl printf

@ place this in every place that you need to check whether an inventory is empty or nt
@ ldr r4, =currentInventory
@ ldr r5, [r4]
@ cmp r5, #0
@ ble empty

@ global variable storage
@ from page 58 of thinkingeek pdf
@ 31 main:
@ 32 ldr r1, =return @ r1 <- &return
@ 33 str lr, [r1] @ *r1 <- lr

@ TODO write test program that whatever amount user inputs gets added to a variable
@ that has been initialized in memory
@ then retrieved from memory and printed out

/******************************************************************************
* 
* set the initial inventory to two of each kind
* 
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
prompt_method_choice:

  ldr r5, [r4]
  cmp r5, #0
  ble empty

  ldr r0, =chooseMethodPrompt
  bl  printf              

  @ prompt choice
  ldr r0, =strInputFormat 
  ldr r1, =methodChosen                               
  bl  scanf   

  @ load input into r2
  ldr r2, =methodChosen      
  ldr r1, [r2]  

  @ send user to pump screen
  cmp r1, #'P'
  beq pump_begin

  @ send user to dollar input screen
  cmp r1, #'S'
  beq dollar_chosen

  @ send user to hidden screen
  cmp r1, #'H'
  beq hidden_chosen

  @ invalid choice, return user to selection prompt
  ldr r0, =invalidChoice
  bl  printf   
  b prompt_method_choice

