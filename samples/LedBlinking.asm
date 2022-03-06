;----------------------------------------
;Led Blinking
;----------------------------------------
;
;[Description]
;None in particular.
;
;[Memory]
;Not used.
;
;[Machine Code]
;E00:A089E1ECE2ECF04
;----------------------------------------

	org	0x00
	ldyi	0
	ldi	9
loop:	scall	1
	scall	0xC
	scall	2
	scall	0xC
	jmpf	loop
