.global _start

.section .text

_start:
	//we perfom load with words
	ldr r0, =var1 	//load the address of var1 in r0
	ldr r1, [r0]	//load in r1 the value stored in address var1
	
	//store operation
	mov r2, #3
	ldr r3, =var2	//load the address of var2 in r3
	str r2, [r3]	//store the value of r2 in the address pointed by r3
	

.data
	var1: .word 32 //word -> 32 bit
	var2: .word 32
