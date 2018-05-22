ORG		0x7c00			        ; 设置程序装载起始地址

entry:
		MOV		AX,0			; 初始化寄存器
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
        
        ; 功能代码部分，这里就只输出一个字符
        
putOneChar:
        MOV     AL, 'A'         ; 指定打印字符
        MOV		AH,0x0e			; 指定打印中断子功能
		MOV		BX,15			; 指定文字颜色
		INT		0x10			
        
fin:
		HLT						; 进入停滞状态
		JMP		fin				; 无限循环
        
		RESB	0x7dfe-$		; 填充至0x7dfe
		DB		0x55, 0xaa      ; 标志启动扇区的magic number
