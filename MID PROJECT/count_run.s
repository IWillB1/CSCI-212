@ count_run.s
@ A function to count the size of each run, and the total number of runs and prints that out.
@ This function should take in as input, an array and count the number of runs in the array. 
@ Call this function "count_run", i.e. count_run(int_arr[100])
@ @ Will Bouasisavath - 007547473



.syntax unified


.section .rodata

fmt1: .string "Run length: %d\n"
fmt2: .string "Total number of runs: %d\n"


.text
.global count_run
.type count_run, %function


count_run:

    push {r4-r8, lr}

    mov r4, r0 @ array
    mov r5, 1  @ index
    mov r8, 0  @ total


.search:

    cmp r5, 100
    bgt .total

    sub r6, r5, 1 @ previous element
    ldr r0, [r4, r5, lsl 2]
    ldr r1, [r4, r6, lsl 2]
    cmp r0, r1
    beq .run
    add r5, r5, 1
    b .search


.run:

    mov r7, 2 @ current run count


.run_loop:

    add r5, r5, 1 @ current
    sub r6, r5, 1 @ previous

    cmp r5, 100
    bgt .end_run

    ldr r0, [r4, r5, lsl 2]
    ldr r1, [r4, r6, lsl 2]
    cmp r0, r1
    addeq r7, r7, 1
    beq .run_loop


.end_run:

    add r8, r8, 1
    ldr r0, =fmt1
    mov r1, r7
    bl printf

    cmp r5, 100
    bgt .total

    b .search


.total:

    ldr r0, =fmt2
    mov r1, r8
    bl printf


.exit:

    pop {r4-r8, lr}
    bx lr

    
    bx lr
