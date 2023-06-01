@ ldr r0, bmp_header byte array (*unsigned char[54])
@ bl bmp_get_stride

.syntax unified
.include "bmp_struct.s"
.text
.global bmp_get_stride
.type bmp_get_stride, %function

bmp_get_stride:
    push {r4, fp, lr}
    mov fp, sp
    mov r4, r0 @ r4 <- header pointer
    @ [ (bpp * image_width) / 32 ] * 4 = scanline_len
    
    ldrh r0, [r4, iBITCOUNT]
    ldr r1, [r4, iWIDTH]
    mul r2, r0, r1
    lsr r2, 3 @ (r2 / 2^5 ) * 2^2
    mov r0, r2
    pop {r4, fp, pc}
    