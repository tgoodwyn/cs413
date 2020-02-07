


.global main
.func main
main:
read:
    bl print_subr
    b _exit
print_subr:
    
    push {lr}
    ldr r0, =printf_str
    bl printf
    pop {pc}

_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
.data 
.balign 4
a:              .skip       400
printf_str:     .asciz      "a = \n"
exit_str:       .ascii      "Terminating program.\n"