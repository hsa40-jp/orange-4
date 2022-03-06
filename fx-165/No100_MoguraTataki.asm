;----------------------------------------
;FX-165 No.100 もぐらたたき
;----------------------------------------
;[How to play]
;
;[Description]
;
;[Memory]
;もぐらの出現位置に使用
;50～56番地に0~6までの任意の値を設定しておく
;
;[Machine Code]
;E50:5162504
;E00:80E5Ae53E132Af0F3920F357C0F26E9E5911E553E23BfF46E7F322F0E80EcBfF0E2F260F06F46
;----------------------------------------
	org	0x00
	ldi	0
	scall	5
	ldyi	0xe
label1:
	ld	
	ay	
	scall	1
	ay	
	abyz	
	ldyi	0xf
label2:
	ink	
	jmpf	label6
	abyz	
	ink	
	jmpf	label5
	sub	
	cpi	0
	jmpf	label3
	scall	9
	scall	5
	addi	1
	outn	
	scall	5
label3:
	ld	
	ay	
	scall	2
	ay	
	addyi	0xf
	jmpf	label7
	scall	7
label4:
	jmpf	label4
label5:
	abyz	
	jmpf	label2
label6:
	ldi	0
	scall	0xc
	addyi	0xf
	jmpf	label2
	abyz	
	jmpf	label3
label7:
	ink	
	jmpf	label1
	jmpf	label7

	org	0x50
	dn	5
	dn	1
	dn	6
	dn	2
	dn	5
	dn	0
	dn	4