@ Will Bouasisavath - 007547473
@ Program to calculate Fibonacci Sequence 


.syntax unified
.data

storage: .space 80          @ added buffer

.text
.global main


main:                       @ removed

    ldr r0, addr_prompt     /*loading address of prompt message in r0*/
    bl  printf               /*calling printf*/

    ldr r0, addr_format     /*loading first parameter of scanf*/
    ldr r1, addr_storage    @ location to write data from input
    bl  scanf                /*calling scanf*/


    @ SETUP FIBONACCI
    mov r0, 0 @ a = 0
    mov r1, 1 @ b = 1
    mov r2, 0 @ c = 0
    mov r3, 1 @ counter
    ldr r4, addr_storage
    ldr r4, [r4] @ get our term number to determine stop point


loop:

    add r2, r0, r1 @ c = a + b
    mov r0, r1 @ a = b
    mov r1, r2 @ b = c
    add r3, r3, 1 @ counter++
    cmp r4, r3 @ r4 - r3 == 0?
    bne loop @ true? then loop

    ldr r0, addr_string     @ printf format
    bl  printf

    mov r0, 0              @ good return code
    mov r7, 1
    swi 0


format: .asciz "%d"

string: .asciz "Output: %d\n"
prompt: .asciz "Input Fibonacci term #: "



addr_prompt: .word prompt
addr_format: .word format
addr_string: .word string
addr_storage: .word storage @ address of buffer
