@ roll_dice.s
@ a function to generate the 100 dice rolls (the values are 1-6)
@ and store them into an array of 100 integers.
@ Call this function "roll_dice"
@ This function should take in as input, an array and return the dice rolls
@ stored into the array, i.e.roll)dice(int arr[100])
@ Will Bouasisavath - 007547473


.syntax unified

.data
random: .space 4

.text
.global roll_dice
.type roll_dice, %function

roll_dice:

    push {r4-r8}

    mov r4, r0 @ r4 == array pointer
    @ syscall 384
    mov r7, 384
    ldr r8, =random
    mov r5, 0 @ r5 == counter/index

.loop:

    cmp r5, 100 @ if i < 100, continue, else
    bge .exit @ branch >= 100

    @getrandom(*buffer [r0], size bytes [r1], 0 [r2])
    ldr r0, =random
    mov r1, 4
    mov r2, 0
    svc 0
    @ return a value in r0
    ldr r1, [r8]
    and r1, r1, 7

    cmp r1, 0
    beq .loop
    cmp r1, 7
    beq .loop
    @ LSL == multiply
    mov r6, r5, lsl 2 @ counter * (2**2)
    str r1, [r4, r6]

    add r5, r5, 1
    b .loop

.exit:

    pop {r4-r8}
    bx lr