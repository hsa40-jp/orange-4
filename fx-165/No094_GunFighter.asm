;----------------------------------------
;FX-165 No.094 ガンファイターゲーム
;----------------------------------------
;[How to play]
;
;[Description]
;
;[Memory]
;
;[Machine Code]
;E00:8fEc20F0CF3683Ec29fF04A3E1A60F1CC4F28F2FC7F1CA0E1E7F33A5C4F40F47C7F05A1E1E8F4B
;----------------------------------------
	org	0x00
	ldi	0xf
	scall	0xc		;1.6秒WAIT
waiting:
	abyz			;Aレジスタ値[f]をBに退避
flyingKeyDown:
	ink	
	jmpf	gameStart	;ゲーム開始前に入力無し
	jmpf	judgeFlying
gameStart:
	ldi	3
	scall	0xc		;0.4秒WAIT(0.4sec×16回=6.4secとなる)
	abyz			;Bに退避した[f]をAに戻す
	addi	0xf		;fにキャリーが出なくなるまでf足す(16回稼げる)
	jmpf	waiting		;キャリー発生中は戻って待ち継続(1.6+6.4で計8秒のWAITタイム)
	ldyi	3		;センターLED点灯
	scall	1
	ldyi	6		;[4]勝利時のLED位置を格納
keyWait:			;入力判定
	ink	
	jmpf	keyWait
	cpi	4
	jmpf	win5orOther
	jmpf	winLedOn	;[4]勝利の場合
win5orOther:
	cpi	7
	jmpf	keyWait		;入力値が[7]でない場合入力待ちに戻る
	ldyi	0		;[7]勝利の場合[7]勝利時のLED位置を格納
winLedOn:
	scall	1		;勝利用LEDをON
	scall	7		;勝負あった音
end1:				;処理終了
	jmpf	end1
judgeFlying:
	ldyi	5		;[4]フライング時のLED位置を格納
	cpi	4
	jmpf	flying7orNoflying
	jmpf	flyingLedOn	;[4]フライングの場合
flying7orNoflying:
	cpi	7
	jmpf	flyingKeyDown	;入力値が[7]でない場合入力待ちに戻る
	ldyi	1		;[7]フライングの場合[7フライング時のLED位置を格納
flyingLedOn:
	scall	1		;フライング用LEDをON
	scall	8		;フライングエラー音
end2:				;処理終了
	jmpf	end2
