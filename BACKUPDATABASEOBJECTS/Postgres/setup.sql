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

-- -----------------------------------------------------
-- Table public.log
-- -----------------------------------------------------

CREATE TABLE public.log (
	LogId UUID NOT NULL PRIMARY KEY,
	"Message" TEXT NULL,
	PreviousPayload TEXT NULL,
	CurrentPayload TEXT NULL,
	Request VARCHAR(200) NULL,
	Response VARCHAR(3) NULL,
	"Method" VARCHAR(20) NULL,
	Dateadded VARCHAR(20) NULL,
	Useradded UUID NULL
);

-- -----------------------------------------------------
-- Table public.Message
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.Messages (
    MessageId UUID NOT NULL PRIMARY KEY,
    SenderId UUID,
    MessageContext TEXT NOT NULL,
    MessageTypeId INT NOT NULL,
    IsHtml BOOLEAN NOT NULL,
    RecipientId UUID,
    UserAddedId UUID NOT NULL,
    UserUpdatedId UUID,
    DateAdded TIMESTAMP NOT NULL,
    DateUpdated TIMESTAMP,
    Active BOOLEAN NOT NULL
);

CREATE UNIQUE INDEX idx_user_added_id_msg ON public.Messages (UserAddedId);

CREATE UNIQUE INDEX idx_recipient_id_msg ON public.Messages (RecipientId);

CREATE UNIQUE INDEX idx_sender_id_msg ON public.Messages (SenderId);

-- -----------------------------------------------------
-- Table public.Files
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.StorageFiles (
    FileId UUID NOT NULL PRIMARY KEY,
    Title VARCHAR(50),
	FilePath VARCHAR(300) NOT NULL,
    "Description" TEXT,
    MainFile BOOLEAN NOT NULL,
    Public BOOLEAN NOT NULL,
    ExternalReferenceId UUID NOT NULL,
    UserAddedId UUID NOT NULL,
    UserUpdatedId UUID,
    DateAdded TIMESTAMP NOT NULL,
    DateUpdated TIMESTAMP
);

CREATE UNIQUE INDEX idx_user_added_id_file ON public.StorageFiles (UserAddedId);

CREATE UNIQUE INDEX idx_external_reference_id ON public.StorageFiles (ExternalReferenceId);