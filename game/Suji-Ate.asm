;----------------------------------------
;Number guessing game
;----------------------------------------
;[How to play]
;(1) When you run it, a short sound will be played.
;(2) When you press any number key to hear a long tone and see the 3 on the binary LED light up.
;    At this time, the computer will choose any number from A~F.
;(3) The player presses the number key and guesses the number chosen by the computer.
;    If the chosen number is smaller than COM, the LED 6 lights up.
;    If the selected number is larger than COM, LED No. 0 lights up.
;(4)If you fail on the third try, you will lose and an error sound will occur.
;(5) Return to (1) after 1 second.
;(6)After 3 games, you will hear a long sound and the number of correct answers will be shown on the number LED.
;(7) End
;
;[Description].
;Implement the main processing from 0x00.
;Subroutines are stored from 0x80.
;No initialization memory.
;
;[Memory]
;50:Life
;51:Selected value of Computer
;52:Player's input value
;53:Game count
;54: Number of correct answers
;
;[Machine Code]
;E00:A3804A44A082481A364E9F6080A3E1EA0F2020F2CF25E91A17FA1C0FADF6096A48164A3E1E7FCB
;E80:AfB10F823A140F93F8CF61A0E2A6E2F61F6096A0E1FB9F6096A6E1FB9A0817FC54F20A151E889ECF6096E0A35C3F08FE1A451EAFE7
;----------------------------------------

;----------------------------------------
;数当てゲーム
;----------------------------------------
;[How to play]
;①実行すると短い音が鳴る
;②任意の数字キーを押すと長い音がでて2進LEDの3が光る
;  ここでA~Fまでの任意の数字をコンピューターが選ぶ
;③Playerは数字キーを押下しコンピューターが選んだ数字を当てる
;　・選んだ数字がCOMより小さい場合は6番のLEDが点灯
;　・選んだ数字がCOMより大きい場合は0番のLEDが点灯
;④3回目で失敗すると負けとなりエラー音がなる
;⑤1秒後に①に戻る
;⑥3ゲーム終了後に長い音がなり、正解数が数字LEDにされる。
;⑦終了
;
;[Description]
;0x00番地からメイン処理を実装
;0x80番地からサブルーチンを格納
;初期設定メモリ無し
;
;[Memory]
;50:Life
;51:Computerの選択値
;52:Playerの入力値
;53:ゲームカウント
;54:正解数
;
;[Machine Code]
;E00:A3804A44A082481A364E9F6080A3E1EA0F2020F2CF25E91A17FA1C0FADF6096A48164A3E1E7FCB
;E80:AfB10F823A140F93F8CF61A0E2A6E2F61F6096A0E1FB9F6096A6E1FB9A0817FC54F20A151E889ECF6096E0A35C3F08FE1A451EAFE7
;----------------------------------------

	org	0x00
init:
	ldyi	3		;Store game count 0 at address 53 of the memory.(ゲームカウント:0を53番地に格納)
	ldi	0
	st	
	ldyi	4		;Store the number of correct answers 0 at 54 in the memory.(正解数:0を54番地に格納)
	st	
start:
	ldyi	0		;Store the number of PlayerLife 2 at 50 in the memory.(PlayerLife:2を50番地に格納)
	ldi	2
	st	
	ldi	1		;Increment the game count.(ゲームカウントをインクリメント)
	ldyi	3
	add	
	st	
decideComNo:
	scall	9
	call	selectComNumber	;Random numbers from A to F are stored at 51 in the memory.(A～Fまでの乱数を51番地に格納)
	ldyi	3
	scall	1
	scall	0xA
player:	
	ink	
	jmpf	player
	abyz	
inkey:
	ink	
	jmpf	leaveKey
	jmpf	inkey
leaveKey:
	scall	9
	outn	
	ldyi	1
	sub			;Result value = COM's selected value - Player's selected value(結果値＝COMの選択値―Player選択値)
	jmpf	high		;Result value = negative number: Player value is large.(結果値＝負数：Player値が大きい)
	cpi	0
	jmpf	low		;Result value != 0: Player value is smaller than COM value(結果値 !＝0：Player値が小さい)
	call	ledOff		;Result value = 0: Correct answer!(結果値 ＝0：正解！)
	ldyi	4
	ldi	1	
	add			;Increment the correct answer count.(正解カウントをインクリメント)
	st	
	ldyi	3
	scall	1
	scall	7
	jmpf	postProc	;Run post-processing and repeat the game.(後処理してゲーム繰り返し)


	org	0x80
selectComNumber:		;random number selection subroutine(乱数選択サブルーチン)
	ldyi	0xf
addOne:
	addyi	1
	ink
	jmpf	addOne		;Add 1 until the key is pressed.(キーが押されるまでまで1を足す)
	ay	
	ldyi	1		;When a key is pressed, the input value is stored at 51 in the memory.(押されたら入力値を51番地に格納)
	st	
keyWait:
	ink			;Check if the key has been released.(キーが離されたかチェック)
	jmpf	keyLeave
	jmpf	keyWait
keyLeave:
	ret	
ledOff:				;LED off subroutine for HighLow.(HighLow用のLED消灯サブルーチン)
	ldyi	0
	scall	2
	ldyi	6
	scall	2
	ret	
high:				;Processing for High(High時用処理、残機チェックに続く)
	call	ledOff
	ldyi	0
	scall	1
	jmpf	lifeCheck
low:				;Processing for Low(Low時用処理、残機チェックに続く)
	call	ledOff
	ldyi	6
	scall	1
	jmpf	lifeCheck
lifeCheck:			;Check the number of remaining lives.(残機チェック)
	ldyi	0
	ldi	1
	sub			;Subtract 1 from the number of remaining lives at memory 50.(50番地の残機数から1引く)
	jmpf	gameOver	;If result = negative number, game over.(結果＝負数の場合ゲームオーバー)
	st			;If there is a number of lives remaining, store the updated value in memory and return to the next input.(残機がある場合、更新値をメモリに格納して次の入力に戻る)
	jmpf	player
gameOver:		        ;Game Over Processing.(ゲームオーバー処理)
	ldyi	1
	ld	
	outn	
	scall	8
postProc:			;post-processing.(後処理)
	ldi	9
	scall	0xC
	call	ledOff
	scall	0
	ldyi	3
	ld	
	cpi	3		;Game count: 3 is the end.(ゲームカウント:3なら終了)
	jmpf	start
	ldyi	4
	ld	
	outn			;Display the number of correct answers on the numeric LED.(正解数を数字LEDに表示)
	scall	0xA
end:
	jmpf	end
