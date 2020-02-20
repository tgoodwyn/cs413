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

@print out input
ldr r0, =printStmt 
bl  printf

stop:

mov r7, #0x01 
svc 0    

/******************************************************************************
* 
* Notes
* 
******************************************************************************/

@ %d, and for the format variables, should not be followed by a newline char
@ if you dont have some sort of exit, you get segmentation fault

/**************************** format permutations **************************************************/
@ expecting: %d, given: number, outfmt: %d, output: the number entred
@ expecting: %d, given: single char (e.g. "G", "d", "a"), outfmt: %d, output: 0 ("you typed: 0")
@ expecting: %d, given: string (e.g. "square", "squaresquare"),outfmt: %d,  output: 0
@ expecting: %d, given: number, outfmt: %c, output: a question mark <symbol> in a box ("you typed: <symbol>")
@ expecting: %d, given: single char (e.g. "G", "d", "a"), outfmt: %c, output: blank ("you typed: ")
@ expecting: %d, given: string (e.g. "square", "squaresquare"),outfmt: %c,  output: blank
@ expecting: %d, given: number, outfmt: %s, output: segmentation fault ("segmentation fault")
@ expecting: %d, given: single char (e.g. "G", "d", "a"), outfmt: %s, output: null ("you typed: (null)")
@ expecting: %d, given: string (e.g. "square", "squaresquare"),outfmt: %s,  output: null



@ %c variants
@ expecting: %c, given: single char, outfmt: %c, output: the char entered (case matched)
@ expecting: %c, given: number, outfmt: %c, output: the first digit of whatever # was entered
@ expecting: %c, given: string, outfmt: %c, output: first letter of string (case matched)
@ expecting: %c, given: single char, outfmt: %d, output: the ascii value of the char given
@ expecting: %c, given: number, outfmt: %d, output: the ascii value of the first digit entered (e.g. 8 -> 56, 86 -> 56)
@ expecting: %c, given: string, outfmt: %d, output: the ascii value of first char given
@ expecting: %c, given: single char, outfmt: %s, output: segmentation fault
@ expecting: %c, given: number, outfmt: %s, output: segmentation fault
@ expecting: %c, given: string, outfmt: %s, output: segmentation fault

@ %s variants
@ expecting: %s, given: string, outfmt: %s, output: segmentation fault
@ expecting: %s, given: single char, outfmt: %s, output:segmentation fault
@ expecting: %s, given: number, outfmt: %s, output:segmentation fault
@ expecting: %s, given: string, outfmt: %c, output: behaves identically to when expecting %c
@ expecting: %s, given: single char, outfmt: %c, output: behaves identically to when expecting %c
@ expecting: %s, given: number, outfmt: %c, output: behaves identically to when expecting %c
@ expecting: %s, given: string, outfmt: %d, output: behaves identically to when expecting %c
@ expecting: %s, given: single char, outfmt: %d, output: behaves identically to when expecting %c
@ expecting: %s, given: number, outfmt: %d, output: behaves identically to when expecting %c