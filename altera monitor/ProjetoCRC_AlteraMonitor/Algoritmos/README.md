# Calculadora CRC-32Q

## Testes para a calculadora CRC-32Q

### Descrição dos Arquivos
- `montar_tabela.s`: Monta a *lookup table* com todos os resultados para todas as possíveis divisões entre *bytes* e o polinômio.
- `calcular_crc_1KB.s`: Armazena a entrada na memória e realiza o cálculo do CRC-32Q para a entrada.
- `exibir_resultado.s`: Exibe o resultado do cálculo anterior por meio de 4 *LEDs* e auxílio de um *push button*.

### Insumos para Testes
Foi utilizada uma [ferramenta online](https://github.com/GustavoHBO/MI-SD-Linguagem-de-Maquina-e-Microarquitetura/tree/master/Calculadora%20CRC%20e%20Gerador%20de%20Mensagem) para a geração de sequências de 1 KB e obtenção do respectivo valor do CRC-32Q para essas sequências.

### Parâmetros Importantes
Os parâmetros abaixo contém valores importantes para o cálculo do CRC-32Q. 

- Espaço de memória `TABELA` no arquivo `montar_tabela.s`: contém o endereço do espaço de memória inicial para a tabela de valores pré computados
- Espaço de memória `ENTRADA` no arquivo `calcular_crc_1KB.s`: contém a entrada de 1 KB para cálculo do CRC-32Q
- Espaço de memória `LED_ENDERECO` no arquivo `calcular_crc_1KB.s`: contém o endereço de memória no qual deve ser armazenado o dado a ser exibido nos *LEDs*
- Espaço de memória `BOTAO_ENDERECO` no arquivo `calcular_crc_1KB.s`: contém o endereço de memória do qual deve ser lido os dados do botão
- Espaço de memória `DELAY` no arquivo `exibir_resultado.s`: contém o endereço de memória do qual deve ser lido o valor a ser decrementado no delay
- Registrador `R1` em `montar_tabela.s`: armazena o valor do polinômio utilizado para construção da tabela
- Registrador `R23` em `calcular_crc_1KB.s` e `exibir_resultado.s`: contém o valor do CRC-32 obtido ao final do cômputo para a entrada

### Execução de Testes
1. Ligue a placa e conecte o USB-Blaster no computador
2. Abra o projeto no Altera Monitor: *File > Open Project > ProjetoAlteraMonitor.ncf*
3. Confirme o carregamento do processador na placa na caixa de diálogo que será aberta
4. Compile o código fonte e o carregue na placa: *Actions > Compile & Load*
5. Inicie a execução do código: *Actions > Continue*
6. Observe que os *LEDs* da placa serão desligados, indicando que o código fonte foi executado
7. Pause a execução do código *Actions > Pause*, caso deseje visualizar o valor final no registrador `R23`

### Desenvolvedores
- Nadine Cerqueira Marques
- Valmir Vinicius de Almeida Santos
