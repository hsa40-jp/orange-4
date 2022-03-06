
;----------------------------------------
;デジタル入出力サンプル
;----------------------------------------
;[Port]
;Port2：0:Digital出力
;Port3：2:Digital入力(1ではないので注意)
;※Port1は+5vの隣なので接続ミスすると相手側がやられる
;
;[Description]
;任意の数字キーを押している間、Port2をHighにする
;Poer3がHighの場合、数字LEDに1が表示され、2進LEDの3番が点灯する
;
;[Memory]
;使用無し
;
;[Machine Code]
;E00:A280F70A382F70A3F721C1F3E2A3E12A220F351281F7120F35F2E280F71F0E2A3E22F1F
;----------------------------------------
	org	0x00
init:
	ldyi	2
	ldi	0
	ioctrl	
	ldyi	3
	ldi	2
	ioctrl	
loop:
	ldyi	3
	in	
	outn	
	cpi	1
	jmpf	ledOff
	abyz	
	ldyi	3
	scall	1
	abyz	
inkey:
	ldyi	2
	abyz	
	ink	
	jmpf	keyLeave
	outn	
	abyz	
	ldi	1
	out	
	abyz	
keyWait:
	ink	
	jmpf	keyLeave
	jmpf	keyWait
keyLeave:
	abyz	
	ldi	0
	out	
	jmpf	loop
ledOff:
	abyz	
	ldyi	3
	scall	2
	abyz	
	jmpf	inkey
