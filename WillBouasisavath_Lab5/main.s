.syntax unified
.include "bmp_struct.s"
.include "rgb24_struct.s"
.section .rodata
img_name: .string "outimage.bmp"
mode: .string "r"
.text
.global main


main:

    push {fp, lr}
    add fp, sp, 4
    push {r4-r10}

@ read file header into heap

    ldr r0, =img_name
    ldr r1, =mode
    bl fopen
    mov r4, r0 @ r4 <- FILE HEAP POINTER
    
    mov r0, HEADER_SIZE @ 54 in base-10
    mov r1, 1
    bl calloc
    mov r5, r0 @ r5 <- HEADER BYTE HEAP POINTER

    mov r1, 1 @ 1 byte each element in the array
    mov r2, HEADER_SIZE
    mov r3, r4
    bl fread @ read header into heap

    ldr r0, [r5, iWIDTH]
    ldr r1, [r5, iHEIGHT]
    mul r0, r1, r0
    mov r1, rgbSIZE
    mul r9, r1, r0 @ r9 <- image data size in bytes
    mov r0, r9
    mov r1, 1
    bl calloc
    mov r6, r0 @ r6 <- IMAGE DATA HEAP POINTER

    @ set pointer to start of image data
    mov r0, r4 @ FILE POINTER
    ldr r1, [r5, fOFFBITS] @ OFFSET FOR IMAGE DATA
    mov r2, 0 @ WHENCE = BEGINNING OF FILE
    bl fseek

    @ get stride length
    mov r0, r5
    bl bmp_get_stride
    mov r7, r0 @ r7 <- stride len
    
    @ get padding information
    mov r0, r5
    bl bmp_get_padding
    mov r10, r0 @ r10 <- padding bytes

    mov r8, 0 @ r8 <- read index

@ read image data into heap
.read_loop:

    cmp r8, r9
    bge .close 

    @ read stride
    add r0, r6, r8 @ offset pointer to data buffer
    mov r1, 1
    mov r2, r7 @ one stride
    mov r3, r4
    bl fread
    add r8, r8, r0

    @ skip padding at end of stride
    mov r0, r4
    mov r1, r10
    mov r2, 1
    bl fseek
    
    b .read_loop

.close:

    @ done with file, all data is loaded into memory
    mov r0, r4
    bl fclose
    @ r4 can now be re-used

.decrypt:

    ldrb r4, [r6, rgbGRN] @ r4 <- first green pixel (message len)

    mov r0, r5
    movw r1, 0xf948 @ 457439560 seed
    movt r1, 0x1b43
    mov r2, 20
    mov r3, r4
    push {r6} @ put image data on stack
    bl decrypt
    pop {r0} @ take it off

.return:

    mov r0, r5
    bl free
    mov r0, r6
    bl free
    mov r0, 0
    pop {r4-r10, fp, pc}
