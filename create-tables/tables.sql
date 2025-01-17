CREATE TABLE TIPO_PESSOA (
	ID_TIPO_PESSOA SERIAL PRIMARY KEY NOT NULL,
	DESCRICAO_TIPO_PESSOA VARCHAR(40) NOT NULL
);


CREATE TABLE METODO_DE_PAGAMENTO (
	ID_METODO_DE_PAGAMENTO SERIAL PRIMARY KEY NOT NULL,
	NOME_METODO_DE_PAGAMENTO VARCHAR(40) NOT NULL

);

CREATE TABLE PEDRA (
	ID_PEDRA SERIAL PRIMARY KEY NOT NULL,
	DESCRICAO_PEDRA VARCHAR(100) NOT NULL,
	TAMANHO FLOAT DEFAULT 3.0 NOT NULL,
	VALOR_DIARIA NUMERIC(10, 2) DEFAULT 250.00 NOT NULL

);

CREATE TABLE CARGO ( 
	ID_CARGO SERIAL PRIMARY KEY NOT NULL,
	NOME_CARGO VARCHAR(40) NOT NULL,
	SALARIO NUMERIC(10,2) NOT NULL
);

CREATE TABLE ANALISTA (
	ID_ANALISTA SERIAL PRIMARY KEY NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	CPF_ANALISTA VARCHAR(11) NOT NULL,
	ENDERECO_ANALISTA VARCHAR(100) NOT NULL,
	ID_CARGO INT NOT NULL REFERENCES CARGO,
	DATA_FIM_CONTRATO DATE,
	USERNAME VARCHAR(40) NOT NULL,
	DATA_CONTRATACAO TIMESTAMP NOT NULL DEFAULT NOW(),
	CONSTRAINT UNIQUE_CPF_ANALISTA UNIQUE (CPF_ANALISTA),
	CONSTRAINT UNIQUE_USERNAME UNIQUE (USERNAME)
);

CREATE TABLE PARCEIRO (
	ID_PARCEIRO SERIAL PRIMARY KEY NOT NULL,
	NOME_PARCEIRO VARCHAR(100) NOT NULL,
	CPF_CNPJ VARCHAR(14) NOT NULL,
	TELEFONE VARCHAR(12) NOT NULL,
	EMAIL VARCHAR(100) NOT NULL,
	ENDERECO_PARCEIRO VARCHAR(100) NOT NULL,
	ID_TIPO_PESSOA SERIAL NOT NULL REFERENCES TIPO_PESSOA,
	CONSTRAINT UNIQUE_CPF_CNPJ UNIQUE (CPF_CNPJ)
);

CREATE TABLE PEDIDO (
	ID_PEDIDO SERIAL PRIMARY KEY NOT NULL,
	ID_PARCEIRO INT NOT NULL REFERENCES PARCEIRO,
	ID_ANALISTA INT NOT NULL REFERENCES ANALISTA,
	DATA_VENCIMENTO_PAGAMENTO_COMISSAO TIMESTAMP DEFAULT NULL,
	DATA_PAGAMENTO_COMISSAO TIMESTAMP DEFAULT NULL,
	VALOR_COMISSAO NUMERIC(10,2) DEFAULT 0.00,
	VALOR_TOTAL_PEDIDO NUMERIC(10,2) DEFAULT 0.00 NOT NULL,	
	DATA_REGISTRO TIMESTAMP DEFAULT NOW(),
	ID_METODO_PAGAMENTO INT REFERENCES METODO_DE_PAGAMENTO,
	NUMERO_NOTA UUID,
	DATA_PAGAMENTO_PEDIDO TIMESTAMP
);


CREATE TABLE TIPO_MULTA (
	ID_TIPO_MULTA SERIAL PRIMARY KEY NOT NULL,
	DESCRICAO_TIPO_MULTA VARCHAR (40) NOT NULL
);

CREATE TABLE MULTA (
	ID_MULTA SERIAL PRIMARY KEY NOT NULL,
	DESCRICAO VARCHAR(100) NOT NULL,
	ID_PEDIDO SERIAL NOT NULL REFERENCES PEDIDO,
	VALOR_MULTA FLOAT NOT NULL,
	DATA_PAGAMENTO_MULTA TIMESTAMP DEFAULT NULL,
	ID_TIPO_MULTA INT NOT NULL REFERENCES TIPO_MULTA	
);



CREATE TABLE LISTA_PEDRAS_PEDIDO (
	ID_PEDRA SERIAL NOT NULL REFERENCES PEDRA,
	ID_PEDIDO SERIAL NOT NULL REFERENCES PEDIDO,
	DATA_INICIAL DATE NOT NULL,
	DATA_FINAL DATE NOT NULL,
	FATURAMENTO NUMERIC(10,2) DEFAULT 0.00 NOT NULL,
	CONSTRAINT ID_PEDRA_PEDIDO PRIMARY KEY (ID_PEDRA, ID_PEDIDO)
);
