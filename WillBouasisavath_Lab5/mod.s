.syntax unified
@ mov r0, divisor
@ mov r1,

.text
.global mod
.type mod, %function

mod:

    push {fp, lr}
    mov fp, sp
    udiv    r3, r0, r1      @ no, div to get quotient
    mul     r1, r3, r1      @ need for computing remainder
    sub     r0, r0, r1      @ the mod (remainder)
    pop {fp, pc}
    