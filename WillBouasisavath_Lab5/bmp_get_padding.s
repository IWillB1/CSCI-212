@ ldr r0, bmp_header byte array (*unsigned char[54])
@ bl bmp_get_padding

.syntax unified
.include "bmp_struct.s"
.include "rgb24_struct.s"
.text
.global bmp_get_padding
.type bmp_get_padding, %function

bmp_get_padding:

    push {r4, fp, lr}
    mov fp, sp
    mov r4, r0 @ r4 <- header pointer

    @ int padding = (4 - (bi.biWidth * sizeof(RGBTRIPLE)) % 4) % 4;
    ldr r0, [r4, iWIDTH]
    mov r1, rgbSIZE
    mul r0, r1, r0
    mov r1, 4
    bl mod
    mov r1, 4
    sub r0, r1, r0
    mov r1, 4
    bl mod

    pop {r4, fp, pc}
    