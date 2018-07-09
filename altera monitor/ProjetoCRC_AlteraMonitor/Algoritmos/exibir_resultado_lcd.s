.data
.equ MODO_OPERACAO_LCD_ENDERECO, 0x20f0
.equ LCD1_ENDERECO, 0x20a0
.equ LCD2_ENDERECO, 0x2090
.equ LCD3_ENDERECO, 0x2080

.text

inicializa_lcd:
	movia r1, MODO_OPERACAO_LCD_ENDERECO
	movi r2, 1
	stb r2, 0(r1)

carrega_valores_lcd:
    movia r1, LCD1_ENDERECO
    stw r23, 0(r1)

fim:
    br fim
