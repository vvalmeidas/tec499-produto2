.data
.equ RX_ENDERECO, 0x21a0
.equ READ_ENDERECO, 0x2170
.equ EMPTY_ENDERECO, 0x2190
.equ CONTROL_UART_ENDERECO, 0x2180
.equ TAMANHO_ENTRADA, 1004
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
movia r1, TAMANHO_ENTRADA
movia r2, EMPTY_ENDERECO
movia r3, READ_ENDERECO
movia r4, RX_ENDERECO
mov r7, r0 #contador bytes recebidos
movia r9, BASE_DADOS_ENDERECO
movia r22, BASE_DADOS_ENDERECO

movia r5, CONTROL_UART_ENDERECO
movi r6, 0b01001100
stb r6, 0(r5)

mov r6, r0 #32 bits
movi r5, 24 #offset inicial


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
beq r7, r1, montar_tabela
br checar_empty

.data
.global TABELA
TABELA: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text

montar_tabela:
movia r1, 0x814141AB 				#Polin�mio que ser� utilizado no c�lculo do CRC
movia r2, TABELA			 	#M�scara para verificar o primeiro bit da entrada
movia r3, 0x80000000
movia r4, 0 					#Primeira entrada
movia r5, 256 					#Valor m�ximo de entrada para a constru��o da tabela

#Realiza as primeiras tarefas necess�rias para a introdu��o de um valor pr� calculado na tabela
inicia_pre_calculo_para_valor:	
	mov r6, r4				#Realiza uma c�pia do valor atual
	slli r6, r6, 24 			#Move o byte menos significativo da entrada para as posi��es mais significativas do registrador
	movi r7, 8				#Inicia contador para verificar cada bit do byte selecionado

#Verifica cada bit do valor atual, iniciando pelo bit mais significativo
verifica_bits_do_valor_atual: 	
	beq r7, r0, armazena_resultado_memoria	#Finaliza o loop, caso todos os bits j� tenham sido verificados
	and r8, r3, r6				#Aplica a m�scara para verificar o bit mais significativo
	bne r8, r0, encontrou_1_MSB		#Caso o bit mais significativo n�o seja 0
	slli r6, r6, 1				#Desloca um bit para a esquerda, para que o pr�ximo bit seja verificado
	subi r7, r7, 1				#Decrementa o contador
	br verifica_bits_do_valor_atual		
	
#Ao ser encontrado um bit 1 como MSB
encontrou_1_MSB:	
	slli r6, r6, 1				#Desloca um bit para a esquerda
	xor r6, r6, r1				#Realiza a opera��o XOR do bit com o polin�mio
	subi r7, r7, 1				#Decrementa o contador
	br verifica_bits_do_valor_atual

#Armazena o resultado pr� calculado na mem�ria
armazena_resultado_memoria: 	
	stw r6, 0(r2)				#Transfere o resultado do c�lculo para uma posi��o de mem�ria
	addi r2, r2, 4				#Avan�a uma posi��o no ponteiro para a mem�ria 
	addi r4, r4, 1				#Incrementa o valor a ser pr� calculado
	bne r4, r5, inicia_pre_calculo_para_valor

.text

#Reseta os registradores anteriormente usados
reseta_registradores:
	mov r1, r0 
	mov r2, r0 
	mov r3, r0 
	mov r4, r0 
	mov r5, r0 
	mov r6, r0 	
	mov r7, r0 
	mov r8, r0 

#Inicia o c�lculo para 1KB de dados de entrada
inicia_calculo_1KB:	
	movia r10, BASE_DADOS_ENDERECO 				#Endere�o base da entrada
	movia r11, TABELA 				#Primeiro endere�o da tabela	
	movi r12, 250
	movia r13, 0xff000000 				#Mascara para ignorar 24 �ltimos bits de cada conjunto de 32 bits
	mov r14, r0 					#Contador de quantas sequ�ncias de 32 bits j� foram obtidas da mem�ria e calculadas
		
#Prepara o inicio do c�lculo para uma sequ�ncia de 32 bits
prepara_proxima_sequencia_32bits:	
	beq r14, r12, inicializa_lcd	#Verifica se todas as 250 sequ�ncias de 32 bits da entrada j� foram computadas e inicia a exibi��o do resultado
		
	add r15, r14, r14				#Multiplica o deslocamento (quantidade de sequ�ncias j� computadas) por 2
	add r15, r15, r14				#Multiplica o deslocamento (quantidade de sequ�ncias j� computadas) por 3
	add r15, r15, r14				#Multiplica o deslocamento (quantidade de sequ�ncias j� computadas) por 4

	add r15, r15, r10 				#Adiciona o endere�o base da entrada ao deslocamento
	ldw r17, 0(r15) 				#Obt�m a pr�xima entrada de 32 bits
	movi r16, 4					#Reinicia o contador de sequ�ncias de bytes j� computadas na sequ�ncia de 32 bits

#Realiza o c�lculo do CRC para a uma sequ�ncia de 32 bits da entrada
calculo_crc_para_32_bits:	
	beq r16, r0, inicializa_lcd	#Verifica se todas as 4 sequ�ncias de um byte j� foram computadas, finalizando o c�lculo para 32 bits em caso positivo
	and r18, r17, r13 				#Aplica m�scara para ignorar os 3 bytes menos significativos da sequ�ncia de 32 bits
	xor r18, r18, r23 				#Realiza a opera��o XOR com o byte restante (byte mais significativo)
	srli r18, r18, 24				#Desloca o resultado da opera��o (index para a tabela) para direita
				
	add r19, r18, r18				#Multiplica o index por 2 para obter o deslocamento real do endere�o desejado na tabela
	add r19, r19, r18				#Multiplica o index por 3 para obter o deslocamento real do endere�o desejado na tabela
	add r19, r19, r18				#Multiplica o index por 4 para obter o deslocamento real do endere�o desejado na tabela
	mov r20, r19
	
	add r20, r20, r11 				#Adiciona o endere�o base da tabela ao deslocamento obtido
	ldw r18, 0(r20) 				#Obt�m o valor pr� calculado da tabela
		
	slli r23, r23, 8				#Desloca 8 bits para esquerda no resultado
	xor r23, r23, r18				#Realiza opera��o XOR no com valor pr� calculado e resultado anterior
	subi r16, r16, 1				#Decrementa o contador de sequ�ncias de bytes j� computadas na sequ�ncia de 32 bits
	slli r17, r17, 8 				#Desloca primeiro byte para fora do registrador, adicionando 0s no final
	br calculo_crc_para_32_bits

#Finaliza o c�lculo para uma sequ�ncia de 32 bits
finaliza_calculo_para_32bits:	
	addi r14, r14, 1				#Incrementa o contador de sequ�ncias de 32 bits j� computadas
	br prepara_proxima_sequencia_32bits	


inicializa_lcd:

movia r15, BASE_DADOS_ENDERECO
addi r15, r15, 1000 #CRC RECEBIDO

beq r15, r23, certo
br errado

certo:

errado:
movia r1, LCD_PT1_ENDERECO
movi r19, 0x65
stb r19, 0(r1)

movia r1, LCD_PT2_ENDERECO
movi r19, 0x72
stb r19, 0(r1)

movia r1, LCD_PT3_ENDERECO
movi r19, 0x72
stb r19, 0(r1)

movia r1, LCD_PT4_ENDERECO
movi r19, 0x61
stb r19, 0(r1)

movia r1, LCD_PT5_ENDERECO
movi r6, 0x6f
stb r6, 0(r5)

movia r1, LCD_PT6_ENDERECO
movi r6, 0x0a
stb r6, 0(r5)

movia r5, LCD_PT7_ENDERECO
movi r6, 0x21
stb r6, 0(r5)

movia r5, LCD_PT8_ENDERECO
movi r6, 0x21
stb r6, 0(r5)

movia r5, LCD_PT9_ENDERECO
movi r6, 0x21
stb r6, 0(r5)

movia r1, MODO_OPERACAO_LCD_ENDERECO
movi r2, 2
stb r2, 0(r1)

fim:
br fim