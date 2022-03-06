;----------------------------------------
;Knight Rider (Knight2000)
;----------------------------------------
;
;[Description]
;Reproduce the lights that move left and right of the naito2000 with binary LEDs.
;
;[Memory]
;Not used.
;
;[Machine Code]
;E00:A0F601FB1D7F02A6BfF601FD1F10F00E180EcE2F61
;----------------------------------------

	org	0x00
start:
	ldyi	0	;[00-01]A,0		Store 0 in the Y register.
incLoop:		;			Loop for left movement (Increment)
	call	ledOnOf	;[02-06]F,6,0,1,F	Call the ledOnOf subroutine.
	addyi	1	;[07-08]B,1		Add 1 to the value in the Y register.
	cpyi	7	;[09-0A]D,7		Compare the value in the Y register with 7.
	jmpf	incLoop	;[0B-0D]F,0,2		If the value of the Y register is not 7, jump to incLoop.
	ldyi	6	;[0E-0F]A,6		When the value of the Y register is 7, store 6 in the Y register.
decLoop:		;			Loop for right movement (Decrement)
	addyi	0xF	;[10-11]B,F		Add F to the value in the Y register (-1 due to overflow).
	call	ledOnOf	;[12-16]F,6,0,1,F	Call the ledOnOf subroutine.
	cpyi	1	;[17-18]D,1		Compare the value of the Y register with 1.
	jmpf	decLoop	;[19-1B]F,1,0		When the value of the Y register is not 1, jump to decLoop.
	jmpf	start	;[1C-1E]F,0,0		When the value of Y register is 1, jump to start.
ledOnOf:
	scall	1	;[1F-20]E,1		Turn on the LED at the position of the Y register value.
	ldi	0	;[21-22]8,0		Store 0 in the A register.
	scall	0xC	;[23-24]E,C		Value of A register + 1 x 0.1 seconds, wait for processing.
	scall	2	;[25-26]E,2		Turn off the LED at the position of the Y register value.
	ret		;[27-28]F,6,1		Return to the caller.
