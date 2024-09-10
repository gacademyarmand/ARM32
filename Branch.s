//ref: https://developer.arm.com/documentation/ddi0403/d/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-ARMv7-M-Thumb-instructions/B?lang=en
//ref: https://developer.arm.com/documentation/ddi0403/d/Application-Level-Architecture/Instruction-Details/Conditional-execution?lang=en

.global _start
_start:	
	mov r0, #4
	mov r1, #5
	cmp r0, r1
	
	beq cond1
	b cond2 // need these otherwise the program flow will continue to cond1 and cond2

cond1:
	mov r2, #1

cond2:
	mov r3, #2
	
