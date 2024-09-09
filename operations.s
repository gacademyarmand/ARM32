.global _start

.section .text

_start:
	mov r0, #42
	add r1, r0, #5
	mov r2, #47
	subs r3, r1, r2
	
