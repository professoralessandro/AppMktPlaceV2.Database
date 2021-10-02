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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
-- Table [dbo].[TiposDocumentos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[TiposUsuarios]') IS NULL
BEGIN
	CREATE TABLE [seg].[TiposUsuarios] (
		[TipoUsuarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
-- Table [dbo].[TiposDocumentos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[TiposProdutos]') IS NULL
BEGIN
	CREATE TABLE [seg].[TiposProdutos] (
		[TipoProdutoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[GrupoId] INT NOT NULL,
		[RecursoId] INT NOT NULL,
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
-- Table [seg].[GruposRecursos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[GruposUsuarios]') IS NULL
BEGIN
	CREATE TABLE [seg].[GruposUsuarios] (
		[GrupoUsuarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[GrupoId] INT NOT NULL,
		[UsuarioId] INT NOT NULL,
		CONSTRAINT [FK_GruposUsuarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_GruposUsuarios_GrupoId] FOREIGN KEY([GrupoId])
		REFERENCES [seg].[Grupos] ([GrupoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [seg].[WorkFlows]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[WorkFlows]') IS NULL
BEGIN
	CREATE TABLE [seg].[WorkFlows] (
	    [WorkFlowId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TipoWorkflowId] INT NOT NULL,
		[StatusAprovacaoId] INT NOT NULL,
	    [UsuarioResponsavel] INT NOT NULL,
		[DataWorkFlow] DATETIME NOT NULL,
		[Observacao] VARCHAR(MAX) NULL,
		[DataWorkFlowVerificacao] DATETIME NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_WorkFlows_StatusAprovacaoId] FOREIGN KEY([StatusAprovacaoId])
		REFERENCES [dbo].[StatusAprovacoes] ([StatusAprovacaoId]),
		CONSTRAINT [FK_WorkFlows_TipoWorkflowId] FOREIGN KEY([TipoWorkflowId])
		REFERENCES [dbo].[TiposWorkFlows] ([TipoWorkflowId])
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[TipoProdutoId] INT NOT NULL,
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Produtos_ProdutoId] FOREIGN KEY([TipoProdutoId])
		REFERENCES [seg].[TiposProdutos] ([TipoProdutoId])
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
IF OBJECT_ID('[dbo].[TiposCaracteristicas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposCaracteristicas] (
  		[TipoCaracteristicaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[TipoCaracteristicaId] INT NOT NULL,
    	[Descricao] VARCHAR(MAX) NOT NULL,
    	[Ordem] INT NULL,
    	[Publico] BIT NOT NULL,
    	[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Caracteristicas_TipoCaracteristicaId] FOREIGN KEY([TipoCaracteristicaId])
		REFERENCES [dbo].[TiposCaracteristicas] ([TipoCaracteristicaId])
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[ProdutoId] INT NOT NULL,
		[VendedorId] INT NOT NULL,
    	[Descricao] VARCHAR(MAX) NOT NULL,
		[Valor] DECIMAL(10, 2) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Avaliacoes_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_Avaliacoes_VendedorId] FOREIGN KEY([VendedorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Telefones_TipoTelefoneId] FOREIGN KEY([TipoTelefoneId])
		REFERENCES [dbo].[TiposTelefones] ([TipoTelefoneId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[TiposEnderecos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposEnderecos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposEnderecos] (
		[TipoEnderecoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
-- Table [dbo].[Enderecos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Enderecos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Enderecos] (
  		[EnderecoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TipoEnderecoId] INT NOT NULL,
		[Logradouro] VARCHAR(100) NOT NULL,
		[Numero] VARCHAR(10) NULL,
		[Complemento] VARCHAR(10) NULL,
		[Bairro] VARCHAR(50) NULL,
		[Cidade] VARCHAR(50) NULL,
		[Estado] VARCHAR(50) NULL,
		[CEP] VARCHAR(10) NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Enderecos_TipoEnderecoId] FOREIGN KEY([TipoEnderecoId])
		REFERENCES [dbo].[TiposEnderecos] ([TipoEnderecoId])
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
  		[UsuarioId] INT NOT NULL,
  		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Vendas_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[TipoLancamentoId] INT NOT NULL,
		[UsuarioId] INT NOT NULL,
		[SituacaoId] INT NOT NULL,
		[Referencia] VARCHAR(150) NULL,
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
		CONSTRAINT [FK_Lancamentos_TipoLancamentoId] FOREIGN KEY([TipoLancamentoId])
		REFERENCES [dbo].[TiposLancamentos] ([TipoLancamentoId]),
		CONSTRAINT [FK_Lancamentos_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
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
-- Table [dbo].[TiposParametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposGarantias]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposGarantias] (
		[TipoGarantiaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] [varchar](100) NOT NULL,
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
-- Table [dbo].[Garantias]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Garantias]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Garantias] (
  		[GarantiaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TipoGarantiaId] INT NOT NULL,
		[Descricao] VARCHAR(150) NOT NULL,
		[PrecoVenda] DECIMAL(10,2) NOT NULL,
		[Bloqueado] BIT NOT NULL,
		[Periodo] [datetime] NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Garantias_GarantiaId] FOREIGN KEY([TipoGarantiaId])
		REFERENCES [dbo].[TiposGarantias] ([TipoGarantiaId])
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
IF OBJECT_ID('[dbo].[TiposNotasFiscais]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposNotasFiscais] (
		[TipoNotaFiscalId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] [varchar](100) NOT NULL,
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
-- Table [dbo].[NotasFiscais]
-- NOTAS FISCAIS SERA IMPLEMENTADO POSTERIORMENTE
-- -----------------------------------------------------
 IF OBJECT_ID('[dbo].[NotasFiscais]') IS NULL
 BEGIN
 	CREATE TABLE [dbo].[NotasFiscais] (
   		[NotaFiscalId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TipoNotaFiscalId] INT NOT NULL,
		CONSTRAINT [FK_NotasFiscais_TipoNotaFiscalId] FOREIGN KEY([TipoNotaFiscalId])
		REFERENCES [dbo].[TiposNotasFiscais] ([TipoNotaFiscalId])
   	)
 END
 GO
 SET ANSI_NULLS ON
 GO
 SET QUOTED_IDENTIFIER ON
 GO

-- -----------------------------------------------------
-- Table [dbo].[TiposEmails]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposEmails]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposEmails] (
		[TipoEmailId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
-- Table [dbo].[Emails]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Emails]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Emails] (
  		[EmailId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[UsuarioEnvioId] INT NOT NULL,
		[TipoEmailId] INT NOT NULL,
		[NomeEmail] VARCHAR(100) NULL,
      	[Destinatario] VARCHAR(150) NOT NULL,
      	[Assunto] VARCHAR(100) NULL,
      	[Mensagem] VARCHAR(150) NOT NULL,
      	[Html] BIT NOT NULL,
      	[Enviado] BIT NOT NULL,
      	[Tentativas] INT NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Emails_UsuarioEnvioId] FOREIGN KEY([UsuarioEnvioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_Emails_TipoEmailId] FOREIGN KEY([TipoEmailId])
		REFERENCES [dbo].[TiposEmails] ([TipoEmailId])
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
		[RemetenteId] INT NOT NULL,
		[Mensagem] VARCHAR(MAX) NOT NULL,
		[TipoMensagemId] INT NOT NULL,
		[IsHtml] BIT NOT NULL,
		[DestinatarioId] INT NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Mensagens_RemetenteId] FOREIGN KEY([RemetenteId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[TiposEntregas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposEntregas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposEntregas] (
		[TipoEntregaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
-- Table [dbo].[Entregas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Entregas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Entregas] (
  		[EntregaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[ResponsavelEntregaId] INT NOT NULL,
		[TipoEntregaId] INT NOT NULL,
		[DataPrevistaEntrega] DATETIME NOT NULL,
		[DataEfetivaEnrega] DATETIME NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumentoId] INT NOT NULL,
		[NomeRecebedor] VARCHAR(200) NOT NULL,
		[isEntregueTitular] BIT NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL
		CONSTRAINT [FK_Entregas_ResponsavelEntregaId] FOREIGN KEY([ResponsavelEntregaId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_Entregas_TipoEntregaId] FOREIGN KEY([TipoEntregaId])
		REFERENCES [dbo].[TiposEntregas] ([TipoEntregaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[TiposBloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TiposBloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TiposBloqueios] (
		[TipoBloqueioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Descricao] [varchar](100) NOT NULL,
	  	[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
-- Table [dbo].[Bloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Bloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Bloqueios] (
  		[BloqueioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TipoBloqueioId] INT NOT NULL,
		[ItemBloqueadoId] INT NOT NULL,
		[NomeBloqueio] VARCHAR(100) NOT NULL,
		[isBloqueiaAcesso] BIT NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInicio] [datetime] NULL,
		[DataFim] [datetime] NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Bloqueios_TipoBloqueioId] FOREIGN KEY([TipoBloqueioId])
		REFERENCES [dbo].[TiposBloqueios] ([TipoBloqueioId]),
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
-- Table [dbo].[DadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[DadosBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[DadosBancarios] (
  		[DadoBancarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[UsuarioId] INT NOT NULL,
		[Banco] VARCHAR(100) NOT NULL,
		[Agencia] VARCHAR(6) NOT NULL,
		[Conta] VARCHAR(20) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_DadosBancarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
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
		[UsuarioId] INT NOT NULL,
		[Numero] VARCHAR(16) NOT NULL,
		[NomeNoCartao] VARCHAR(50) NOT NULL,
		[Bandeira] VARCHAR(10) NOT NULL,
		[Validade] VARCHAR(6) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[CodSeg] VARCHAR(3) NOT NULL,
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NOT NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_CartoesBancarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
		[UsuarioInclusaoId] INT NOT NULL,
		[UsuarioUltimaAlteracaoId] INT NOT NULL,
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
-- Table [dbo].[UsuariosLancamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[UsuariosLancamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[UsuariosLancamentos] (
  		[UsuarioLancamentoId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[LancamentoId] INT NOT NULL,
		[UsuarioId] INT NOT NULL,
		CONSTRAINT [FK_UsuariosLancamentos_LancamentoId] FOREIGN KEY([LancamentoId])
		REFERENCES [dbo].[Lancamentos] ([LancamentoId]),
		CONSTRAINT [FK_UsuariosLancamentos_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[UsuariosDadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[UsuariosDadosBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[UsuariosDadosBancarios] (
  		[UsuarioDadoBancarioId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  		[UsuarioId] INT NOT NULL,
  		[DadoBancarioId] INT NOT NULL,
		CONSTRAINT [FK_UsuariosDadosBancarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_UsuariosDadosBancarios_DadoBancarioId] FOREIGN KEY([DadoBancarioId])
		REFERENCES [dbo].[DadoSBancarios] ([DadoBancarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Compras]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Compras]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Compras] (
  		[CompraId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[CodigoCompra] VARCHAR(20) NOT NULL,
  		[ProdutoId] INT NOT NULL,
  		[CompradorId] INT NOT NULL,
		[FormaPagamentoId] INT NOT NULL,
		[StatusCompraId] INT NOT NULL,
		[EntregaId] INT NOT NULL,
		[LancamentoPaiId] INT NOT NULL,
		[EnderecoId] INT NOT NULL,
		[GarantiaId] INT NOT NULL,
		[TelefoneId] INT NOT NULL,
		[VendedorId] INT NOT NULL,
		[AvaliacaoId] INT NOT NULL,
		[isPago] BIT NOT NULL,
		[isEntregue] BIT NOT NULL,
		[isAvaliado] BIT NOT NULL,
		CONSTRAINT [FK_Compras_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_Compras_CompradorId] FOREIGN KEY([CompradorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_Compras_FormaPagamentoId] FOREIGN KEY([FormaPagamentoId])
		REFERENCES [dbo].[FormasPagamentos] ([FormaPagamentoId]),
		CONSTRAINT [FK_Compras_StatusCompraId] FOREIGN KEY([StatusCompraId])
		REFERENCES [dbo].[Situacoes] ([SituacaoId]),
		CONSTRAINT [FK_Compras_EntregaId] FOREIGN KEY([EntregaId])
		REFERENCES [dbo].[Entregas] ([EntregaId]),
		CONSTRAINT [FK_Compras_LancamentoPaiId] FOREIGN KEY([LancamentoPaiId])
		REFERENCES [dbo].[Lancamentos] ([LancamentoId]),
		CONSTRAINT [FK_Compras_EnderecoId] FOREIGN KEY([EnderecoId])
		REFERENCES [dbo].[Enderecos] ([EnderecoId]),
		CONSTRAINT [FK_Compras_GarantiaId] FOREIGN KEY([GarantiaId])
		REFERENCES [dbo].[Garantias] ([GarantiaId]),
		CONSTRAINT [FK_Compras_AvaliacaoId] FOREIGN KEY([AvaliacaoId])
		REFERENCES [dbo].[Avaliacoes] ([AvaliacaoId])
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
		CONSTRAINT [FK_Logs_UserAddedId] FOREIGN KEY([UserAddedId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- REGION STORED PROCEDURE
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

			SELECT
				[TipoTelefoneId]
				,[Descricao]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM 		[TiposTelefones]
			WHERE 		([TipoTelefoneId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%' +@Descricao+ '%' OR @Descricao IS NULL)
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

			SELECT
				[TipoDocumentoId]
				,[Descricao]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM 		[TiposDocumentos]
			WHERE 		([TipoDocumentoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%' +@Descricao+ '%' OR @Descricao IS NULL)
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

			SELECT
				[TipoConfiguracaoId]
				,[Descricao]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM 		[TiposConfiguracoes]
			WHERE 		([TipoConfiguracaoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%' +@Descricao+ '%' OR @Descricao IS NULL)
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

			SELECT
				[TipoLancamentoId]
				,[Descricao]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM 		[TiposLancamentos]
			WHERE 		([TipoLancamentoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+ '%' OR @Descricao IS NULL)
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

			SELECT
				[TipoParametroId]
				,[Descricao]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM 		[TiposParametros]
			WHERE 		([TipoParametroId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%'+@Descricao+ '%' OR @Descricao IS NULL)
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

			SELECT
				[TipoWorkFlowId]
				,[Descricao]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM 		[TiposWorkFlows]
			WHERE 		([TipoWorkFlowId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%' +@Descricao+ '%' OR @Descricao IS NULL)
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
	CREATE PROCEDURE [dbo].[TiposDadosPaginated]
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

			SELECT
				[TipoDadoId]
				,[Descricao]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM 		[TiposDados]
			WHERE 		([TipoDadoId] = @Id OR @Id IS NULL)
			AND 		([Descricao] LIKE '%' +@Descricao+ '%' OR @Descricao IS NULL)
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
-- Procedure [log].[LogsPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [log].[LogsPaginated]
		@Param VARCHAR(MAX),
		@DateAdded DATETIME,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @DateAdded = NULL
			-- SET @Param = 'POST'
			-- SET @PageNumber = 1
			-- SET @RowspPage = 5
			SELECT
				[LogId]
				,[Message]
				,[Request]
				,[Method]
				,[Response]
				,[UserAddedId]
				,[DateAdded]
			FROM 		[log].[Logs]
			WHERE 
					(LOWER(CONVERT(VARCHAR(50), [LogId])) = LOWER(CONVERT(VARCHAR(50), @Param))			OR		@Param IS NULL)
			OR 		(LOWER([Message])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
			OR 		(LOWER([Method])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
			OR 		(LOWER([Request])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
			OR 		(LOWER(CONVERT(VARCHAR(50), [Response])) = LOWER(CONVERT(VARCHAR(50), @Param))		OR		@Param IS NULL)
			OR 		(LOWER(CONVERT(VARCHAR(50), [UserAddedId])) = LOWER(CONVERT(VARCHAR(50), @Param))	OR		@Param IS NULL)
			AND		([DateAdded] >= @DateAdded															OR		@DateAdded IS NULL)
			ORDER BY	1 DESC
			OFFSET		((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT	@RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- REGION SEED DATABASE
-- -----------------------------------------------------
-- This regions will feed the inicial information that system needs to woks

-- -----------------------------------------------------
-- Feed table [dbo].[TiposDocumentos]
-- -----------------------------------------------------

INSERT INTO TiposDocumentos([Descricao], [DataInclusao], [DataUltimaAlteracao], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [Ativo])
VALUES('RG', GETDATE(), GETDATE(), 1, 1, 1),
('CPF', GETDATE(), GETDATE(), 1, 1, 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[Grupos]
-- -----------------------------------------------------

INSERT INTO [seg].[Grupos] ([Grupo], [DataInclusao], [DataUltimaAlteracao], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [Ativo])
VALUES('System', GETDATE(), GETDATE(), 1, 1, 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[Usuarios]
-- -----------------------------------------------------

INSERT INTO [seg].[Usuarios]([Usuario], [NmrDocumento], [TipoDocumentoId], [Senha], [Nome], [DataNascimento], [Sexo], [EstadoCivil], [Email], [TrocaSenha], [Bloqueado], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [DataInclusao], [DataUltimaAlteracao], [DataUltimaTrocaSenha], [DataUltimoLogin], [Ativo])
VALUES ('System', '00000000000', 1, 'SENHASECRETA', 'System', GETDATE(), 'N', 'N', 'system@appmkt.com.br', 0, 1, 1, 1, GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[GruposUsuarios]
-- -----------------------------------------------------

INSERT INTO [seg].[GruposUsuarios] ([GrupoId], [UsuarioId])
VALUES(1, 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- DROPDATABASE AREA
-- -----------------------------------------------------
--USE MASTER
--GO
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO

--DROP DATABASE APDBDev
--GO
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO