@ Will Bouasisavath - 007547473
@ Program to find prime numbers between two positive integers

.syntax unified
.cpu    cortex-a53
.fpu    neon-fp-armv8
.extern checkPrimeNumber
.extern printf
.extern scanf
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
    ldr r7, =int1
    ldr r7, [r7]
    add r7, r7, 1

    ldr r8, =int2
    ldr r8, [r8]

    @ r7, r8 loop vars

loop:

    cmp r7, r8
    bhi exit    @ break loop if i >= n2

    mov r0, r7  @ pass i to function
    bl checkPrimeNumber

    cmp r0, 1 @ checkPrimeNumber returned 1?
    ldreq r0, =format
    moveq r1, r7
    bleq printf

    add r7, r7, 1
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

