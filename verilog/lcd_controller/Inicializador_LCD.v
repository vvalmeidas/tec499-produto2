
module	Inicializador_LCD(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Inputs
			//------------------------------------------------------------------
			Modo,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Outputs
			//------------------------------------------------------------------
			Estado,
			Enable,
			RS,
			RW,
			Dados,
			Inicializado
			//------------------------------------------------------------------
	);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	reg[31:0]	delay = 32'd3000000;
	
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Clock & Reset Inputs
	//--------------------------------------------------------------------------
	input					Clock;	
	input					Reset;
	input[1:0]			Modo;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Inputs
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Outputs
	//--------------------------------------------------------------------------
	output[3:0]			Estado;
	output			 	Enable;
	output				RS;
	output				RW;
	output[7:0]			Dados;
	output				Inicializado;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Estado Encoding
	//--------------------------------------------------------------------------
	parameter [3:0] 	WAIT_30MS = 4'b0000,
							FUNCTION_SET = 4'b0001,
							WAIT_39US = 4'b0010,
							DISPLAY_ONOFF = 4'b0011,
							WAIT_39US_2 = 4'b0100,
							DISPLAY_CLEAR = 4'b0101,
							WAIT_153MS = 4'b0110,
							ENTRY_MODE_SET = 4'b0111,
							FINISH_INITIALIZATION = 4'b1000;
							
	//--------------------------------------------------------------------------


	
	//--------------------------------------------------------------------------
	//	Wire Declarations
	//--------------------------------------------------------------------------
	
	reg[3:0]		estado, proximo;
	reg[7:0]		dados;
	reg[31:0]	delay_temp;
	reg			enable, rs;

	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Logic
	//--------------------------------------------------------------------------
	
	always @(posedge Clock or negedge Reset) begin
		if(!Reset)	estado <= WAIT_30MS;
		else begin
			delay <= delay_temp;
			estado <= proximo;
		end
	end

	always @(estado) begin
		case(estado)
			WAIT_30MS: begin
				if(Modo != 2'd1 & Modo != 2'd2)	begin
					enable = 1'b1;
					proximo = WAIT_30MS;
				end else begin
					enable = 1'b1;
					if(delay == 32'd0) begin
						proximo = FUNCTION_SET;
					end else begin
						delay_temp = delay - 32'd1;
						proximo = WAIT_30MS;
					end
				end
			end

			FUNCTION_SET:	begin
				enable = 1'b0;
				dados = 8'b000001XX;
				proximo = WAIT_39US;
				delay_temp = 32'd4000;
			end
			
			WAIT_39US: begin
				enable = 1'b1;

				if(delay == 32'd0)	begin
					proximo = DISPLAY_ONOFF;
				end else	begin
					delay_temp = delay - 32'd1;
					proximo = WAIT_39US;
				end
			end

			DISPLAY_ONOFF:	begin
				enable = 1'b0;
				
				if(Modo == 2'b01)								dados = 8'b00001101;
				else if(Modo == 2'b10)						dados = 8'b00001111;
				
				proximo = WAIT_39US_2;
				delay_temp = 32'd4000;
			end

			WAIT_39US_2: begin
				enable = 1'b1;
				if(delay == 32'd0)	begin
					proximo = DISPLAY_CLEAR;
				end else	begin
					delay_temp = delay - 32'd1;
					proximo = WAIT_39US_2;
				end
			end
			
			DISPLAY_CLEAR:	begin
				enable = 1'b0;
				dados = 8'b00000001;
				proximo = WAIT_153MS;
				delay_temp = 32'd9000000;
			end
					
			WAIT_153MS: begin
				enable = 1'b1;
				if(delay == 32'd0) begin
					proximo = ENTRY_MODE_SET;
				end else begin
					delay_temp = delay - 32'd1;
					proximo = WAIT_153MS;
				end 
			end

			ENTRY_MODE_SET:	begin
				enable = 1'b0;
				dados = 8'b00000110;
				proximo = FINISH_INITIALIZATION;
			end
			
			FINISH_INITIALIZATION:	begin
				proximo = FINISH_INITIALIZATION;
			end

		endcase
	end

	assign Estado = ~estado;
	assign Enable = enable;
	assign Dados = dados;
	assign RW = 1'b0;
	assign RS = 1'b0;
	assign Inicializado = estado == FINISH_INITIALIZATION ? 1'b1 : 1'b0;
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------