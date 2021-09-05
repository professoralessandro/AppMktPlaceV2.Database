/*
SCRIPT DE CRIACAO E GERACAO DO BANCO DE DADOS DE DESENVOLVIMENTO APDB (ALESSANDRO PROGRAMING). NOME PROVISORIO DO PROJETO
ESTE SCRIPT CONSISTE NA CRIACAO DAS TABELAS
DATA E HORA INICIO: 05/04/2021
CRIADOR: ALESSANDRO DOS SANTOS
VERSAO 1.0
*/
IF DB_ID('APDBDev') IS NOT NULL
BEGIN
	USE MASTER
	DROP DATABASE [APDBDev]
END
CREATE DATABASE [APDBDev]
GO

USE [APDBDev]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Schema SEG
-- -----------------------------------------------------

GO
CREATE SCHEMA [seg]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[TiposDocumentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposDocumentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposDocumentos] (
		[TipoDocumentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[StatusAprovacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[StatusAprovacoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[StatusAprovacoes] (
		[StatusAprovacaoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[Valor] VARCHAR(50) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[TiposWorkFlows]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposWorkFlows]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposWorkFlows] (
		[TipoWorkFlowId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Reclamacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposMensagens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Reclamacoes] (
  		[ReclamacaoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[Descricao] VARCHAR(MAX) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [seg].[Grupos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Grupos]') IS NULL
BEGIN
	CREATE TABLE [seg].[Grupos] (
	    [GrupoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	    [Grupo] [varchar](50) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [seg].[Usuarios]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Usuarios]') IS NULL
BEGIN
	CREATE TABLE [seg].[Usuarios] (
		[UsuarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Usuario] [varchar](50) NOT NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumentoId] INT NOT NULL,
		[GrupoId] INT NOT NULL,
		[Senha] [varchar](max) NOT NULL,
		[Nome] [varchar](255) NOT NULL,
		[DataNascimento] [datetime] NULL,
		[Sexo] [varchar](1) NULL,
		[EstadoCivil] [varchar](2) NULL,
		[Email] [varchar](255) NOT NULL,
		[TrocaSenha] [bit] NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[DataUltimaTrocaSenha] [datetime] NOT NULL,
		[DataUltimoLogin] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Usuarios_GrupoId] FOREIGN KEY([GrupoId])
		REFERENCES [seg].[Grupos] ([GrupoId]),
		CONSTRAINT [FK_Usuarios_TipoDocumentoId] FOREIGN KEY([TipoDocumentoId])
		REFERENCES [dbo].[TiposDocumentos] ([TipoDocumentoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [seg].[Recursos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Recursos]') IS NULL
BEGIN
	CREATE TABLE [seg].[Recursos] (
		[RecursoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Nome] [varchar](50) NOT NULL,
		[Chave] [varchar](100) NOT NULL,
		[ToolTip] [varchar](255) NULL,
		[Route] [varchar](max) NULL, -- ANTIGO URL
		[Menu] [bit] NOT NULL,
		[RecursoIdPai] [int] NULL,
		[Ordem] [int] NULL,
		[Ativo] [bit] NOT NULL,
		[Type] [varchar](100) NULL,
		[Icon] [varchar](100) NULL,
		[Path] [varchar](100) NULL, -- ANTIGO MENU CLASS
		[isSubMenu] [bit] NOT NULL		
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [seg].[GruposRecursos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[GruposRecursos]') IS NULL
BEGIN
	CREATE TABLE [seg].[GruposRecursos] (
		[GrupoRecursoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[GrupoId] INT NULL ,
		[RecursoId] INT NULL,
		CONSTRAINT [FK_GruposRecursos_RecursoId] FOREIGN KEY([RecursoId])
		REFERENCES [seg].[Recursos] ([RecursoId]),
		CONSTRAINT [FK_GruposRecursos_GrupoId] FOREIGN KEY([GrupoId])
		REFERENCES [seg].[Grupos] ([GrupoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Sedes]
-- -----------------------------------------------------
-- IF OBJECT_ID('[dbo].[Sedes]') IS NULL
-- BEGIN
-- CREATE TABLE [dbo].[Sedes] (
--  [SedeId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY 
--  )
-- GO
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosSedes]
-- -----------------------------------------------------
-- IF OBJECT_ID('[dbo].[AssociadosSedes]') IS NULL
-- BEGIN
-- 	CREATE TABLE [dbo].[AssociadosSedes] (
--  [AssociadoSedeId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
--  [AssociacoId] INT NULL,
--  [SedeId] INT NULL
--  )
-- GO
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

-- -----------------------------------------------------
-- RELACIONAMENTOS 1 X 1 INICIO
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Table [seg].[WorkFlows]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[WorkFlows]') IS NULL
BEGIN
	CREATE TABLE [seg].[WorkFlows] (
	    [WorkFlowId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	    [UsuarioResponsavel] INT NOT NULL,
		[DataWorkFlow] DATETIME NOT NULL,
		[Observacao] VARCHAR(MAX) NULL,
		[StatusAprovacaoId] INT NOT NULL,
		[DataWorkFlowVerificacao] DATETIME NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_WorkFlows_StatusAprovacaoId] FOREIGN KEY([StatusAprovacaoId])
		REFERENCES [dbo].[StatusAprovacoes] ([StatusAprovacaoId])
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[PrestadorasServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[PrestadorasServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[PrestadorasServicos] (
		[PrestadoraServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[AssociadoId] INT NOT NULL,
		[Descricao] VARCHAR(50) NOT NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumentoId] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL,
		CONSTRAINT [FK_PrestadorasServicos_TipoDocumentoId] FOREIGN KEY([TipoDocumentoId])
		REFERENCES [dbo].[TiposDocumentos] ([TipoDocumentoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Lojas]
/*
O NUMERO DO DOCUMENTO E O DOCUMENTO ID DA LOJA DEVEM SER OBRIGATORIAMENTE O CNPJ
*/
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Lojas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Lojas] (
		[LojaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[AssociadoId] INT NOT NULL,
		[RazaoSocial] VARCHAR(50) NOT NULL,
		[InscricaoMunicipal] VARCHAR(25) NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,        -- CNPJ
		[TipoDocumentoId] INT NOT NULL,             -- CNPJ
		[Email] [varchar](255) NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL,
		CONSTRAINT [FK_Lojas_TipoDocumentoId] FOREIGN KEY([TipoDocumentoId])
		REFERENCES [dbo].[TiposDocumentos] ([TipoDocumentoId]),
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[TiposLancamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposLancamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposLancamentos] (
		[TipoLancamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[FormasPagamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[FormasPagamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[FormasPagamentos] (
		[FormaPagamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] [varchar](50) NOT NULL,
		[PermiteParcelar] [bit] NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- -----------------------------------------------------
-- RELACIONAMENTOS 1 X 1 FIM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table [dbo].[Produtos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Produtos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Produtos] (
		[ProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[CodigoBarras] VARCHAR(50) NULL,
		[Marca] VARCHAR(MAX) NULL,
		[Quantidade] INT NOT NULL,
		[IsIlimitado] BIT NOT NULL,
		[QuantidadeCritica] INT NULL,
		[PrecoCusto] DECIMAL(10,2) NOT NULL,
		[PrecoVenda] DECIMAL(10,2) NOT NULL,
		[MargemLucro] DECIMAL(10,2) NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Departamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Departamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Departamentos] (
		[DepartamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Caracteristicas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Caracteristicas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Caracteristicas] (
    	[CaracteristicaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    	[Descricao] VARCHAR(MAX) NOT NULL,
    	[Ordem] INT NULL,
    	[Publico] BIT NOT NULL,
    	[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Imagens]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Imagens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Imagens] (
  		[ImagemId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Path] VARCHAR(100) NOT NULL,
    	[Descricao] VARCHAR(50) NOT NULL,
		[ImagemPrincipal] BIT NOT NULL,
		[Publico] BIT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Avaliacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Avaliacoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Avaliacoes] (
  		[AvaliacaoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    	[Descricao] VARCHAR(MAX) NOT NULL,
		[Valor] DECIMAL(10, 2) NOT NULL,
		[ProdutoId] INT NULL,
		[ServicoId]	INT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Associados]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Associados]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Associados] (
		[AssociadoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Usuario] [varchar](50) NOT NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumentoId] INT NOT NULL,
		[GrupoId] INT NOT NULL,
		[Senha] [varchar](max) NOT NULL,
		[Nome] [varchar](255) NOT NULL,
		[DataNascimento] [datetime] NULL,
		[Sexo] [varchar](1) NULL,
		[EstadoCivil] [varchar](2) NULL,
		[Email] [varchar](255) NOT NULL,
		[TrocaSenha] [bit] NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[DataUltimaTrocaSenha] [datetime] NOT NULL,
		[DataUltimoLogin] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Usuarios_GrupoId] FOREIGN KEY([GrupoId])
		REFERENCES [seg].[Grupos] ([GrupoId]),
		CONSTRAINT [FK_Associados_TipoDocumentoId] FOREIGN KEY([TipoDocumentoId])
		REFERENCES [dbo].[TiposDocumentos] ([TipoDocumentoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[TiposConfiguracoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposTelefones]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposTelefones] (
  		[TipoTelefoneId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Telefones]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Telefones]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Telefones] (
  		[TelefoneId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    	[TipoTelefoneId] INT NOT NULL,
		[Telefone] VARCHAR(20) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
		CONSTRAINT [FK_Enderecos_TipoTelefoneId] FOREIGN KEY([TipoTelefoneId])
		REFERENCES [dbo].[TiposTelefones] ([TipoTelefoneId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Enderecos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Enderecos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Enderecos] (
  		[EnderecoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Logradouro] VARCHAR(100) NOT NULL,
		[Numero] VARCHAR(10) NULL,
		[Complemento] VARCHAR(10) NULL,
		[Bairro] VARCHAR(50) NULL,
		[Cidade] VARCHAR(50) NULL,
		[Estado] VARCHAR(50) NULL,
		[CEP] VARCHAR(10) NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Vendas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Vendas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Vendas] (
  		[VendaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Vendas_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Servicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Servicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Servicos] (
  		[ServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[Quantidade] INT NOT NULL,
		[IsIlimitado] BIT NOT NULL,
		[QuantidadeCritica] INT,
		[PrecoCusto] DECIMAL(10,2) NOT NULL,
		[PrecoVenda] DECIMAL(10,2) NOT NULL,
		[MargemLucro] DECIMAL(10,2) NOT NULL,
		[Bloqueado] BIT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Situacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Situacoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Situacoes] (
		[SituacaoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Lancamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Lancamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Lancamentos] (
		[LancamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[AssociadoId] INT NULL,
		[Referencia] VARCHAR(150) NULL,
		[SituacaoId] INT NOT NULL,
		[ValorLancamento] DECIMAL(10, 2) NULL,
		[DataMovimento] [datetime] NULL,
		[DataBaixa] [datetime] NULL,
		[Observacao] [varchar](max) NULL,
		[UsuarioIdBaixa] INT NULL,
		[LancamentoIdPai] INT NULL,
		[NroAutorizacao] [varchar](20) NULL,
		[NroAutenticacao] [varchar](20) NULL,
		[NroComprovante] [varchar](20) NULL,
		[NroPedido] [varchar](20) NULL,
		[FormaPagamentoId] [int] NULL,
		[QtdeParcelas] [int] NULL,
		[ValorParcela] DECIMAL(10, 2) NULL,
		[TipoLancamentoId] INT NOT NULL,
		CONSTRAINT [FK_Lancamentos_TipoLancamentoId] FOREIGN KEY([TipoLancamentoId])
		REFERENCES [dbo].[TiposLancamentos] ([TipoLancamentoId]),
		CONSTRAINT [FK_Lancamentos_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_Lancamentos_SituacaoId] FOREIGN KEY([SituacaoId])
		REFERENCES [dbo].[Situacoes] ([SituacaoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Garantias]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Garantias]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Garantias] (
  		[GarantiaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[PrecoVenda] DECIMAL(10,2) NOT NULL,
		[Bloqueado] BIT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[NotasFiscais]
-- NOTAS FISCAIS SERA IMPLEMENTADO POSTERIORMENTE
-- -----------------------------------------------------
 IF OBJECT_ID('[dbo].[NotasFiscais]') IS NULL
 BEGIN
 	CREATE TABLE [dbo].[NotasFiscais] (
   		[NotaFiscalId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY
   	)
 END
 GO
 SET ANSI_NULLS ON
 GO
 SET QUOTED_IDENTIFIER ON
 GO


-- -----------------------------------------------------
-- Table [dbo].[Emails]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Emails]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Emails] (
  		[EmailId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[NomeEmail] VARCHAR(100) NULL,
      	[Destinatario] VARCHAR(150) NOT NULL,
		[AssociadoEnvioId] INT NOT NULL,
      	[Assunto] VARCHAR(100) NULL,
      	[Mensagem] VARCHAR(150) NOT NULL,
      	[Html] BIT NOT NULL,
      	[Enviado] BIT NOT NULL,
      	[Tentativas] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Emails_AssociadoEnvioId] FOREIGN KEY([AssociadoEnvioId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[LotesEmails]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[LotesEmails]') IS NULL
BEGIN
	CREATE TABLE [dbo].[LotesEmails] (
  		[LoteEmailId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[NomeEmail] VARCHAR(100) NULL,
      	[Destinatarios] VARCHAR(150) NOT NULL,
      	[Assunto] VARCHAR(100) NULL,
      	[Mensagem] VARCHAR(150) NOT NULL,
      	[Html] BIT NOT NULL,
      	[Enviado] BIT NOT NULL,
      	[Tentativas] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Mensagens]
-- UNICO CAMPO BIG INT DO SISTEMA
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Mensagens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Mensagens] (
  		[MensagemId] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Mensagem] VARCHAR(MAX) NOT NULL,
		[TipoMensagemId] INT NOT NULL,
		[IsHtml] BIT NOT NULL,
		[RemetenteId] INT NOT NULL,
		[DestinatarioId] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Mensagens_RemetenteId] FOREIGN KEY([RemetenteId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Entregas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Entregas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Entregas] (
  		[EntregaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[PrestadoraServicoId] INT NOT NULL,
		[DataPrevistaEntrega] DATETIME NOT NULL,
		[DataEfetivaEnrega] DATETIME NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumentoId] INT NOT NULL,
		[NomeRecebedor] VARCHAR(200) NOT NULL,
		[ResponsavelEntregaId] INT NOT NULL,
		[isEntregueTitular] BIT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
		CONSTRAINT [FK_Entregas_PrestadoraServicoId] FOREIGN KEY([PrestadoraServicoId])
		REFERENCES [dbo].[PrestadorasServicos] ([PrestadoraServicoId]),
		CONSTRAINT [FK_Entregas_ResponsavelEntregaId] FOREIGN KEY([ResponsavelEntregaId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Bloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Bloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Bloqueios] (
  		[BloqueioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[NomeBloqueio] VARCHAR(100) NOT NULL,
		[isBloqueiaAcesso] BIT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[DadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[DadosBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[DadosBancarios] (
  		[DadoBancarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[AssociadoId] INT NOT NULL,
		[Banco] VARCHAR(100) NOT NULL,
		[Agencia] VARCHAR(6) NOT NULL,
		[Conta] VARCHAR(20) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_DadosBancarios_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[DadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[CartoesBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[CartoesBancarios] (
  		[CartaoBancarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[AssociadoId] INT NOT NULL,
		[Numero] VARCHAR(16) NOT NULL,
		[NomeNoCartao] VARCHAR(50) NOT NULL,
		[Bandeira] VARCHAR(10) NOT NULL,
		[Validade] VARCHAR(6) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[CodSeg] VARCHAR(3) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_CartoesBancarios_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[TiposConfiguracoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposConfiguracoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposConfiguracoes] (
  		[TipoConfiguracaoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Configuracoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Configuracoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Configuracoes] (
  		[ConfiguracaoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TipoConfiguracaoId] INT NOT NULL,
		[Descricao] VARCHAR(150) NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Configuracoes_TipoConfiguracaoId] FOREIGN KEY([TipoConfiguracaoId])
		REFERENCES [dbo].[TiposConfiguracoes] ([TipoConfiguracaoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[TiposParametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposParametros]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposParametros] (
		[TipoParametroId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] [varchar](100) NOT NULL,
	  	[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[TiposDados]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposDados]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposDados] (
		[TipoDadoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] [varchar](100) NOT NULL,
	  	[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Parametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Parametros]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Parametros] (
		[ParametroId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TipoParametroId] INT NOT NULL,
		[TipoDadoId] INT NOT NULL,
	  	[Descricao] [varchar](100) NOT NULL,
	  	[Valor] [varchar](max) NOT NULL,
	  	[Publico] [bit] NOT NULL,
	  	[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Parametros_TipoParametroId] FOREIGN KEY([TipoParametroId])
		REFERENCES [dbo].[TiposParametros] ([TipoParametroId]),
		CONSTRAINT [FK_Parametros_TipoDadoId] FOREIGN KEY([TipoDadoId])
		REFERENCES [dbo].[TiposDados] ([TipoDadoId]),
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[Pagamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Pagamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Pagamentos] (
  		[PagamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[LancamentoId] INT NULL,
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- AREA LIGACOES ENTRE TABELAS
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Table [dbo].[ConfiguracoesParametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ConfiguracoesParametros]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ConfiguracoesParametros] (
		[ConfiguracaoParametroId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[ParametroId] INT NOT NULL,
		[ConfiguracaoId] INT NOT NULL,
		CONSTRAINT [FK_ConfiguracoesParametros_ParametroId] FOREIGN KEY([ParametroId])
		REFERENCES [dbo].[Parametros] ([ParametroId]),
		CONSTRAINT [FK_ConfiguracoesParametros_ConfiguracaoId] FOREIGN KEY([ConfiguracaoId])
		REFERENCES [dbo].[Configuracoes] ([ConfiguracaoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosEntregas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadosEntregas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadosEntregas] (
		[AssociadoEntregaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[EntregaId] INT NOT NULL,
		[AssociadoId] INT NOT NULL,
		CONSTRAINT [FK_AssociadosEntregas_EntregaId] FOREIGN KEY([EntregaId])
		REFERENCES [dbo].[Entregas] ([EntregaId]),
		CONSTRAINT [FK_AssociadosEntregas_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[EntregasProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EntregasProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EntregasProdutos] (
  		[EntregaProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ProdutoId] INT NOT NULL,
  		[AssociadoId] INT NOT NULL,
		CONSTRAINT [FK_EntregasProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_EntregasProdutos_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosLancamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadosLancamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadosLancamentos] (
  		[AssociadoLancamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[LancamentoId] INT NOT NULL,
		[AssociadoId] INT NOT NULL,
		CONSTRAINT [FK_AssociadosLancamentos_LancamentoId] FOREIGN KEY([LancamentoId])
		REFERENCES [dbo].[Lancamentos] ([LancamentoId]),
		CONSTRAINT [FK_AssociadosLancamentos_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[UsuariosPagamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[UsuariosPagamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[UsuariosPagamentos] (
		[PagamentoUsuarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[PagamentoId] INT NOT NULL,
		[UsuarioId] INT NOT NULL,
		CONSTRAINT [FK_UsuariosPagamentos_PagamentoId] FOREIGN KEY([PagamentoId])
		REFERENCES [dbo].[Pagamentos] ([PagamentoId]),
		CONSTRAINT [FK_UsuariosPagamentos_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[CaracteristicasProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[CaracteristicasProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[CaracteristicasProdutos] (
		[CaracteristicaProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[ProdutoId] INT NOT NULL,
		[CaracteristicaId] INT NOT NULL,
		CONSTRAINT [FK_CaracteristicasProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_CaracteristicasProdutos_CaracteristicaId] FOREIGN KEY([CaracteristicaId])
		REFERENCES [dbo].[Caracteristicas] ([CaracteristicaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[DepartamentosProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[DepartamentosProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[DepartamentosProdutos] (
  		[DepartamentoProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ProdutoId] INT NOT NULL,
  		[DepartamentoId] INT NOT NULL,
		CONSTRAINT [FK_DepartamentosProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_DepartamentosProdutos_DepartamentoId] FOREIGN KEY([DepartamentoId])
		REFERENCES [dbo].[Departamentos] ([DepartamentoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[VendasLojas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[VendasLojas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[VendasLojas] (
  		[VendaLojaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[VendaId] INT NOT NULL,
		CONSTRAINT [FK_VendasLojas_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_VendasLojas_VendaId] FOREIGN KEY([VendaId])
		REFERENCES [dbo].[Vendas] ([VendaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[LojaFormasPagamentos]`
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ProdutosFormasPagamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ProdutosFormasPagamentos] (
	  	[ProdutoFormaPagamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	  	[ProdutoId] INT NULL,
	  	[FormaPagamentoId] INT NULL,
	  	CONSTRAINT [FK_ProdutosFormasPagamentos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_ProdutosFormasPagamentos_FormaPagamentoId] FOREIGN KEY([FormaPagamentoId])
		REFERENCES [dbo].[FormasPagamentos] ([FormaPagamentoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[EmailsLojas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EmailsLojas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EmailsLojas] (
  		[EmailLojaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[LojaId] INT NOT NULL,
  		[EmailId] INT NOT NULL,
  		[AssociadoId] INT NOT NULL,
		CONSTRAINT [FK_EmailsLojas_ELojaId] FOREIGN KEY([LojaId])
		REFERENCES [dbo].[LojaS] ([LojaId]),
		CONSTRAINT [FK_EmailsLojas_EmailId] FOREIGN KEY([EmailId])
		REFERENCES [dbo].[Emails] ([EmailId]),
		CONSTRAINT [FK_EmailsLojas_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosDadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadosDadosBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadosDadosBancarios] (
  		[AssociadoDadoBancarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[DadoBancarioId] INT NOT NULL,
		CONSTRAINT [FK_AssociadosDadosBancarios_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[AssociadoS] ([AssociadoId]),
		CONSTRAINT [FK_AssociadosDadosBancarios_DadoBancarioId] FOREIGN KEY([DadoBancarioId])
		REFERENCES [dbo].[DadoSBancarios] ([DadoBancarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[VendasProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[VendasProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[VendasProdutos] (
  		[VendaProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ProdutoId] INT NOT NULL,
  		[VendaId] INT NOT NULL,
		CONSTRAINT [FK_VendasProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_VendasProdutos_VendaId] FOREIGN KEY([VendaId])
		REFERENCES [dbo].[Vendas] ([VendaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosCompras]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadosCompras]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadosCompras] (
  		[AssociadoCompraId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[ProdutoId] INT NOT NULL,
  		[ServicoId] INT NOT NULL,
		CONSTRAINT [FK_AssociadosCompras_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_AssociadosCompras_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_AssociadosCompras_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Emails] ([EmailId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[CaracteristicasServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[CaracteristicasServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[CaracteristicasServicos] (
  		[CaracteristicaServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ServicoId] INT NOT NULL,
  		[CaracteristicaId] INT NOT NULL,
		CONSTRAINT [FK_CaracteristicasServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId]),
		CONSTRAINT [FK_CaracteristicasServicos_CaracteristicaId] FOREIGN KEY([CaracteristicaId])
		REFERENCES [dbo].[Caracteristicas] ([CaracteristicaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosEmails]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadosEmails]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadosEmails] (
  		[AssociadoEmailId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[EmailId] INT NOT NULL,
		CONSTRAINT [FK_AssociadosEmails_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_AssociadosEmails_EmailId] FOREIGN KEY([EmailId])
		REFERENCES [dbo].[Emails] ([EmailId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[GarantiasProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[GarantiasProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[GarantiasProdutos] (
  		[GarantiaProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ProdutoId] INT NOT NULL,
  		[GarantiaId] INT NOT NULL,
		CONSTRAINT [FK_GarantiasProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_GarantiasProdutos_GarantiaId] FOREIGN KEY([GarantiaId])
		REFERENCES [dbo].[Garantias] ([GarantiaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[GarantiasServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[GarantiasServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[GarantiasServicos] (
  		[GarantiaServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ServicoId] INT NOT NULL,
  		[GarantiaId] INT NOT NULL,
		CONSTRAINT [FK_GarantiasServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId]),
		CONSTRAINT [FK_GarantiasServicos_GarantiaId] FOREIGN KEY([GarantiaId])
		REFERENCES [dbo].[Garantias] ([GarantiaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[ProdutosBloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ProdutosBloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ProdutosBloqueios] (
  		[ProdutosBloqueioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ProdutoId] INT NOT NULL,
  		[BloqueioId] INT NOT NULL,
		CONSTRAINT [FK_ProdutosBloqueios_BloqueioId] FOREIGN KEY([BloqueioId])
		REFERENCES [dbo].[Bloqueios] ([BloqueioId]),
		CONSTRAINT [FK_ProdutosBloqueios_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[UsuariosBloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[UsuariosBloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[UsuariosBloqueios] (
  		[UsuariosBloqueioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[UsuarioId] INT NOT NULL,
  		[BloqueioId] INT NOT NULL,
		CONSTRAINT [FK_UsuariosBloqueios_BloqueioId] FOREIGN KEY([BloqueioId])
		REFERENCES [dbo].[Bloqueios] ([BloqueioId]),
		CONSTRAINT [FK_UsuariosBloqueios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosBloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadosBloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadosBloqueios] (
  		[AssociadosBloqueioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[BloqueioId] INT NOT NULL,
		CONSTRAINT [FK_AssociadosBloqueios_BloqueioId] FOREIGN KEY([BloqueioId])
		REFERENCES [dbo].[Bloqueios] ([BloqueioId]),
		CONSTRAINT [FK_AssociadosBloqueios_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[ServicosBloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ServicosBloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ServicosBloqueios] (
  		[ServicosBloqueioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ServicoId] INT NOT NULL,
  		[BloqueioId] INT NOT NULL,
		CONSTRAINT [FK_ServicosBloqueios_BloqueioId] FOREIGN KEY([BloqueioId])
		REFERENCES [dbo].[Bloqueios] ([BloqueioId]),
		CONSTRAINT [FK_ServicosBloqueios_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[VendedoresServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[VendedoresServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[VendedoresServicos] (
  		[VendedorServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[ServicoId] INT NOT NULL,
		CONSTRAINT [FK_VendedoresServicos_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_VVendedoresServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[VendasProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[VendasProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[VendasProdutos] (
  		[VendaProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[VendaId] INT NOT NULL,
  		[ProdutoId] INT NOT NULL,
		CONSTRAINT [FK_VendasProdutos_VendaId] FOREIGN KEY([VendaId])
		REFERENCES [dbo].[Vendas] ([VendaId]),
		CONSTRAINT [FK_VendasProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[VendasServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[VendasServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[VendasServicos] (
  		[VendaServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[VendaId] INT NOT NULL,
  		[ServicoId] INT NOT NULL,
		CONSTRAINT [FK_VendasServicos_VendaId] FOREIGN KEY([VendaId])
		REFERENCES [dbo].[Vendas] ([VendaId]),
		CONSTRAINT [FK_VendasServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadosMensagens]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadosMensagens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadosMensagens] (
  		[AssociadoMensagemId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[MensagemId] BIGINT NOT NULL,
		CONSTRAINT [FK_AssociadosMensagens_MensagemId] FOREIGN KEY([MensagemId])
		REFERENCES [dbo].[Mensagens] ([MensagemId]),
		CONSTRAINT [FK_AssociadosMensagens_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[FormasPagamentosProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[FormasPagamentosProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[FormasPagamentosProdutos] (
  		[FormaPagamentoProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[FormaPagamentoId] INT NOT NULL,
  		[ProdutoId] INT NOT NULL,
		CONSTRAINT [FK_FormasPagamentosProdutos_FormaPagamentoId] FOREIGN KEY([FormaPagamentoId])
		REFERENCES [dbo].[FormasPagamentos] ([FormaPagamentoId]),
		CONSTRAINT [FK_FormasPagamentosProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[FormasPagamentosServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[FormasPagamentosServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[FormasPagamentosServicos] (
  		[FormaPagamentoServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[FormaPagamentoId] INT NOT NULL,
  		[ServicoId] INT NOT NULL,
		CONSTRAINT [FK_FormasPagamentosServicos_FormaPagamentoId] FOREIGN KEY([FormaPagamentoId])
		REFERENCES [dbo].[FormasPagamentos] ([FormaPagamentoId]),
		CONSTRAINT [FK_FormasPagamentosServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[ProdutosNotasFiscais]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ProdutosNotasFiscais]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ProdutosNotasFiscais] (
  		[ProdutoNotaFiscalId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[NotaFiscalId] INT NOT NULL,
		[ProdutoId] INT NOT NULL,
		CONSTRAINT [FK_ProdutosNotasFiscais_NotaFiscalId] FOREIGN KEY([NotaFiscalId])
		REFERENCES [dbo].[NotasFiscais] (NotaFiscalId),
		CONSTRAINT [FK_ProdutosNotasFiscais_ServicoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[ServicosNotasFiscais]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ServicosNotasFiscais]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ServicosNotasFiscais] (
  		[ServicoNotasFiscaisId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[NotaFiscalId] INT NOT NULL,
		[ServicoId] INT NOT NULL,
		CONSTRAINT [FK_ServicosNotasFiscais_NotaFiscalId] FOREIGN KEY([NotaFiscalId])
		REFERENCES [dbo].[NotasFiscais] (NotaFiscalId),
		CONSTRAINT [FK_ServicosNotasFiscais_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[EmailsServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EmailsServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EmailsServicos] (
  		[EmailServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[PrestadoraServicoId] INT NULL,
  		[EmailId] INT NOT NULL,
		[ServicoId] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_EmailsServicos_EmailId] FOREIGN KEY([EmailId])
		REFERENCES [dbo].[Emails] ([EmailId]),
		CONSTRAINT [FK_EmailsServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[EmailsServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EmailsProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EmailsProdutos] (
  		[EmailProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[PrestadoraServicoId] INT NULL,
  		[EmailId] INT NOT NULL,
		[ProdutoId] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_EmailsProdutos_EmailId] FOREIGN KEY([EmailId])
		REFERENCES [dbo].[Emails] ([EmailId]),
		CONSTRAINT [FK_EmailsProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[LotesEmailsServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[LotesEmailsServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[LotesEmailsServicos] (
		[LoteEmailServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[PrestadoraServicoId] INT NULL,
  		[LoteEmailId] INT NOT NULL,
		[ServicoId] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_LotesEmailsServicos_LoteEmailId] FOREIGN KEY([LoteEmailId])
		REFERENCES [dbo].[LotesEmails] ([LoteEmailId]),
		CONSTRAINT [FK_LotesEmailsServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[LotesEmailsProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[LotesEmailsProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[LotesEmailsProdutos] (
		[LoteEmailProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[PrestadoraServicoId] INT NULL,
  		[LoteEmailId] INT NOT NULL,
  		[ProdutoId] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_LotesEmailsProdutos_LoteEmailId] FOREIGN KEY([LoteEmailId])
		REFERENCES [dbo].[LotesEmails] ([LoteEmailId]),
		CONSTRAINT [FK_LotesEmailsProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[PrestadoresServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[PrestadoresServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[PrestadoresServicos] (
  		[PrestadorServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[ServicoId] INT NULL,
  		[AssociadoId] INT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_PrestadoresServicos_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_PrestadoresServicos_LojaId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[AssociadoLoteEmails]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AssociadoLoteEmails]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AssociadoLoteEmails] (
  		[AssociadoLoteEmailId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[LoteEmailId] INT NOT NULL,
		[AssociadoInclusaoId] INT NOT NULL,
		[AssociadoUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_AssociadoLoteEmails_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_AssociadoLoteEmails_LojaId] FOREIGN KEY([LoteEmailId])
		REFERENCES [dbo].[LotesEmails] ([LoteEmailId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[LojasAssociados]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[LojasAssociados]') IS NULL
BEGIN
	CREATE TABLE [dbo].[LojasAssociados] (
  		[LojaAssociadoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[AssociadoId] INT NOT NULL,
  		[LojaId] INT NOT NULL,
		CONSTRAINT [FK_LojasAssociados_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId]),
		CONSTRAINT [FK_LojasAssociados_LojaId] FOREIGN KEY([LojaId])
		REFERENCES [dbo].[Lojas] ([LojaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[MensagensProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[MensagensProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[MensagensProdutos] (
		[MensagemProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[MensagemId] BIGINT NOT NULL,
		[ProdutoId] INT NOT NULL,
		CONSTRAINT [FK_MensagensProdutos_MensagemId] FOREIGN KEY([MensagemId])
		REFERENCES [dbo].[Mensagens] ([MensagemId]),
		CONSTRAINT [FK_MensagensProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[MensagensServicos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[MensagensServicos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[MensagensServicos] (
		[MensagemServicoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[MensagemId] BIGINT NOT NULL,
		[ServicoId] INT NOT NULL,
		CONSTRAINT [FK_MensagensServicos_MensagemId] FOREIGN KEY([MensagemId])
		REFERENCES [dbo].[Mensagens] ([MensagemId]),
		CONSTRAINT [FK_MensagensServicos_ServicoId] FOREIGN KEY([ServicoId])
		REFERENCES [dbo].[Servicos] ([ServicoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[EnderecosAssociados]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EnderecosAssociados]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EnderecosAssociados] (
		[EnderecoAssociadoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[EnderecoId] INT NOT NULL,
		[AssociadoId] INT NOT NULL,
		CONSTRAINT [FK_EnderecosAssociados_EnderecoId] FOREIGN KEY([EnderecoId])
		REFERENCES [dbo].[Enderecos] ([EnderecoId]),
		CONSTRAINT [FK_EnderecosAssociados_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[EnderecosUsuarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EnderecosUsuarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EnderecosUsuarios] (
		[EnderecoUsuarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[EnderecoId] INT NOT NULL,
		[UsuarioId] INT NOT NULL,
		CONSTRAINT [FK_EnderecosUsuarios_EnderecoId] FOREIGN KEY([EnderecoId])
		REFERENCES [dbo].[Enderecos] ([EnderecoId]),
		CONSTRAINT [FK_EnderecosUsuarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[EnderecosAssociados]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EnderecosAssociados]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EnderecosAssociados] (
		[EnderecoAssociadoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[EnderecoId] INT NOT NULL,
		[AssociadoId] INT NOT NULL,
		CONSTRAINT [FK_EnderecosAssociados_EnderecoId] FOREIGN KEY([EnderecoId])
		REFERENCES [dbo].[Enderecos] ([EnderecoId]),
		CONSTRAINT [FK_EnderecosAssociados_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[TelefonesUsuarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TelefonesUsuarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TelefonesUsuarios](
		[TelefoneAssociadoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TelefoneId] INT NOT NULL,
		[UsuarioId] INT NOT NULL,
		CONSTRAINT [FK_TelefonesUsuarios_TelefoneId] FOREIGN KEY([TelefoneId])
		REFERENCES [dbo].[Telefones] ([TelefoneId]),
		CONSTRAINT [FK_TelefonesUsuarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[TelefonesAssociados]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TelefonesAssociados]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TelefonesAssociados](
		[TelefoneAssociadoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TelefoneId] INT NOT NULL,
		[AssociadoId] INT NOT NULL,
		CONSTRAINT [FK_TelefonesAssociados_TelefoneId] FOREIGN KEY([TelefoneId])
		REFERENCES [dbo].[Telefones] ([TelefoneId]),
		CONSTRAINT [FK_TelefonesAssociados_AssociadoId] FOREIGN KEY([AssociadoId])
		REFERENCES [dbo].[Associados] ([AssociadoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE SCHEMA log

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [log].[Logs]
-- -----------------------------------------------------
IF OBJECT_ID('[log].[Logs]') IS NULL
BEGIN
	CREATE TABLE [log].[Logs] (
		[LogId] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Message] VARCHAR(MAX) NOT NULL,
		[Request] VARCHAR(150) NOT NULL,
		[Method] VARCHAR(10) NOT NULL,
		[Response] INT,
		[UserAddedId] INT NOT NULL,
		[DateAdded] [datetime] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
--REGION STORED PROCEDURE
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Procedure [dbo].[TiposTelefonesPaginated]
-- -----------------------------------------------------

CREATE PROCEDURE [dbo].[TiposTelefonesPaginated]
		@Id INT,
		@Descricao VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT 		*
			FROM 		[TiposTelefones]
			WHERE 		([TipoTelefoneId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+'%' OR @Descricao IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[TiposDocumentosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[TiposDocumentosPaginated] 
		@Id INT,
		@Descricao VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT 		*
			FROM 		[TiposDocumentos]
			WHERE 		([TipoDocumentoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+'%' OR @Descricao IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[TiposConfiguracoesPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[TiposConfiguracoesPaginated]
		@Id INT,
		@Descricao VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT 		*
			FROM 		[TiposConfiguracoes]
			WHERE 		([TipoConfiguracaoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+'%' OR @Descricao IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[TiposLancamentosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[TiposLancamentosPaginated]
		@Id INT,
		@Descricao VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT 		*
			FROM 		[TiposLancamentos]
			WHERE 		([TipoLancamentoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+'%' OR @Descricao IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[TiposParametrosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[TiposParametrosPaginated]
		@Id INT,
		@Descricao VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT 		*
			FROM 		[TiposParametros]
			WHERE 		([TipoParametroId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+'%' OR @Descricao IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[TiposWorkFlowsPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[TiposWorkFlowsPaginated]
		@Id INT,
		@Descricao VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT 		*
			FROM 		[TiposWorkFlows]
			WHERE 		([TipoWorkFlowId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+'%' OR @Descricao IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[TipoDadosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[TipoDadosPaginated]
		@Id INT,
		@Descricao VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT 		*
			FROM 		[TiposDados]
			WHERE 		([TipoDadoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+'%' OR @Descricao IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO