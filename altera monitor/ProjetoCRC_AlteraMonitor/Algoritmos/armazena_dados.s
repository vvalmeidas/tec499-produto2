

.data
.equ RX_ENDERECO, 0x20e0
.equ READ_ENDERECO, 0x20b0
.equ EMPTY_ENDERECO, 0x20d0
.equ CONTROL_UART_ENDERECO, 0x20c0
.equ TAMANHO_ENTRADA, 1004
.global BASE_DADOS_ENDERECO
.equ BASE_DADOS_ENDERECO, 0x23a0

.text

.global _start
_start: 
movi r1, TAMANHO_ENTRADA
movia r2, EMPTY_ENDERECO
movia r3, READ_ENDERECO
movia r4, RX_ENDERECO
movi r5, 24 #offset inicial
mov r6, r0 #32 bits
mov r7, r0 #contador bytes recebidos
movia r9, BASE_DADOS_ENDERECO

movia r5, CONTROL_UART_ENDERECO
movi r6, 0b01001100
stb r6, 0(r5)

checar_empty:
ldb r10, 0(r2)
beq r10, r0, chegou_caractere
br checar_empty

chegou_caractere:
movi r11, 1
stb r11, 0(r3)
stb r0, 0(r3)
ldb r12, 0(r4)
sll r12, r12, r5
or r6, r6, r12

beq r5, r0, reinicia_offset #offset chegou em 0
subi r5, r5, 8 #diminui 8 do offset
br computar_numero_bytes

reinicia_offset:
stw r6, 0(r9)
addi r9, r9, 4
movi r5, 24
mov r6, r0
br computar_numero_bytes

computar_numero_bytes:
addi r7, r7, 1 #incrementa contador de bytes
beq r7, r8, continua
br checar_empty

continua: