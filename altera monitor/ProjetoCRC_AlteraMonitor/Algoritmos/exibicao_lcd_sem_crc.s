

.data
.equ RX_ENDERECO, 0x20e0
.equ READ_ENDERECO, 0x20b0
.equ EMPTY_ENDERECO, 0x20d0
.equ CONTROL_UART_ENDERECO, 0x20c0
.equ TAMANHO_ENTRADA, 128
.equ MODO_OPERACAO_LCD_ENDERECO, 0x21b0
.equ LCD_PT1_ENDERECO, 0x2160
.equ LCD_PT2_ENDERECO, 0x2150
.equ LCD_PT3_ENDERECO, 0x2140
.equ LCD_PT4_ENDERECO, 0x20e0
.equ LCD_PT5_ENDERECO, 0x20f0
.equ LCD_PT6_ENDERECO, 0x2100
.equ LCD_PT7_ENDERECO, 0x2110
.equ LCD_PT8_ENDERECO, 0x2120
.equ LCD_PT9_ENDERECO, 0x2130


BASE_DADOS_ENDERECO: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text

.global _start
_start: 

movia r1, LCD_PT1_ENDERECO
movia r2, 0x61
stb r2, 0(r1)

movia r3, LCD_PT2_ENDERECO
movia r4, 0x62
stb r4, 0(r3)

movia r5, LCD_PT3_ENDERECO
movi r6, 0x63
stb r6, 0(r5)

movia r5, LCD_PT4_ENDERECO
movi r6, 0x64
stb r6, 0(r5)

movia r5, LCD_PT5_ENDERECO
movi r6, 0x65
stb r6, 0(r5)

movia r5, LCD_PT6_ENDERECO
movi r6, 0x66
stb r6, 0(r5)

movia r5, LCD_PT7_ENDERECO
movi r6, 0x67
stb r6, 0(r5)

movia r5, LCD_PT8_ENDERECO
movi r6, 0x68
stb r6, 0(r5)

movia r5, LCD_PT9_ENDERECO
movi r6, 0x69
stb r6, 0(r5)

movia r1, MODO_OPERACAO_LCD_ENDERECO
movi r2, 2
stb r2, 0(r1)

fim:
br fim