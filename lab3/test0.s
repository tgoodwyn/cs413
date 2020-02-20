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

