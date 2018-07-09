//------------------------------------------------------------------------------
//	Module:	FPGA_TOP_MIV
//	Desc:	Top level interface from a Mercurio FPGA board
//------------------------------------------------------------------------------

module Controller_LCD_TOP(
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
		Entrada,
		//------------------------------------------------------------------

		//------------------------------------------------------------------
		//	Outputs
		//------------------------------------------------------------------
		Estado,
		Enable,
		RS,
		RW,
		Dados
	);
	
	input					Clock;	
	input					Reset;	
	input[71:0]			Entrada;
	input[1:0]			Modo;

	output				Enable;
	output				RS;
	output				RW;
	output[7:0]			Dados;
	output[3:0]			Estado;

	wire					inicializado;
	wire[2:0]			estado_inicializador;	
	wire					enable_inicializador;
	wire					rs_inicializador;
	wire					rw_inicializador;
	wire[7:0]			dados_inicializador;
	
	wire[1:0]			estado_escritor;	
	wire					enable_escritor;
	wire					rs_escritor;
	wire					rw_escritor;
	wire[7:0]			dados_escritor;
	
			
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Parse input from buttons
	//--------------------------------------------------------------------------

	Inicializador_LCD	Inicializador (	
							.Clock(				Clock),
							.Reset(				Reset),
							.Modo(				Modo),
							.Estado(				estado_inicializador),
							.Enable(				enable_inicializador),
							.RS(				rs_inicializador),
							.RW(				rw_inicializador),
							.Dados(				dados_inicializador),				
							.Inicializado(				inicializado));	
							
	Escritor_LCD		Escritor (
							.Clock(				Clock),
							.Reset(				Reset),
							.Entrada(				Entrada),
							.Inicializado(			inicializado),
							.Enable(				enable_escritor),
							.RS(				rs_escritor),
							.RW(				rw_escritor),				
							.Dados(				dados_escritor));
							

							
			
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Output Logic
	//--------------------------------------------------------------------------
	assign Estado = estado_inicializador;
	assign Enable = inicializado == 1'b1 ? enable_escritor : enable_inicializador;
	assign RS = inicializado == 1'b1 ? rs_escritor : rs_inicializador;
	assign RW = inicializado == 1'b1 ? rw_escritor : rw_inicializador;
	assign Dados = inicializado == 1'b1 ? dados_escritor : dados_inicializador;
	//--------------------------------------------------------------------------	

endmodule