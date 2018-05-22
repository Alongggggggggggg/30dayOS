; 读入2号扇区
	MOV		AX, 0x0820
	MOV		ES, AX           
    MOV     BX, 0           ; 内容缓存地址 ES:BX
	MOV		DH, 0			; 磁头0
    MOV     DL, 0x00        ; 驱动器0
	MOV		CH, 0			; 柱面0
	MOV		CL, 2			; 扇区2
    MOV     AH, 0x02        ; 指明子功能为读盘
    MOV     AL, 1           ; 指明连续读扇区数
    INT     0x13            ; 调用0x13BIOS中断
    JC      error           ; 出错，则carry flag为1，跳转至error
    

; 读入一个柱面上全部18个扇区
    ; 初始化读入地址和扇区号
    MOV		AX, 0x0820
	MOV		ES, AX           
    MOV     BX, 0           ; 内容缓存地址 ES:BX
	MOV		CL, 1			; 扇区1
readloop:
	MOV		DH, 0			; 磁头0
    MOV     DL, 0x00        ; 驱动器0
	MOV		CH, 0			; 柱面0
    MOV     AH, 0x02        ; 指明子功能为读盘
    MOV     AL, 1           ; 指明连续读扇区数
    INT     0x13            ; 调用0x13BIOS中断
    JC      error
next:
    MOV     AX, ES
    ADD     AX, 0X0020
    MOV     ES, AX
    ADD     CL, 1
    CMP     CL, 18
    JA      readfin
    JBE     readloop
readfin:    ; print CL 
    SUB     CL, 10
    ADD     CL, '0'
    MOV     AL, CL          ; 所读扇区个数中的个位数
    MOV		AH, 0x0e		; 指定打印中断子功能
	MOV		BX, 15			; 指定文字颜色
	INT		0x10
    JMP     fin
error:
    MOV     AL, 'E'         ; E代表error
    MOV		AH, 0x0e    	; 指定打印中断子功能
	MOV		BX, 15			; 指定文字颜色
	INT		0x10
    JMP     fin
fin:
    HLT
    JMP     fin


; 读入10个柱面
CYLS    EQU     10          ; 柱面个数

    MOV     BX, 0
    MOV     AX, 0X0820
    MOV     ES, AX          ; 读入地址
    MOV     DL, 0           ; 驱动器号
    MOV     DH, 0           ; 磁头号
    MOV     CH, 0           ; 柱面号
    MOV     CL, 1           ; 扇区号
readloop:
    MOV     BX, 0           ; 因为后面打印字符时使用了BX，故需重置
    MOV     AH, 0X02        ; 读盘
    MOV     AL, 1           ; 连读扇区数
    INT     0X13
    JC      error
next:
    MOV     AX, ES
    ADD     AX, 0X0020
    MOV     ES, AX          ; 修改读入地址
    ADD     CL, 1           ; 修改扇区号
    CMP     CL, 18          ; 比较扇区号，判断是否读完一个柱面的一面
    JBE     readloop
    MOV     CL, 1           ; 重置扇区号
    ADD     DH, 1           ; 修改磁头号
    CMP     DH, 2           ; 比较磁头号，判断是否要读反面
    JB      readloop
    MOV     DH, 0           ; 重置磁头号
    ADD     CH, 1           ; 修改柱面号
    CMP     CH, CYLS
    JB      readloop

success:
    MOV     AL, 'S'         ; S代表success
    MOV		AH, 0x0e    	; 指定打印中断子功能
	MOV		BX, 15			; 指定文字颜色
	INT		0x10
    JMP     fin
error:
    MOV     AL, 'E'         ; E代表error
    MOV		AH, 0x0e    	; 指定打印中断子功能
	MOV		BX, 15			; 指定文字颜色
	INT		0x10
    JMP     fin
fin:
    HLT
    JMP     fin




































    