;----------------------------------------
;HEX Timer
;----------------------------------------
;
;[Description]
;
;
;[Memory]
;Not Used.
;
;[Machine Code]
;E00:E9F6080F6093F60A80F11F6080E0E9AE5914EDA25914189ECA05A27C0F2680A24A15AE7C0F1EFC1
;E80:80A24A34AE4AF4EDF610F93C0F9FF93E91A04F610FA8C0FB4FA8EAA14AE4EDF61E7FC1
;----------------------------------------
	org	0x00
	scall	9
	call	initCounter
	call	selectSec
	call	selectCount
keyWait:
	ink	
	jmpf	keyWait
	call	initCounter
	scall	0
	scall	9
loopCount:
	ldyi	0xE
	ld	
	addi	1
	st	
	scall	0xD
loopSec:
	ldyi	2
	ld	
	addi	1
	st	
	outn	
	ldi	9
	scall	0xC
	ldyi	0
	ld	
	ldyi	2
	sub	
	cpi	0
	jmpf	loopSec
	ldi	0
	ldyi	2
	st	
	ldyi	1
	ld	
	ldyi	0xE
	sub	
	cpi	0
	jmpf	loopCount
	jmpf	alerm

	org	0x80
initCounter:
	ldi	0
	ldyi	2
	st	
	ldyi	3
	st	
	ldyi	0xE
	st	
	ldyi	0xF
	st	
	scall	0xD
	ret	
selectSec:
	ink	
	jmpf	selectSec
	cpi	0
	jmpf	registSec
	jmpf	selectSec
registSec:
	scall	9
	outn	
	ldyi	0
	st	
	ret	
selectCount:
	ink	
	jmpf	selectCount
	cpi	0
	jmpf	registCount
	jmpf	selectCount
registCount:
	scall	0xA
	ldyi	1
	st	
	ldyi	0xE
	st	
	scall	0xD
	ret	
alerm:
	scall	7
	jmpf	alerm
