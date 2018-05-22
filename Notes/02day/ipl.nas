ORG		0x7c00			; 指明程序装载地址

	

; 程序主体

entry:

		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; 给SI加1
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 显示一个文字
		MOV		BX,15			; 指定字符颜色
		INT		0x10			; 调用显卡BIOS
		JMP		putloop
fin:
		HLT						; 让CPU停止，等待指令
		JMP		fin				; 无限循环

msg:
		DB		0x0a, 0x0a		; 换行两次
		DB		"hello, world！"
		DB		0x0a			; 换行
		DB		0               ; 字符串结束标志

		RESB	0x7dfe-$		; 填写0x00直到0x001fe

		DB		0x55, 0xaa
