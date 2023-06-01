.syntax unified
.cpu    cortex-a53
.fpu    neon-fp-armv8

.text
.global checkPrimeNumber
.type checkPrimeNumber, %function

checkPrimeNumber:

    mov     r1, 1 @@        flag        -> r1
    mov     r2, 2 @@        loop var    -> r2
    lsr     r3, r0, 1 @@    n / 2       -> r3

loop:

    cmp     r2, r3
    bhi     exit @@ j <= n / 2 ? continue : exit

    udiv    r4, r0, r2
    mul     r5, r4, r2
    sub     r6, r0, r5 @@ remainder     -> r6

    cmp     r6, 0
    moveq   r1, 0
    addne   r2, 1 @@ j++
    bne     loop

exit:
    mov     r0, r1
    bx      lr
