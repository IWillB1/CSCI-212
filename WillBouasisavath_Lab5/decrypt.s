@ mov r0, *(unsigned char) bmp_header[54]
@ mov r1, int seed_start
@ mov r2, uint8 seeds_to_check
@ mov r3, uint8 pixel_index
@ push *(unsigned char)[bmp.iSIZEIMG] rgb data pointer


.syntax unified
SEEDS_TO_CHECK .req r4
BMP_HEADER .req r5
SEED .req r6
MSG_LEN .req r7
BMP_DATA .req r10


.include "rgb24_struct.s"
.include "bmp_struct.s"
.section .rodata

prompt_seed: .string "SEED: "

.text
.global decrypt
.type decrypt, %function

decrypt:
    push {fp, lr}
    add fp, sp, 4
    push {r4-r10}
    ldr BMP_DATA, [fp, 4] @ r10 <- bmp data

    mov MSG_LEN, r3 @ r4 <- seed loop, k = 0
    mov BMP_HEADER, r0
    mov SEED, r1 @ r6 <- random seed
    mov SEEDS_TO_CHECK, r2 @ r7 <- starting pixel index

    @ get number of total pixels
    ldr r0, [BMP_HEADER, iWIDTH]
    ldr r1, [BMP_HEADER, iHEIGHT]
    mul r0, r1, r0
    mov r9, r0 @ r9 <- NUMBER OF PIXELS

.decrypt_loop:

    @ reached the end? return.
    cmp SEEDS_TO_CHECK, 0
    blt .return

    @ set current seed
    mov r8, 0 @ r8 <- message loop j = 0
    mov r0, SEED
    bl srand

    @ print seed
    bl newLine
    ldr r0, =prompt_seed
    bl writeStr
    mov r0, SEED
    bl putDecInt
    bl newLine

.message_loop:

    @ must loop i times (first green pixel index)
    cmp r8, MSG_LEN
    addge SEED, SEED, 1 @ increment seed
    subge SEEDS_TO_CHECK, SEEDS_TO_CHECK, 1
    blge newLine
    bge .decrypt_loop

    @ old
    @ (rand() % (num_pixels)) + 1
    @ new
    @ pixel_index = (rand() % (num_pixels - 1)) + 1
    bl rand @ r0 <- rand()
    mov r1, r9 @ r1 <- num_pixels
    sub r1, r1, 1
    bl mod
    add r0, r0, 1 @ r0 <- pixel index
    push {r0} @ pixel idx on stack

    @ RGB_pixel = pixel_index % 3
    mov r1, rgbSIZE
    bl mod @ r0 <- RGB_pixel
    pop {r1} @ r1 <- pixel_idx
    push {r0} @ rgb_pixel
    mov r0, rgbSIZE
    mul r1, r0, r1
    pop {r0} @ r0 <- rgb_pixel
    add r1, r1, r0 @ r1 <- pixel_index + RGB_pixel = byte offset for char
    ldrb r0, [BMP_DATA, r1]
    bl putChar

    add r8, r8, 1
    b .message_loop

.return:

    mov r0, 0
    pop {r4-r10}
    sub sp, fp, 4
    pop {fp, pc}
