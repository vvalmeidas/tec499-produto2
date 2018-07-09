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