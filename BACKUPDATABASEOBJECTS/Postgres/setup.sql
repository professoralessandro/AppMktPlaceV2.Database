/*
SCRIPT DE CRIACAO E GERACAO DO BANCO DE DADOS DE DESENVOLVIMENTO APDB (ALESSANDRO PROGRAMING). NOME PROVISORIO DO PROJETO
ESTE SCRIPT CONSISTE NA CRIACAO DAS TABELAS
DATA E HORA INICIO: 27/04/2024
CRIADOR: ALESSANDRO DOS SANTOS
DATABASE: POSTGRES
VERSAO 1.0
*/

-- public.log definition

-- Drop table

-- DROP TABLE public.log;

CREATE TABLE public.log (
	logid uuid NOT NULL,
	message text NULL,
	previousPayload text NULL,
	currentPayload text NULL,
	request varchar(200) NULL,
	response varchar(3) NULL,
	"method" varchar(20) NULL,
	dateadded varchar(20) NULL,
	useradded uuid NULL,
	CONSTRAINT log_pkey PRIMARY KEY (logid)
);