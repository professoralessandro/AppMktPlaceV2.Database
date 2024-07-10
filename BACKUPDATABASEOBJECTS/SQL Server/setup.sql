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
-- Table [dbo].[StatusAprovacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[StatusAprovacoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[StatusAprovacoes] (
		[StatusAprovacaoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[Valor] VARCHAR(50) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
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
-- Table [seg].[Grupos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Grupos]') IS NULL
BEGIN
	CREATE TABLE [seg].[Grupos] (
	    [GrupoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	    [Descricao] [varchar](50) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
		[UsuarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[GrupoUsaruiId] UNIQUEIDENTIFIER,
		[Login] [varchar](50) NOT NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumentoId] INT,
		[Senha] [varchar](max) NOT NULL,
		[Nome] [varchar](100) NOT NULL,
		[DataNascimento] [datetime] NOT NULL,
		[Sexo] [varchar](1) NULL,
		[EstadoCivil] [varchar](2) NULL,
		[Email] [varchar](255) NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[DataUltimaTrocaSenha] [datetime] NOT NULL,
		[DataUltimoLogin] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Usuarios_GrupoUsaruiId] FOREIGN KEY([GrupoUsaruiId])
		REFERENCES [seg].[Grupos] ([GrupoId])
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
		[RecursoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
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
  		[GrupoRecursoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[GrupoId] UNIQUEIDENTIFIER,
		[RecursoId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_GruposRecursos_GrupoId] FOREIGN KEY([GrupoId])
		REFERENCES [seg].[Grupos] ([GrupoId]),
		CONSTRAINT [FK_TelefonesUsuarios_RecursoId] FOREIGN KEY([RecursoId])
		REFERENCES [seg].[Recursos] ([RecursoId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [seg].[Workflows]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Workflows]') IS NULL
BEGIN
	CREATE TABLE [seg].[Workflows] (
	    [WorkflowId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoWorkflowId] UNIQUEIDENTIFIER,
		[StatusAprovacaoId] UNIQUEIDENTIFIER,
	    [UsuarioResponsavel] INT NOT NULL,
		[Observacao] VARCHAR(MAX) NULL,
		[Descricao] VARCHAR(50) NULL,
		[DataWorkflowVerificacao] DATETIME NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Workflows_StatusAprovacaoId] FOREIGN KEY([StatusAprovacaoId])
		REFERENCES [dbo].[StatusAprovacoes] ([StatusAprovacaoId])
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
		[FormaPagamentoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Descricao] [varchar](50) NOT NULL,
		[PermiteParcelar] [bit] NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
		[ProdutoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoProdutoId] INT,
		[Titulo] VARCHAR(50) NOT NULL,
		[Detalhes] VARCHAR(MAX) NOT NULL,
		[ResumoDetalhes] VARCHAR(200) NOT NULL,
		[CodigoBarras] VARCHAR(30) NULL,
		[Marca] VARCHAR(30) NULL,
		[Quantidade] INT NOT NULL,
		[IsIlimitado] BIT NOT NULL,
		[QuantidadeCritica] INT NULL,
		[PrecoCusto] DECIMAL(10,2) NOT NULL,
		[PrecoVenda] DECIMAL(10,2) NOT NULL,
		[Score] DECIMAL(3,2) DEFAULT 2.00 NOT NULL,
        [Relevance] DECIMAL(3,2) DEFAULT 2.00 NOT NULL,
		[Peso] INT NULL,
		[Altura] INT NULL,
		[Largura] INT NULL,
		[Comprimento] INT NULL,
		[Bloqueado] [bit] NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
    	[CaracteristicaId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoCaracteristicaId] UNIQUEIDENTIFIER,
		[ProdutoId] UNIQUEIDENTIFIER,
    	[Descricao] VARCHAR(MAX) NOT NULL,
    	[Ordem] INT NULL,
    	[Publico] BIT NOT NULL,
    	[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Caracteristicas_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
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
  		[ImagemId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Titulo] VARCHAR(50) NULL,
		[File] VARCHAR(100) NOT NULL,
    	[Descricao] VARCHAR(MAX) NULL,
		[ImagemPrincipal] BIT NOT NULL,
		[Publico] BIT NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL
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
IF OBJECT_ID('[dbo].[ImagensProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ImagensProdutos] (
		[ImagemProdutoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[ImagemId] UNIQUEIDENTIFIER,
		[ProdutoId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_ImagensProdutos_ImagemId] FOREIGN KEY([ImagemId])
		REFERENCES [dbo].[Imagens] ([ImagemId]),
		CONSTRAINT [FK_ImagensProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
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
IF OBJECT_ID('[dbo].[ShoppingCart]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ShoppingCart] (
		[ShoppingCartId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioId] UNIQUEIDENTIFIER,
		[ProdutoId] UNIQUEIDENTIFIER,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL
		CONSTRAINT [FK_ShoppingCart_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_ShoppingCart_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
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
  		[AvaliacaoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[ProdutoId] UNIQUEIDENTIFIER,
		[VendedorId] UNIQUEIDENTIFIER,
    	[Descricao] VARCHAR(MAX) NOT NULL,
		[Valor] DECIMAL(2, 2) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
-- Table [dbo].[AvaliacoesProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AvaliacoesProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AvaliacoesProdutos] (
  		[AvaliacaoProdutoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[AvaliacaoId] UNIQUEIDENTIFIER,
		[ProdutoId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_AvaliacoesProdutos_AvaliacaoId] FOREIGN KEY([AvaliacaoId])
		REFERENCES [dbo].[Avaliacoes] ([AvaliacaoId]),
		CONSTRAINT [FK_AvaliacoesProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[AvaliacoesVendedores]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[AvaliacoesVendedores]') IS NULL
BEGIN
	CREATE TABLE [dbo].[AvaliacoesVendedores] (
  		[AvaliacaoVendedorId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[AvaliacaoId] UNIQUEIDENTIFIER,
		[VendedorId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_AvaliacoesVendedores_AvaliacaoId] FOREIGN KEY([AvaliacaoId])
		REFERENCES [dbo].[Avaliacoes] ([AvaliacaoId]),
		CONSTRAINT [FK_AvaliacoesVendedores_VendedorId] FOREIGN KEY([VendedorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
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
  		[TelefoneId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    	[TipoTelefoneId] UNIQUEIDENTIFIER,
		[Numero] VARCHAR(20) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[IsPrincipal] [bit] NOT NULL,
		[Ativo] [bit] NOT NULL
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
	CREATE TABLE [dbo].[TelefonesUsuarios] (
  		[TelefoneUsuarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TelefoneId] UNIQUEIDENTIFIER,
		[UsuarioId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_TelefonesUsuarios_TelefoneId] FOREIGN KEY([TelefoneId])
		REFERENCES [dbo].[Telefones] ([TelefoneId]),
		CONSTRAINT [FK_TelefonesUsuarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
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
  		[EnderecoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoEnderecoId] INT,
		[Logradouro] VARCHAR(50) NOT NULL,
		[Numero] VARCHAR(10) NOT NULL,
		[Complemento] VARCHAR(10) NULL,
		[Bairro] VARCHAR(30) NULL,
		[Cidade] VARCHAR(30) NOT NULL,
		[Estado] VARCHAR(2) NOT NULL,
		[CEP] VARCHAR(8) NOT NULL,
		[PontoReferencia] VARCHAR(100) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[IsPrincipal] [bit] NOT NULL,
		[Ativo] [bit] NOT NULL
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
  		[EnderecoUsuarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[EnderecoId] UNIQUEIDENTIFIER,
		[UsuarioId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_EnderecosUsuarios_EnderecoId] FOREIGN KEY([EnderecoId])
		REFERENCES [dbo].[Enderecos] ([EnderecoId]),
		CONSTRAINT [FK_EnderecosUsuarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
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
		[SituacaoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(150) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
		[LancamentoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoLancamentoId] UNIQUEIDENTIFIER,
		[SituacaoId] UNIQUEIDENTIFIER,
		[Referencia] VARCHAR(50) NOT NULL,
		[ValorLancamento] DECIMAL(10, 2) NOT NULL,
		[DataBaixa] [datetime] NULL,
		[Observacao] [varchar](max) NULL,
		[UsuarioIdBaixa] INT NULL,
		[LancamentoIdPai] INT NULL,
		[QtdeParcelas] [int] NOT NULL,
		[NmrParcela] [int] NOT NULL,
		[ValorParcela] DECIMAL(10, 2) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Lancamentos_UsuarioInclusaoId] FOREIGN KEY([UsuarioInclusaoId])
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
-- Table [dbo].[Garantias]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Garantias]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Garantias] (
  		[GarantiaId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoGarantiaId] UNIQUEIDENTIFIER,
		[Descricao] VARCHAR(50) NOT NULL,
		[Detalhes] VARCHAR(MAX) NOT NULL,
		[Periodo] VARCHAR(20)  NULL,
		[Inicio] [datetime] NULL,
		[Fim] [datetime] NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
   		[NotaFiscalId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoNotaFiscalId] UNIQUEIDENTIFIER,
		[ChaveAcesso] VARCHAR(50) NULL,
		[UsuarioId] UNIQUEIDENTIFIER,
		[DestinatarioId] UNIQUEIDENTIFIER,
		[DadosAdicionais] VARCHAR(MAX) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_NotasFiscais_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_NotasFiscais_DestinatarioId] FOREIGN KEY([DestinatarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
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
  		[EmailId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioEnvioId] UNIQUEIDENTIFIER,
		[TipoEmailId] UNIQUEIDENTIFIER,
		[NomeEmail] VARCHAR(100) NULL,
      	[Destinatario] VARCHAR(150) NOT NULL,
      	[Assunto] VARCHAR(100) NULL,
      	[Mensagem] VARCHAR(MAX) NOT NULL,
      	[Html] BIT NOT NULL,
      	[StatusEnvio] INT NOT NULL,
      	[Tentativas] INT NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Emails_UsuarioEnvioId] FOREIGN KEY([UsuarioEnvioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
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
  		[MensagemId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[RemetenteId] UNIQUEIDENTIFIER,
		[MensagemContexto] VARCHAR(MAX) NOT NULL,
		[TipoMensagemId] UNIQUEIDENTIFIER,
		[IsHtml] BIT NOT NULL,
		[DestinatarioId] UNIQUEIDENTIFIER,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
-- Table [dbo].[Entregas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Entregas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Entregas] (
  		[EntregaId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[ResponsavelEntregaId] UNIQUEIDENTIFIER,
		[TipoEntregaId] UNIQUEIDENTIFIER,
		[DataPrevistaEntrega] DATETIME NOT NULL,
		[DataEfetivaEnrega] DATETIME NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumentoId] UNIQUEIDENTIFIER,
		[NomeRecebedor] VARCHAR(100) NOT NULL,
		[isEntregueTitular] BIT NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Entregas_ResponsavelEntregaId] FOREIGN KEY([ResponsavelEntregaId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- TODO: REMOVER DAS MODEL
-- -----------------------------------------------------
-- Table [dbo].[Bloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Bloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Bloqueios] (
  		[BloqueioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoBloqueioId] INT,
		[NomeBloqueio] VARCHAR(100) NOT NULL,
		[Permanente] BIT NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInicio] [datetime] NULL,
		[DataFim] [datetime] NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Detalhes] VARCHAR(MAX) NOT NULL,
		[Ativo] [bit] NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- TODO: ALTERAR NOME NO PROJETO PARA: BloqueiosItens
-- COMMENT: THIS TABLE CAN BLOCK ANY ITEM LIKE USER, PRODUCT, SERVICE, ADRESS ETC...
-- -----------------------------------------------------
-- Table [dbo].[BloqueiosItens]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[BloqueiosItens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[BloqueiosItens] (
  		[BloqueioItemId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[BloqueioId] UNIQUEIDENTIFIER NOT NULL,
		[ItemId] UNIQUEIDENTIFIER NOT NULL,
		CONSTRAINT [FK_BloqueiosItens_BloqueioId] FOREIGN KEY([BloqueioId])
		REFERENCES [dbo].[Bloqueios] ([BloqueioId])
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
  		[DadoBancarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioId] UNIQUEIDENTIFIER,
		[Banco] VARCHAR(100) NOT NULL,
		[Agencia] VARCHAR(6) NOT NULL,
		[Conta] VARCHAR(20) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
  		[CartaoBancarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioId] UNIQUEIDENTIFIER,
		[Numero] VARCHAR(16) NOT NULL,
		[NomeNoCartao] VARCHAR(50) NOT NULL,
		[Bandeira] VARCHAR(10) NOT NULL,
		[Validade] VARCHAR(6) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[CodSeg] VARCHAR(3) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
-- Table [dbo].[Configuracoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Configuracoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Configuracoes] (
  		[ConfiguracaoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoConfiguracaoId] UNIQUEIDENTIFIER,
		[Descricao] VARCHAR(150) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL
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
		[ParametroId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoParametroId] UNIQUEIDENTIFIER,
		[TipoDadoId] UNIQUEIDENTIFIER,
	  	[Descricao] [varchar](100) NOT NULL,
	  	[Valor] [varchar](max) NOT NULL,
	  	[Publico] [bit] NOT NULL,
	  	[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
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
-- Table [dbo].[Pagamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Pagamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Pagamentos] (
  		[PagamentoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
  		[LancamentoId] UNIQUEIDENTIFIER,
		[CodigoPagamento] VARCHAR (30) NULL,
		[ChagoExterno] VARCHAR (50) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Pagamentos_LancamentoId] FOREIGN KEY([LancamentoId])
		REFERENCES [dbo].[Lancamentos] ([LancamentoId]),
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
		[ConfiguracaoParametroId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[ParametroId] UNIQUEIDENTIFIER,
		[ConfiguracaoId] UNIQUEIDENTIFIER,
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
-- Table [dbo].[Compras]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Compras]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Compras] (
  		[CompraId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[CodigoCompra] VARCHAR(20) NULL,
		[CodigoPagamento] VARCHAR(20) NULL,
  		[ProdutoId] UNIQUEIDENTIFIER,
  		[CompradorId] UNIQUEIDENTIFIER,
		[FormaPagamentoId] UNIQUEIDENTIFIER,
		[StatusCompraId] UNIQUEIDENTIFIER,
		[EntregaId] UNIQUEIDENTIFIER,
		[LancamentoPaiId] UNIQUEIDENTIFIER,
		[EnderecoId] UNIQUEIDENTIFIER,
		[GarantiaId] UNIQUEIDENTIFIER,
		[TelefoneId] UNIQUEIDENTIFIER,
		[VendedorId] UNIQUEIDENTIFIER,
		[IsPago] BIT NOT NULL,
		[IsEntregue] BIT NOT NULL,
		[IsAvaliado] BIT NOT NULL,
		[Ativo] BIT NOT NULL,
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
		REFERENCES [dbo].[Garantias] ([GarantiaId])
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
		[LogId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Message] VARCHAR(MAX) NOT NULL,
		[Request] VARCHAR(150) NOT NULL,
		[Method] VARCHAR(10) NOT NULL,
		[Response] INT,
		[UserAddedId] UNIQUEIDENTIFIER,
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
-- Table [log].[Logs]
-- -----------------------------------------------------
IF OBJECT_ID('[log].[Logs]') IS NULL
BEGIN
	CREATE TABLE [log].[Logs] (
		[LogId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Message] VARCHAR(MAX) NOT NULL,
		[Request] VARCHAR(150) NOT NULL,
		[Method] VARCHAR(10) NOT NULL,
		[Response] INT,
		[UserAddedId] UNIQUEIDENTIFIER,
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
-- REGION FUNCTION DATABASE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Function [dbo].[FNCReturnIsItemcked]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS INFORMATION ABOUT ANY ITEM LIKE ADRESS, FONE, USER, PRODUCT IF IT HAS BLOCKED BY SISTEM
	CREATE FUNCTION [dbo].[FNCReturnIsItemcked](@ItemId UNIQUEIDENTIFIER) RETURNS INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			DECLARE @IsBlocked BIT;

    		SELECT @IsBlocked = CASE 
    		    WHEN EXISTS (
    		        SELECT
						[block].[BloqueioId]
						,[block].[NomeBloqueio]
						,[block].[Permanente]
						,[block].[UsuarioInclusaoId]
						,[block].[UsuarioUltimaAlteracaoId]
						,[block].[DataInicio]
						,[block].[DataFim]
						,[block].[DataInclusao]
						,[block].[DataUltimaAlteracao]
						,[block].[Ativo]
					FROM [APDBDev].[dbo].[Bloqueios] [block]
					INNER JOIN [APDBDev].[dbo].[BloqueiosItens] [item] ON [item].[ItemId] = @ItemId
					WHERE Ativo = 1
					AND [block].[Permanente] = 0
					AND GETDATE() BETWEEN [DataInicio] AND [DataFim]
    		    ) THEN 1 
    		    ELSE 0 
    		END;
    		RETURN @IsBlocked;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- REGION FUNCTION DATABASE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- REGION STORED PROCEDURE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Procedure [dbo].[ProdutosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[ProdutosPaginated]
		@Id UNIQUEIDENTIFIER,
		@Titulo VARCHAR(50),
		@TipoProduto INT,
		@Marca VARCHAR(30),
		@CodigoBarras VARCHAR(30),
		@IsBloqueado BIT,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT,
		@UserId UNIQUEIDENTIFIER
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT
				[ProdutoId]			AS	Identifier
				,[TipoProdutoId]	AS 	ProductTypeEnum
				,[Titulo]
				,[Detalhes]
				,[CodigoBarras]
				,[Marca]
				,[Quantidade]
				,[IsIlimitado]
				,[QuantidadeCritica]
				,[PrecoCusto]
				,[PrecoVenda]
				,[Bloqueado]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM [APDBDev].[dbo].[Produtos]
			WHERE 		([ProdutoId]	=		  @Id					OR	@Id IS NULL)
			AND 		([Titulo]		LIKE '%' +@Titulo+ '%'			OR	@Titulo IS NULL)
			AND 		([TipoProdutoId] =		  @TipoProduto			OR	@TipoProduto IS NULL)
			AND 		([Marca]		LIKE '%' +@Marca+ '%'			OR	@Marca IS NULL)
			AND 		([CodigoBarras] LIKE '%' +@CodigoBarras+ '%'	OR	@CodigoBarras IS NULL)
			AND			([Bloqueado] = @IsBloqueado OR @IsBloqueado IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			AND			(([UsuarioInclusaoId] = @UserId OR [UsuarioUltimaAlteracaoId] = @UserId) OR @UserId IS NULL)
			ORDER BY [Score], [ProdutoId] DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[StoreProductPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 05/17/2024
	-- THIS PROCEDURE RETURNS TABLE PRODUTOS FOR STORE PAGINATED
	CREATE PROCEDURE [dbo].[StoreProductPaginated]
		@Param VARCHAR(MAX),
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier],
				[T].[ProductTypeEnum],
				[T].[MainImage],
				[T].[Titulo],
				[T].[ResumoDetalhes],
				[T].[Detalhes],
				[T].[CodigoBarras],
				[T].[Marca],
				[T].[Quantidade],
				[T].[PrecoVenda]
			FROM (
				SELECT
					[Prd].[ProdutoId]			AS	Identifier
					,[Prd].[TipoProdutoId]		AS 	ProductTypeEnum
					,[Img].[File]				AS 	[MainImage]
					,[dbo].[FNCReturnIsItemcked]([Prd].[ProdutoId]) AS Blocked
					,[Prd].[Titulo]
					,[Prd].[ResumoDetalhes]
					,[Prd].[Detalhes]
					,[Prd].[CodigoBarras]
					,[Prd].[Marca]
					,[Prd].[Quantidade]
					,[Prd].[PrecoVenda]
				FROM [APDBDev].[dbo].[Produtos] [Prd]
				LEFT JOIN [APDBDev].[dbo].[ImagensProdutos] [PrdImg] ON [PrdImg].[ProdutoId] = [Prd].[ProdutoId]
				LEFT JOIN [APDBDev].[dbo].[Imagens] [Img] ON [PrdImg].[ImagemId] = [Img].[ImagemId] AND [Img].[ImagemPrincipal] = 1
				WHERE 		(LOWER(CONVERT(VARCHAR(50),[Prd].[ProdutoId]))			  =			LOWER(CONVERT(VARCHAR(50),@Param))					OR	@Param IS NULL)
				OR 			([Prd].[Titulo]											LIKE 		'%' + @Param + '%'									OR	@Param IS NULL)
				OR 			([Prd].[Marca]											LIKE 		'%' + @Param + '%'									OR	@Param IS NULL)
				OR 			([Prd].[CodigoBarras] 									LIKE 		'%' + @Param + '%'									OR	@Param IS NULL)
				OR			(LOWER(CONVERT(VARCHAR(50),[Prd].[PrecoVenda]))            =		LOWER(CONVERT(VARCHAR(50),@Param))  				OR	@Param IS NULL)
				AND [Prd].[Ativo] = 1
				AND [Prd].[Bloqueado] = 0
				ORDER BY [Prd].[Relevance] DESC, [Prd].[Score] DESC, [Prd].[DataInclusao] DESC, [Prd].[DataUltimaAlteracao] DESC
				OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT @RowspPage ROWS ONLY) [T]
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[AdressPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 05/17/2024
	-- THIS PROCEDURE RETURNS TABLE ADRESS FOR STORE PAGINATED THAT HAS NOT BLOCKED
	-- TODO: ATRIBUTE @Usuario NOT WORKING, TECNICAL DEBIT
	CREATE PROCEDURE [dbo].[AdressPaginated]
		@Id UNIQUEIDENTIFIER,
		@UserId UNIQUEIDENTIFIER,
		@Usuario VARCHAR(250),
		@TipoEndereco INT,
		@Logradouro VARCHAR(50),
		@IsPrincipal BIT,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier]
      			,[T].[AddressTypeEnum]
				,[T].[UsuarioId]
      			,[T].[Logradouro]
      			,[T].[Numero]
      			,[T].[Complemento]
      			,[T].[Bairro]
      			,[T].[Cidade]
      			,[T].[Estado]
      			,[T].[CEP]
      			,[T].[PontoReferencia]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[IsPrincipal]
      			,[T].[Ativo]
			FROM (
				SELECT
					[end].[EnderecoId]			AS	Identifier
      				,[end].[TipoEnderecoId]		AS 	AddressTypeEnum
					,[dbo].[FNCReturnIsItemcked]([end].[EnderecoId]) AS Blocked
					,[usu].[UsuarioId]
      				,[end].[Logradouro]
      				,[end].[Numero]
      				,[end].[Complemento]
      				,[end].[Bairro]
      				,[end].[Cidade]
      				,[end].[Estado]
      				,[end].[CEP]
      				,[end].[PontoReferencia]
      				,[end].[UsuarioInclusaoId]
      				,[end].[UsuarioUltimaAlteracaoId]
      				,[end].[DataInclusao]
      				,[end].[DataUltimaAlteracao]
      				,[end].[IsPrincipal]
      				,[end].[Ativo]
				FROM [APDBDev].[dbo].[Enderecos] [end]
				INNER JOIN [APDBDev].[dbo].[EnderecosUsuarios] [endusu]		ON [endusu].[EnderecoId] = [end].[EnderecoId]
				INNER JOIN [APDBDev].[seg].[Usuarios] [usu] 				ON [usu].[UsuarioId]	 = [endusu].[UsuarioId]
				WHERE 		([end].[EnderecoId]		=		  		@Id					OR	@Id 			IS NULL)
				AND 		([usu].[UsuarioId]		=		  		@UserId				OR	@UserId 		IS NULL)
				AND			([usu].[Login]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
				AND 		([usu].[NmrDocumento]	LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
				AND 		([usu].[Nome]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
				AND 		([usu].[Email]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
				AND 		([end].[TipoEnderecoId]	 =		  	@TipoEndereco			OR	@TipoEndereco	IS NULL)
				AND 		([end].[Logradouro]		LIKE 	'%' +@Logradouro+ '%'		OR	@Usuario 		IS NULL)
				AND 		([end].[IsPrincipal] 	 =		  	@IsPrincipal			OR	@IsPrincipal 	IS NULL)
				AND			([end].[Ativo] 			 = 			@Ativo 					OR	@Ativo 			IS NULL)
				AND [usu].[Bloqueado] = 0
				ORDER BY [end].[Logradouro] DESC, [end].[DataInclusao] DESC, [end].[DataUltimaAlteracao] DESC
				OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT @RowspPage ROWS ONLY) [T]
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [seg].[ReturnUsersIsASystemAdmin]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [seg].[ReturnUsersIsASystemAdmin]
		@UserId UNIQUEIDENTIFIER
	AS
		BEGIN
			-- ATRIB TESTE PROC
			DECLARE @IsAdmin BIT;

    		SELECT @IsAdmin = CASE 
    		    WHEN EXISTS (
    		        SELECT 1 FROM seg.Usuarios us
					WHERE us.GrupoUsaruiId = (SELECT TOP 1 gp.GrupoId FROM seg.Grupos gp WHERE gp.Descricao = 'Master')
					AND us.UsuarioId = @UserId
    		    ) THEN 1 
    		    ELSE 0 
    		END;

    		SELECT @IsAdmin AS IsSystemAdmin;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnShoppingCartStore]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[ReturnShoppingCartStore]
		@UserId UNIQUEIDENTIFIER,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT
				[ShoppingCartId]			AS		Identifier
      			,[UsuarioId]
      			,[ProdutoId]
 			FROM [APDBDev].[dbo].[ShoppingCart]
			WHERE [UsuarioId] = @UserId 
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
-- Procedure [dbo].[ReturnIsItemcked]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS INFORMATION ABOUT ANY ITEM LIKE ADRESS, FONE, USER, PRODUCT IF IT HAS BLOCKED BY SISTEM
	CREATE PROCEDURE [dbo].[ReturnIsItemcked]
		@ItemId UNIQUEIDENTIFIER
	AS
		BEGIN
			-- ATRIB TESTE PROC
			DECLARE @IsBlocked BIT;

    		SELECT @IsBlocked = CASE 
    		    WHEN EXISTS (
    		        SELECT
						[block].[BloqueioId]
						,[block].[NomeBloqueio]
						,[block].[Permanente]
						,[block].[UsuarioInclusaoId]
						,[block].[UsuarioUltimaAlteracaoId]
						,[block].[DataInicio]
						,[block].[DataFim]
						,[block].[DataInclusao]
						,[block].[DataUltimaAlteracao]
						,[block].[Ativo]
					FROM [APDBDev].[dbo].[Bloqueios] [block]
					INNER JOIN [APDBDev].[dbo].[BloqueiosItens] [item] ON [item].[ItemId] = @ItemId
					WHERE Ativo = 1
					AND [block].[Permanente] = 0
					AND GETDATE() BETWEEN [DataInicio] AND [DataFim]
    		    ) THEN 1 
    		    ELSE 0 
    		END;
    		SELECT @IsBlocked AS IsItemBlocked;
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
-- Feed table [seg].[Grupos]
-- -----------------------------------------------------

INSERT INTO [seg].[Grupos] ([GrupoId], [Descricao], [DataInclusao], [DataUltimaAlteracao], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [Ativo])
VALUES('59647e61-db07-4b43-993d-3f7eda18fe7f', 'System', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1),
('cb4ba730-222c-4b05-bb56-c2fec255bd9d', 'Master', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[Usuarios]
-- -----------------------------------------------------

INSERT INTO [seg].[Usuarios]([UsuarioId], [Login], [GrupoUsaruiId], [NmrDocumento], [TipoDocumentoId], [Senha], [Nome], [DataNascimento], [Sexo], [EstadoCivil], [Email], [Bloqueado], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [DataInclusao], [DataUltimaAlteracao], [DataUltimaTrocaSenha], [DataUltimoLogin], [Ativo])
VALUES ('9a5f0c64-8103-4ee1-8acd-84b28090d898', 'System', '59647e61-db07-4b43-993d-3f7eda18fe7f', '00000000000', 1, '$@#$@#$FWSDWERFSSDFSDFF%Dss==', 'System', GETDATE(), 'N', 'N', 'system@appmkt.com.br', 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1),
('d2a833de-5bb4-4931-a3c2-133c8994072a', 'Master', 'cb4ba730-222c-4b05-bb56-c2fec255bd9d', '00000000000', 1, '@M45ter', 'Master', GETDATE(), 'N', 'N', 'system@appmkt.com.br', 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [dbo].[Produtos]
-- -----------------------------------------------------

INSERT INTO APDBDev.dbo.Produtos
(ProdutoId, TipoProdutoId, Titulo, Detalhes, ResumoDetalhes, CodigoBarras, Marca, Quantidade, IsIlimitado, QuantidadeCritica, PrecoCusto, PrecoVenda, Score, Relevance, Peso, Altura, Largura, Comprimento, Bloqueado, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInclusao, DataUltimaAlteracao, Ativo)
VALUES(N'BB27FD71-648F-4F70-E4A4-08DC7681957E', 0, 'Cesta de chocolates personalizada', 'Cesta de chocolates personalizada', 'Cesta de chocolates personalizada com diversos chocolates, chocotone.', N'', N'', 120, 0, 10, 150.01, 205.50, 4.90, 4.95, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1);

-- -----------------------------------------------------
-- Feed table [dbo].[Imagens]
-- -----------------------------------------------------

INSERT INTO APDBDev.dbo.Imagens
(ImagemId, Titulo, [File], Descricao, ImagemPrincipal, Publico, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInclusao, DataUltimaAlteracao)
VALUES('707820bb-e1f7-4c1c-86b0-15ed01d84f91', 'Imagem Teste 1', './assets/img/test/d90029fa-c1fc-4310-9913-4c64b57498c8.jpeg', 'Imagem Teste 1', 1, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE());

-- -----------------------------------------------------
-- Feed table [dbo].[ImagensProdutos]
-- -----------------------------------------------------

INSERT INTO APDBDev.dbo.ImagensProdutos
(ImagemProdutoId, ImagemId, ProdutoId)
VALUES('9c6cb1ac-2834-4a84-86aa-f40ef62dd072', '707820bb-e1f7-4c1c-86b0-15ed01d84f91', N'BB27FD71-648F-4F70-E4A4-08DC7681957E');

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