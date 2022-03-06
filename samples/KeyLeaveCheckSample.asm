;----------------------------------------
;Sample program for checking Key Leave
;----------------------------------------
;
;[Description]
;None in particular.
;
;[Memory]
;Not used.
;
;[Machine Code]
;E00:80120F0429120F13F0C2F02
;----------------------------------------

	org	0x00
	ldi	0
loop:
	outn	
	abyz	
keyWait:
	ink	
	jmpf	keyWait
	abyz	
	addi	1
	abyz	
keyWait2:
	ink	
	jmpf	keyLeave
	jmpf	keyWait2
keyLeave:
	abyz	
	jmpf	loop
