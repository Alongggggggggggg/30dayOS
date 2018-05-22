; print one char
putOneChar:
        MOV     AL, 'A'         ; 指定打印字符
        MOV		AH,0x0e			; 指定打印中断子功能
		MOV		BX,15			; 指定文字颜色
		INT		0x10	
        
        
; print a string
        MOV     SI, msg
putString:
        MOV     AL, [SI]        ; 获取待打印字符
        CMP     AL, 0           ; 若为0则说明打印完毕
        JE      fin
        MOV		AH,0x0e			; 指定打印中断子功能
		MOV		BX,15			; 指定文字颜色
		INT		0x10
        ADD     SI, 1           ; 将SI所指地址加一
        JMP     putString       ; 打印完一个字符后接着打下一个
        
fin:
    HLT
    JMP fin
        
msg:
        DB      "hello world."
        DB      0
        