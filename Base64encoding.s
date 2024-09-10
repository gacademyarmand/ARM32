.section .data
rafael_string:   .asciz "Rafael"
base64_ref:   .asciz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
base64_string_len:  .space 12   

.section .text
.global _start

_start:
    ldr r0, =rafael_string    
    ldr r1, =base64_string_len   
    bl base64_encode         

    ldr r0, =base64_string_len  
    bl print_string          

    bl exit_program          

base64_encode:
    push {r4-r7, lr}         @ Save used registers

    ldr r2, =base64_ref      @ Load Base64 table address
    mov r3, #0               @ Idx rafael_string
    mov r4, #0               @ Idx output string

encode_loop:
    @Load 1 byte chunk in 3 different reg
    ldrb r5, [r0, r3]        @ byte 1 
    add r6, r3, #1           @ compute addr byte 2
    ldrb r6, [r0, r6]        @ byte 2
    add r7, r3, #2           @ compute addr byte 3
    ldrb r7, [r0, r7]        @ byte 3

    cmp r5, #0               @ check end of input string
    beq encode_done

    @ Pack three bytes into a 24-bit block
    @ Shift and mask these into six-bit segments 
    @ Then map them to Base64 chars

    @ First 6 bits of the first byte -> r5
    mov r8, r5, lsr #2
    ldrb r9, [r2, r8]        @ Map to Base64 character
    strb r9, [r1, r4]        
    add r4, r4, #1

    @ Last 2 bits of byte 1 + First 4 bits of byte 2  -> r6
    mov r8, r5, lsl #4
    orr r8, r8, r6, lsr #4
    and r8, r8, #0x3F        @ Mask to 6 bits
    ldrb r9, [r2, r8]        @ Map to Base64 character
    strb r9, [r1, r4]        
    add r4, r4, #1

    @ Last 4 bits of byte 2 + First 2 bits of byte 3  -> r7
    mov r8, r6, lsl #2
    orr r8, r8, r7, lsr #6
    and r8, r8, #0x3F        
    ldrb r9, [r2, r8]        
    strb r9, [r1, r4]        
    add r4, r4, #1

    @ Last 6 bits of byte 3
    and r8, r7, #0x3F
    ldrb r9, [r2, r8]        
    strb r9, [r1, r4]        
    add r4, r4, #1

    add r3, r3, #3           @ Move to next three bytes
    b encode_loop

encode_done:
    @ End the string with null-terminator
    mov r9, #0
    strb r9, [r1, r4]        @ Null-terminate the output string
    pop {r4-r7, lr}          @ Restore registers
    bx lr

print_string:
    mov r7, #4               @ sys_write
    mov r1, r0               @ point to string
    mov r2, #12              @ atr length
    mov r0, #1               @ 1 = stdout
    svc 0                    @ make system call
    bx lr

exit_program:
    mov r7, #1               @ sys_exit
    mov r0, #0               @ exit status 0
    svc 0                    @ make system call
