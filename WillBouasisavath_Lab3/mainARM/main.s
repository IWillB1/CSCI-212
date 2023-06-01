.syntax unified
.cpu    cortex-a53
.fpu    neon-fp-armv8

.text
.global main

main:

    @ prompt
    ldr r0, =prompt
    bl printf
    @ input
    ldr r0, =input
    ldr r1, =int1
    ldr r2, =int2
    bl scanf
    @ return prompt
    ldr r0, =return
    ldr r1, =int1
    ldr r1, [r1]
    ldr r2, =int2
    ldr r2, [r2]
    bl printf

    @ loop prologue
    ldr r6, =int1
    ldr r6, [r6]
    add r6, r6, 1

    ldr r7, =int2
    ldr r7, [r7]

    @ r6, r7 loop vars

loop:

    cmp r6, r7
    bhi exit    @ break loop if i >= n2

    mov r0, r6  @ pass i to function
    bl checkPrimeNumber

    cmp r0, 1 @ checkPrimeNumber returned 1?
    ldreq r0, =format
    moveq r1, r6
    bleq printf

    add r6, r6, 1
    b loop

exit:
    mov r0, 0
    mov r7, 1
    swi 0


.bss
int1: .space 4
int2: .space 4

.data
prompt: .asciz "Enter two positive integers: "
return: .asciz "Prime numbers between %d and %d are: \n"
format: .asciz "%d \n"
input:  .asciz "%d %d"

