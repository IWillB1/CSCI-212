@ Will Bouasisavath - 007547473
@ Program to calculate Euclidean Algorithm


.syntax unified
.cpu    cortex-a53
.fpu    neon-fp-armv8
.data


storage: .space 80          @ added buffer


.text
.global main


main:                       @ removed

    @ prompt 1
    ldr r0, addr_prompt1     /*loading address of prompt message in r0*/
    bl  printf               /*calling printf*/

    ldr r0, addr_format     /*loading first parameter of scanf*/
    ldr r1, addr_storage    @ location to write data from input
    bl  scanf                /*calling scanf*/
    ldr r5, addr_storage   @ store first integer in r5
    ldr r5, [r5]

    @ prompt 2
    ldr r0, addr_prompt2     /*loading address of prompt message in r0*/
    bl  printf               /*calling printf*/

    ldr r0, addr_format     /*loading first parameter of scanf*/
    ldr r1, addr_storage    @ location to write data from input
    bl  scanf                /*calling scanf*/
    ldr r6, addr_storage          @ store second integer in r6
    ldr r6, [r6]

    @ Euclidean Algorithm
    @ step 1
    cmp r5, r6 @ a - b
    @ a < b ? swap r5 and r6
    movlt r7, r6
    movlt r6, r5
    movlt r5, r7 
    mov r7, 0


step2:

    udiv r0, r5, r6 @ quotient
    mul r1, r0, r6 @ need to compute remainder
    sub r2, r5, r1 @ r2 = remainder

    cmp r2, 0
    beq exit @ remainder != 0 ? we repeat step 2

    @ step 3
    mov r5, r6 @ replace a with b
    mov r6, r2
    b step2


exit:

    @ print result
    ldr r0, addr_string     @ printf format
    mov r1, r6
    bl  printf

    mov r0, 0              @ good return code
    mov r7, 1
    swi 0


format: .asciz "%d"

string: .asciz "The GCD is: %d\n"
prompt1: .asciz "Enter first positive integer: "
prompt2: .asciz "Enter second positive integer: "


addr_prompt1: .word prompt1
addr_prompt2: .word prompt2
addr_format: .word format
addr_string: .word string
addr_storage: .word storage @ address of buffer
