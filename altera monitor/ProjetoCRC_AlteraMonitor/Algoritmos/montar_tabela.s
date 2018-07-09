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

