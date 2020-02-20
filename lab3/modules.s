@test
TODO see if this assignment asks us to state the inventory at any point in program (e.g. with a hidden input)
ldr r4, =currentInventory
ldr r1, [r4]
ldr r0, =stateCurrentInventory
bl printf

@ place this in every place that you need to check whether an inventory is empty or nt
ldr r4, =currentInventory
ldr r5, [r4]
cmp r5, #0
ble empty

@ global variable storage
@ from page 58 of thinkingeek pdf
main:
ldr r1, =return @ r1 <- &return
str lr, [r1] @ *r1 <- lr