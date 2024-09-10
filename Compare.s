//ref: https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/CPSR--Current-Program-Status-Register?lang=en
.global _start
_start:
	mov r0, #5
	mov r1, #4
	
	//r0 - r1
	//if r0 > r1 -> result = +
	//if r0 > r1 -> result = -	
	//if r0 == r1 -> result = 0
	//the result set the cpsr flag
	cmp r0, r1 //200001d3 -> 00100000000000000000000111010011 according to ref 29bit=1
	
	mov r0, #4
	mov r1, #5
	cmp r0, r1 //800001d3 -> 10000000000000000000000111010011 according to ref 31bit=1
	
	mov r0, #5
	mov r1, #5
	cmp r0, r1 //600001d3 -> 01100000000000000000000111010011 according to ref 30/29bit=1
	
	
	
