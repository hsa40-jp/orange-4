;----------------------------------------
;じゃんけんゲーム
;----------------------------------------
;[How to play]
;
;[Player]
; 数字キー
; 0：グー
; 1：チョキ
; 2：パー
;
;[COM]
; 2進LED
; ○○●●●○○：グー
; ●●○○○●●：チョキ
; ●●●●●●●：パー
;
;①実行すると短い音が2回鳴る（ジャン、ケン、のリズムに相当）
;②Playerは0~2まで数字キーを押下する
;③ポンに相当する短い音がなり、Playerの手は数字LED、COMの手は
; 2進LEDに表示される
; また、勝ちだとエンド音、あいこ長い音、負けだとエラー音がなる
;⑤1秒後に①に戻る
;
;[Description]
;初期設定メモリ無し
;
;[Memory]
;50:コンピューターの手
;51:プレイヤーの手
;5E,5F:COMの手を表現するためにscall 0xD用に使用
;
;[Machine Code]
;E00:E985ECE9F6080A04F60A4A1593A24A05A27C3F2DEAF46C2F37E7F46C5F41E7F46E8F4689ECFDE
;E80:8F91E50F9A9DF9A93A141E5F61E5C2F82F80A05C0FBBAE8C4AF814EDF61C1FCFAE834AF864EDF61AE8F4AF874EDF61E080AE4AF4EDF00
;----------------------------------------
	org	0x00
start:
	scall	9
	ldi	5
	scall	0xC
	scall	9
	call	random
	ldyi	0
	st	
	call	dispComHand
judge:
	ldyi	1
	ld	
	addi	3
	ldyi	2
	st	
	ldyi	0
	ld	
	ldyi	2
	sub	
aiko:
	cpi	3
	jmpf	win
	scall	0xA
	jmpf	postProc
win:
	cpi	2
	jmpf	win2
	scall	7
	jmpf	postProc
win2:
	cpi	5
	jmpf	lose
	scall	7
	jmpf	postProc
lose:
	scall	8
	jmpf	postProc
postProc:
	ldi	9
	scall	0xC
	jmpf	resetDisp

	org	0x80
random:
	ldi	0xF
addNo:
	addi	1
	scall	5
	ink	
	jmpf	rangeCheck
	addi	0xD
	jmpf	rangeCheck
	addi	3
	ldyi	1
	st	
	outn	
	scall	5
	ret	
rangeCheck:
	scall	5
	cpi	2
	jmpf	addNo
	jmpf	random
dispComHand:
	ldyi	0
	ld	
	cpi	0
	jmpf	chokiOrPah
dispGoo:
	ldyi	0xE
	ldi	0xC
	st	
	ldyi	0xF
	ldi	1
	st	
	scall	0xD
	ret	
chokiOrPah:
	cpi	1
	jmpf	dispPah
dispChoki:
	ldyi	0xE
	ldi	3
	st	
	ldyi	0xF
	ldi	6
	st	
	scall	0xD
	ret	
dispPah:
	ldyi	0xE
	ldi	0xF
	st	
	ldyi	0xF
	ldi	7
	st	
	scall	0xD
	ret	
resetDisp:
	scall	0
	ldi	0
	ldyi	0xE
	st	
	ldyi	0xF
	st	
	scall	0xD
	jmpf	start
