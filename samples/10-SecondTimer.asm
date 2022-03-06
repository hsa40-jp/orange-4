;----------------------------------------
;10-Second Timer
;----------------------------------------
;
;[Description]
;None in particular.
;
;[Memory]
;Not used.
;
;[Machine Code]
;E00:80389EC3911CFF02F10
;----------------------------------------

	org	0x00
	ldi	0	;8,0
loop:
	ay		;3
	ldi	9	;8,9
	scall	0xC	;E,C
	ay		;3
	addi	1	;9,1
	outn		;1
	cpi	0xF	;C,F
	jmpf	loop	;F,0,2
end:
	jmpf	end	;F,1,0