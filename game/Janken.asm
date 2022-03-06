;----------------------------------------
;じゃんけんゲーム
;----------------------------------------
;[How to play]
;0：グー
;1：チョキ
;2：パー
;①実行すると短い音が鳴る
;②任意の数字キーを押すと長い音がる
;  ここで0~2までの任意手の数字をコンピューターが選ぶ
;③Playerは0~2まで数字キーを押下する
;④勝ちだとエンド音、あいこ長い音、負けだとエラー音がなる
;⑤1秒後に①に戻る
;
;[Description]
;0x00番地からメイン処理を実装
;0x80番地からサブルーチンを格納
;初期設定メモリ無し
;
;[Memory]
;50:コンピューターの手
;51:プレイヤーの手
;
;[Machine Code]
;E00:E9F6091A04E9A10F0E9dF0E934F6080A1593A24A05A27C3F37EaFB0C2F41E7FB0C5F4BE7FB0E8FB0
;E80:E9F60A7E1E1E51F618f9120F9E2F612C2F93F91E5A053F61E589EcF60A7E2E0E5F00
;----------------------------------------
	org	0x00
comTurn:
	scall	9		;じゃん（ピ）
	call	random		;この間にCOMのランダム手(0~2)をメモリ50に格納
	ldyi	0
	st	
	scall	9		;けん（ピ）
playerTurn:			;ユーザー手入力(0~2)
	ldyi	1
keyWait:
	ink	
	jmpf	keyWait
	addi	0xd		;入力値にDを足してキャリーが出たら再入力
	jmpf	keyWait
	addi	3		;入力値にDが足されているので3足して値を戻す
	st			;51番地にユーザー手を格納
	call	dispResult
judge:				;判定開始
	ldyi	1
	ld	
	addi	3		;結果値=自分の手+3-相手の手
	ldyi	2
	st	
	ldyi	0
	ld	
	ldyi	2
	sub
aiko:
	cpi	3		;結果値=3だったらあいこ
	jmpf	win
	scall	0xa		;あいこ音(3)
	jmpf	postProc	
win:
	cpi	2		;結果値=2or5だったら勝ち
	jmpf	win2
	scall	7		;勝ち音(2)
	jmpf	postProc
win2:
	cpi	5
	jmpf	lose		;それ以外は負け
	scall	7		;勝ち音(5)
	jmpf	postProc	
lose:
	scall	8		;負け音
	jmpf	postProc

	org	0x80
dispResult:			;メモリ値表示サブルーチン
	scall	9
	call	selectLed
	scall	1
	scall	1
	scall	5
	outn	
	ret	
random:				;ランダム手取得サブルーチン
	ldi	0xf
addNo:
	addi	1
	abyz	
	ink	
	jmpf	rangeCheck
	abyz	
	ret	
rangeCheck:
	abyz	
	cpi	2
	jmpf	addNo
	jmpf	random
selectLed:			;操作対象LED選択用サブルーチン
	scall	5
	ldyi	0
	ld	
	ay	
	ret	
postProc:			;後処理用サブルーチン
	scall	5
	ldi	9
	scall	0xc
	call	selectLed
	scall	2
	scall	0
	scall	5
	jmpf	comTurn
