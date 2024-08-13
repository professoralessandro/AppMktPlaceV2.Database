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
		[NmrDocumento] VARCHAR(30) NOT NULL,
		[NmrTelefone] VARCHAR(30) NULL,
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
		[DataUltimaTrocaSenha] [datetime] NULL,
		[DataUltimoLogin] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		[TrocaSenha] [bit] NOT NULL DEFAULT 0,
		[Token] nvarchar(MAX) COLLATE Latin1_General_CI_AS NULL,
		[RefreshToken] nvarchar(100) COLLATE Latin1_General_CI_AS NULL,
		[RefreshTokenExpiryTime] [datetime] NULL,
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
		[RecursoIdPai] [int] UNIQUEIDENTIFIER NULL,
		[Ordem] [int] NULL,
		[Ativo] [bit] NOT NULL,
		[Type] [varchar](100) NULL,
		[Icon] [varchar](100) NULL,
		[Path] [varchar](100) NULL, -- ANTIGO MENU CLASS
		[IsSubMenu] [bit] NOT NULL	
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
		CONSTRAINT [FK_GruposRecursos_RecursoId] FOREIGN KEY([RecursoId])
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
		[TipoWorkflowId] INT NOT NULL,
		[StatusAprovacaoId] INT NOT NULL,
	    [UsuarioResponsavel] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioResponsavelAprovacao] UNIQUEIDENTIFIER NULL,
		[Observacao] VARCHAR(MAX) NULL,
		[Descricao] VARCHAR(50) NULL,
		[DataWorkflowVerificacao] DATETIME NULL,
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
		[VendedorId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Produtos_VendedorId] FOREIGN KEY([VendedorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
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
-- Table [dbo].[Lancamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Lancamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Lancamentos] (
		[LancamentoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoLancamento] INT NOT NULL,
		[Status] INT NOT NULL,
		[Referencia] VARCHAR(50) NULL,
		[NroAutorizacao] VARCHAR(50) NULL,
		[NroAutorizacao] VARCHAR(50) NULL,
		[CodExternoAutorizacao] VARCHAR(50) NULL,
		[DataBaixa] [datetime] NULL,
		[Observacao] [varchar](max) NULL,
		[UsuarioIdBaixa] UNIQUEIDENTIFIER NULL,
		[LancamentoIdPai] UNIQUEIDENTIFIER NULL,
		[QtdeParcelas] [int] NULL,
		[NmrParcela] [int] NULL,
		[ValorParcela] DECIMAL(10,2) NULL,
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
-- Table [dbo].[Garantias]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Garantias]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Garantias] (
  		[GarantiaId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoGarantia] INT,
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
		[TipoEmailId] INT NOT NULL,
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
		[TipoMensagemId] INT NOT NULL,
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
		[TipoEntrega] INT NOT NULL,
		[DataPrevistaEntrega] DATETIME NULL,
		[DataEfetivaEnrega] DATETIME NULL,
		[Status] INT NOT NULL,
		[ValorTotal] DECIMAL(10, 2) NOT NULL,
		[NmrDocumento] VARCHAR(50) NULL,
		[CodigoRastramento] VARCHAR(30) NULL,
		[TipoDocumento] INT NULL,
		[NomeRecebedor] VARCHAR(100) NULL,
		[IsEntregueTitular] BIT NULL,
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
		[TipoParametroId] INT,
		[TipoDadoId] INT,
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
		[CodigoCompra] VARCHAR(30) NULL,
		[CodigoExternoCompra] VARCHAR(50) NULL,
		[LinkExternoPagamento] VARCHAR(244) NULL,
		[Contador] BIGINT IDENTITY(1,1) NOT NULL,
  		[CompradorId] UNIQUEIDENTIFIER NOT NULL,
		[FormaPagamento] INT NOT NULL,
		[Status] INT NOT NULL,
		[EntregaId] UNIQUEIDENTIFIER,
		[LancamentoPaiId] UNIQUEIDENTIFIER NOT NULL,
		[GarantiaId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] BIT NOT NULL,
		CONSTRAINT [FK_Compras_CompradorId] FOREIGN KEY([CompradorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_Compras_EntregaId] FOREIGN KEY([EntregaId])
		REFERENCES [dbo].[Entregas] ([EntregaId]),
		CONSTRAINT [FK_Compras_LancamentoPaiId] FOREIGN KEY([LancamentoPaiId])
		REFERENCES [dbo].[Lancamentos] ([LancamentoId]),
		CONSTRAINT [FK_Compras_GarantiaId] FOREIGN KEY([GarantiaId])
		REFERENCES [dbo].[Garantias] ([GarantiaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[ComprasProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ComprasProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ComprasProdutos] (
		[CompraProdutoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[CompraId] UNIQUEIDENTIFIER NOT NULL,
		[Quantidade] INT NOT NULL,
		[ProdutoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] BIT NOT NULL,
		CONSTRAINT [FK_ComprasProdutos_CompraId] FOREIGN KEY([CompraId])
		REFERENCES [dbo].[Compras] ([CompraId]),
		CONSTRAINT [FK_ComprasProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
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
		[ItemId] UNIQUEIDENTIFIER,
    	[Comentario] VARCHAR(MAX) NOT NULL,
		[Valor] DECIMAL(2, 2) NOT NULL,
		[AvaliadorId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Avaliacoes_AvaliadorId] FOREIGN KEY([AvaliadorId])
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
	-- THIS FUNCTION RETURNS INFORMATION ABOUT ANY ITEM LIKE ADRESS, FONE, USER, PRODUCT IF IT HAS BLOCKED BY SISTEM
	CREATE FUNCTION [dbo].[FNCReturnIsItemcked] (@ItemId UNIQUEIDENTIFIER) RETURNS INT
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
-- Function [seg].[ReturnUsersIsASystemAdmin]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- -- THIS FUNCTION RETURNS INFORMATION ABOUT ANY THE USER AI BELONG TO A SYSTEM ADMIN
	CREATE FUNCTION [seg].[FNCReturnUsersIsASystemAdmin] (@UserId UNIQUEIDENTIFIER) RETURNS BIT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			DECLARE @IsAdmin BIT;

    		SELECT @IsAdmin = CASE 
    		    WHEN EXISTS (
    		        SELECT 1 FROM seg.Usuarios us
					WHERE us.GrupoId = (SELECT TOP 1 gp.GrupoId FROM seg.Grupos gp WHERE gp.Descricao = 'Master')
					AND us.UsuarioId = @UserId
    		    ) THEN 1 
    		    ELSE 0 
    		END;

    		RETURN @IsAdmin;
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
	-- THIS PROCEDURE RETURNS PRODUCS PAGINATED
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
				[ProdutoId]								AS	[Identifier]
      			,[TipoProdutoId]						AS 	[ProductTypeEnum]
      			,[Titulo]
      			,[Detalhes]
      			,[ResumoDetalhes]
      			,[CodigoBarras]
      			,[Marca]
      			,[Quantidade]
      			,[IsIlimitado]
      			,[QuantidadeCritica]
      			,[PrecoCusto]
      			,[PrecoVenda]
      			,[Score]
      			,[Relevance]
      			,[Peso]
      			,[Altura]
      			,[Largura]
      			,[Comprimento]
      			,[Bloqueado]
      			,[VendedorId]							AS [SellerId]
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
			AND			(([UsuarioInclusaoId] = @UserId OR [UsuarioUltimaAlteracaoId] = @UserId) OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1)
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
-- Procedure [dbo].[ReleasePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS PRODUCS PAGINATED
	CREATE PROCEDURE [dbo].[ReleasePaginated]
		@Id UNIQUEIDENTIFIER,
		@UsuarioIdBaixa UNIQUEIDENTIFIER,
		@UsuarioInclusaoId UNIQUEIDENTIFIER,
		@Referencia VARCHAR(50),
		@DataMovimento DATETIME,
		@DataBaixa DATETIME,
		@NroAutorizacao VARCHAR(50),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT
				[LancamentoId]              AS	Identifier
      			,[TipoLancamento]			AS ReleaseTypeEnum
      			,[Status]
      			,[Referencia]
      			,[NroAutorizacao]
				,[CodExternoAutorizacao]
      			,[ValorLancamento]
      			,[DataBaixa]
      			,[Observacao]
      			,[UsuarioIdBaixa]
      			,[LancamentoIdPai]
      			,[QtdeParcelas]
      			,[NmrParcela]
      			,[ValorParcela]
      			,[UsuarioInclusaoId]
      			,[UsuarioUltimaAlteracaoId]
      			,[DataInclusao]
      			,[DataUltimaAlteracao]
      			,[Ativo]
			FROM [APDBDev].[dbo].[Lancamentos]
			WHERE 		([LancamentoId]					=		  @Id							OR	@Id 				IS NULL)
			AND 		([UsuarioIdBaixa]				=		  @UsuarioIdBaixa				OR	@UsuarioIdBaixa 	IS NULL)
			AND 		([Referencia] 					LIKE '%' +@Referencia + '%'				OR	@Referencia 		IS NULL)
			AND 		([DataInclusao] 				=		  @DataMovimento				OR	@DataMovimento 		IS NULL)
			AND 		([NroAutorizacao]				LIKE '%' +@NroAutorizacao+ '%'			OR	@NroAutorizacao 	IS NULL)
			AND			([UsuarioInclusaoId] 			= 		  @UsuarioInclusaoId 			OR 	@UsuarioInclusaoId 	IS NULL)
			AND			([Ativo] = @Ativo 														OR @Ativo 				IS NULL)
			ORDER BY 	[DataInclusao]	 				DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) 	ROWS
			FETCH NEXT @RowspPage 						ROWS ONLY;
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
		@ProductId UNIQUEIDENTIFIER,
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
				[T].[PrecoVenda],
				[T].[VendedorId]				AS 	[SellerId]
			FROM (
				SELECT
					[Prd].[ProdutoId]			AS	[Identifier]
					,[Prd].[TipoProdutoId]		AS 	[ProductTypeEnum]
					,[Img].[File]				AS 	[MainImage]
					,[dbo].[FNCReturnIsItemcked]([Prd].[ProdutoId]) AS [Blocked]
					,[Prd].[Titulo]
					,[Prd].[ResumoDetalhes]
					,[Prd].[Detalhes]
					,[Prd].[CodigoBarras]
					,[Prd].[Marca]
					,[Prd].[Quantidade]
					,[Prd].[PrecoVenda]
					,[Prd].[VendedorId]
				FROM [APDBDev].[dbo].[Produtos] [Prd]
				LEFT JOIN [APDBDev].[dbo].[ImagensProdutos] [PrdImg] ON [PrdImg].[ProdutoId] = [Prd].[ProdutoId]
				LEFT JOIN [APDBDev].[dbo].[Imagens] [Img] ON [PrdImg].[ImagemId] = [Img].[ImagemId] AND [Img].[ImagemPrincipal] = 1
				WHERE
				([Prd].[ProdutoId]										 =									@ProductId										OR	@ProductId IS NULL)
				AND
				(
							(UPPER([Prd].[Titulo])						LIKE 		UPPER(CONCAT('%',@Param,'%'))						OR	@Param IS NULL)
				OR 			(UPPER([Prd].[Marca])						LIKE 		UPPER(CONCAT('%',@Param,'%'))						OR	@Param IS NULL)
				OR 			(UPPER([Prd].[CodigoBarras]) 				LIKE 		UPPER(CONCAT('%',@Param,'%'))						OR	@Param IS NULL)
				OR			(CONVERT(VARCHAR(50),[Prd].[PrecoVenda])	=			CONVERT(VARCHAR(50),@Param)  						OR	@Param IS NULL)
				)
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
				LEFT JOIN [APDBDev].[dbo].[EnderecosUsuarios] [endusu]		ON [endusu].[EnderecoId] = [end].[EnderecoId]
				LEFT JOIN [APDBDev].[seg].[Usuarios] [usu] 				ON [usu].[UsuarioId]	 = [endusu].[UsuarioId]
				WHERE
							([end].[EnderecoId]		=		  		@Id					OR	@Id 		IS NULL)
				AND			
				(
								([usu].[UsuarioId]		=		  		@UserId				OR	@UserId 		IS NULL)
					AND			([usu].[Login]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
					AND 		([usu].[NmrDocumento]	LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
					AND 		([usu].[Nome]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
					AND 		([usu].[Email]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
				)
				AND 		([end].[TipoEnderecoId]	 =		  	@TipoEndereco			OR	@TipoEndereco	IS NULL)
				AND 		([end].[Logradouro]		LIKE 	'%' +@Logradouro+ '%'		OR	@Logradouro 		IS NULL)
				AND 		([end].[IsPrincipal] 	 =		  	@IsPrincipal			OR	@IsPrincipal 	IS NULL)
				AND			([end].[Ativo] 			 = 			@Ativo 					OR	@Ativo 			IS NULL)
				AND			[usu].[Bloqueado] 		 = 			0
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
-- Procedure [dbo].[ReturnIsItemBlocked]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS INFORMATION ABOUT ANY ITEM LIKE ADRESS, FONE, USER, PRODUCT IF IT HAS BLOCKED BY SISTEM
	CREATE PROCEDURE [dbo].[ReturnIsItemBlocked]
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
-- Procedure [dbo].[ReturnPurchasePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2024
	-- THIS PROCEDURE RETURNS TABLE COMPRAS PAGINATED
	CREATE PROCEDURE [dbo].[ReturnPurchasePaginated]
		@CompraId UNIQUEIDENTIFIER,
		@CompradorId UNIQUEIDENTIFIER,
		@EntregaId UNIQUEIDENTIFIER,
		@CodigoCompra VARCHAR(30),
		@Status BIT,
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
  			    ,[T].[PurchaseCode]
  			    ,[T].[ExternalPurchaseCode]
				,[T].[ExternalPaymentLink]
  			    ,[T].[Contador]
  			    ,[T].[CompradorId]
  			    ,[T].[PaymentFormType]
  			    ,[T].[StatusPurchase]								
  			    ,[T].[EntregaId]
  			    ,[T].[LancamentoPaiId]
  			    ,[T].[GarantiaId]
  			    ,[T].[UsuarioInclusaoId]
  			    ,[T].[UsuarioUltimaAlteracaoId]
  			    ,[T].[DataInclusao]
  			    ,[T].[DataUltimaAlteracao]
  			    ,[T].[Ativo]
				,[T].[PurchaserId]
				,[T].[PurchaseValue]
			FROM (
				SELECT
	  				[cp].[CompraId]										 		AS [Identifier]
					,[dbo].[FNCReturnIsItemcked]([CompraId]) 					AS [Blocked]
  				    ,[cp].[CodigoCompra]										AS [PurchaseCode]
  				    ,[cp].[CodigoExternoCompra]									AS [ExternalPurchaseCode]
					,[cp].[LinkExternoPagamento]								AS [ExternalPaymentLink]
  				    ,[cp].[Contador]
  				    ,[cp].[CompradorId]
  				    ,[cp].[FormaPagamento]										AS [PaymentFormType]
  				    ,[cp].[Status]												AS [StatusPurchase]							
  				    ,[cp].[EntregaId]
  				    ,[cp].[LancamentoPaiId]
  				    ,[cp].[GarantiaId]
  				    ,[cp].[UsuarioInclusaoId]
  				    ,[cp].[UsuarioUltimaAlteracaoId]
  				    ,[cp].[DataInclusao]
  				    ,[cp].[DataUltimaAlteracao]
  				    ,[cp].[Ativo]
					,[cp].[CompradorId]											AS [PurchaserId]
					,[lc].[ValorLancamento]										AS [PurchaseValue]
  				FROM 			[APDBDev].[dbo].[Compras] 		[cp]
				INNER JOIN 		[APDBDev].[dbo].[Lancamentos] 	[lc]			ON [lc].[LancamentoId] 	= 	[cp].[LancamentoPaiId]
				WHERE 	([cp].[CompraId]					=		  		@CompraId						OR	@CompraId 				IS NULL)
				AND		([cp].[CompradorId]				=		  		@CompradorId					OR	@CompradorId 			IS NULL)
				AND		([cp].[EntregaId]				=		  		@EntregaId						OR	@EntregaId 				IS NULL)
				AND		([cp].[CodigoCompra]				=		  		@CodigoCompra					OR	@CodigoCompra 			IS NULL)
				AND		([cp].[CodigoExternoCompra]		=		  		@CodigoCompra					OR	@CodigoCompra 			IS NULL)
				AND		([cp].[Status] 					= 				@Status 						OR	@Status 				IS NULL)
				AND		([cp].[Ativo] 					= 				@Ativo 							OR	@Ativo 					IS NULL)
				ORDER BY	1 DESC
				OFFSET		((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT	@RowspPage ROWS ONLY
			) AS T
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnPurchaseProcess]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2024
	-- THIS PROCEDURE RETURNS TABLE COMPRAS PAGINATED
	CREATE PROCEDURE [dbo].[ReturnPurchaseProcess]
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier]
  			    ,[T].[PurchaseCode]
  			    ,[T].[ExternalPurchaseCode]
				,[T].[ExternalPaymentLink]
  			    ,[T].[Contador]
				,[T].[PurchaseValue]
  			    ,[T].[PaymentFormType]
  			    ,[T].[StatusPurchase]								
  			    ,[T].[EntregaId]
  			    ,[T].[LancamentoPaiId]
  			    ,[T].[GarantiaId]
				,[T].[PurchaserId]
  			    ,[T].[UsuarioInclusaoId]
  			    ,[T].[UsuarioUltimaAlteracaoId]
  			    ,[T].[DataInclusao]
  			    ,[T].[DataUltimaAlteracao]
  			    ,[T].[Ativo]
			FROM (
				SELECT
	  				[cp].[CompraId]										 		AS [Identifier]
					,[dbo].[FNCReturnIsItemcked]([CompraId]) 					AS [Blocked]
  				    ,[cp].[CodigoCompra]										AS [PurchaseCode]
  				    ,[cp].[CodigoExternoCompra]									AS [ExternalPurchaseCode]
					,[cp].[LinkExternoPagamento]								AS [ExternalPaymentLink]
  				    ,[cp].[Contador]
  				    ,[cp].[CompradorId]									    	AS [PurchaserId]
  				    ,[cp].[FormaPagamento]										AS [PaymentFormType]
  				    ,[cp].[Status]												AS [StatusPurchase]							
  				    ,[cp].[EntregaId]
  				    ,[cp].[LancamentoPaiId]
  				    ,[cp].[GarantiaId]	
  				    ,[cp].[UsuarioInclusaoId]
  				    ,[cp].[UsuarioUltimaAlteracaoId]
  				    ,[cp].[DataInclusao]
  				    ,[cp].[DataUltimaAlteracao]
  				    ,[cp].[Ativo]
					,[lc].[ValorLancamento]										AS [PurchaseValue]
  				FROM 			[APDBDev].[dbo].[Compras] 		[cp]
				INNER JOIN 		[APDBDev].[dbo].[Lancamentos] 	[lc]			ON [lc].[LancamentoId] 	= 	[cp].[LancamentoPaiId]
				WHERE
						[cp].[Status] 			= 				0
				OR		[cp].[Status] 			= 				2
				OR		[cp].[Status] 			= 				3
				AND		[cp].[Ativo] 			= 				1
			) AS T
			WHERE [T].[Blocked] = 0
			ORDER BY [T].[DataInclusao] DESC;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnShopCartPurchaseByPurchaseId]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2024
	-- THIS PROCEDURE RETURNS TABLE COMPRAS PAGINATED
	CREATE PROCEDURE [dbo].[ReturnShopCartPurchaseByPurchaseId]
	@PurchaseId UNIQUEIDENTIFIER
	AS
		BEGIN
			SELECT
				[CompraProdutoId]		AS Identifier
      			,[CompraId]
      			,[Quantidade]
      			,[ProdutoId]
				,[UsuarioInclusaoId]
		  		,[UsuarioUltimaAlteracaoId]
		  		,[DataInclusao]
		  		,[DataUltimaAlteracao]
		  		,[Ativo]
  			FROM [APDBDev].[dbo].[ComprasProdutos]
			WHERE [CompraId] = @PurchaseId
			AND [Ativo] = 1
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -- -----------------------------------------------------
-- -- Procedure [log].[LogsPaginated]
-- -- -----------------------------------------------------
-- 
-- 	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
-- 	-- CREATED BY ALESSANDRO 08/05/2021
-- 	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
-- 	CREATE PROCEDURE [log].[LogsPaginated]
-- 		@Param VARCHAR(MAX),
-- 		@DateAdded DATETIME,
-- 		@PageNumber INT,
-- 		@RowspPage INT
-- 	AS
-- 		BEGIN
-- 			-- ATRIB TESTE PROC
-- 			-- SET @DateAdded = NULL
-- 			-- SET @Param = 'POST'
-- 			-- SET @PageNumber = 1
-- 			-- SET @RowspPage = 5
-- 			SELECT
-- 				[LogId]
-- 				,[Message]
-- 				,[Request]
-- 				,[Method]
-- 				,[Response]
-- 				,[UserAddedId]
-- 				,[DateAdded]
-- 			FROM 		[log].[Logs]
-- 			WHERE 
-- 					(LOWER(CONVERT(VARCHAR(50), [LogId])) = LOWER(CONVERT(VARCHAR(50), @Param))			OR		@Param IS NULL)
-- 			OR 		(LOWER([Message])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
-- 			OR 		(LOWER([Method])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
-- 			OR 		(LOWER([Request])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
-- 			OR 		(LOWER(CONVERT(VARCHAR(50), [Response])) = LOWER(CONVERT(VARCHAR(50), @Param))		OR		@Param IS NULL)
-- 			OR 		(LOWER(CONVERT(VARCHAR(50), [UserAddedId])) = LOWER(CONVERT(VARCHAR(50), @Param))	OR		@Param IS NULL)
-- 			AND		([DateAdded] >= @DateAdded															OR		@DateAdded IS NULL)
-- 			ORDER BY	1 DESC
-- 			OFFSET		((@PageNumber - 1) * @RowspPage) ROWS
-- 			FETCH NEXT	@RowspPage ROWS ONLY;
-- 		END
-- GO
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

-- -----------------------------------------------------
-- Procedure [seg].[UsuariosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 11/06/2024
	-- THIS PROCEDURE RETURNS USER UMBLOCKED PAGINATED
	CREATE PROCEDURE [seg].[UsuariosPaginated]
		@Id UNIQUEIDENTIFIER,
		@UserId UNIQUEIDENTIFIER,
		@UserName VARCHAR(255),
		@Nome VARCHAR(255),
		@NmrDocumento VARCHAR(255),
		@Email VARCHAR(255),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[UsuarioId]							AS Identifier
				,[T].[GrupoId]
      			,[T].[Login]
      			,[T].[NmrDocumento]
				,[T].[NmrTelefone]
      			,[T].[TipoDocumentoId]
      			,[T].[Senha]
      			,[T].[Nome]
      			,[T].[DataNascimento]
      			,[T].[Sexo]
      			,[T].[EstadoCivil]
      			,[T].[Email]
      			,[T].[Bloqueado]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[DataUltimaTrocaSenha]
      			,[T].[DataUltimoLogin]
				,[T].[TrocaSenha]
      			,[T].[Ativo]
				,[T].[Token]
				,[T].[RefreshToken]
				,[T].[RefreshTokenExpiryTime]
			FROM (
				SELECT
					[User].[UsuarioId]
					,[dbo].[FNCReturnIsItemcked]([User].[UsuarioId]) 	AS 	Blocked
					,[User].[GrupoId]
      				,[User].[Login]
      				,[User].[NmrDocumento]
					,[User].[NmrTelefone]
      				,[User].[TipoDocumentoId]
      				,[User].[Senha]
      				,[User].[Nome]
      				,[User].[DataNascimento]
      				,[User].[Sexo]
      				,[User].[EstadoCivil]
      				,[User].[Email]
      				,[User].[Bloqueado]
      				,[User].[UsuarioInclusaoId]
      				,[User].[UsuarioUltimaAlteracaoId]
      				,[User].[DataInclusao]
      				,[User].[DataUltimaAlteracao]
      				,[User].[DataUltimaTrocaSenha]
      				,[User].[DataUltimoLogin]
					,[User].[TrocaSenha]
      				,[User].[Ativo]
					,[User].[Token]
					,[User].[RefreshToken]
					,[User].[RefreshTokenExpiryTime]
				FROM [APDBDev].[seg].[Usuarios] [User]
				WHERE 		([User].[UsuarioId]						=		  @Id					OR	@Id 			IS NULL)
				AND 		([User].[Login]							=		  @UserName				OR	@UserName 		IS NULL)
				AND 		([User].[Nome]							=		  @Nome					OR	@Nome	 		IS NULL)
				AND 		([User].[NmrDocumento]					=		  @NmrDocumento			OR	@NmrDocumento 	IS NULL)
				AND 		([User].[Email]							=		  @Email				OR	@Email 			IS NULL)
				AND			([User].[Ativo] 			 			= 		  @Ativo 				OR	@Ativo 			IS NULL)
				AND			([User].[UsuarioInclusaoId] 			= 		  @UserId				OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY [User].[DataInclusao], [User].[Email], [User].[NmrDocumento] DESC
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
-- Procedure [seg].[ReturnUsersToSelect]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 06/13/2024
	-- THIS PROCEDURE RETURNS TABLE THE USER BY PARAMETER PAGINATED
	CREATE PROCEDURE [seg].[ReturnUsersToSelect]
		@Param VARCHAR(MAX),
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @Param VARCHAR(MAX) = NULL,
			-- SET @PageNumber = 1
			-- SET @RowspPage = 10
			SELECT
				[T].[UsuarioId]			AS	[Key],
				[T].[Nome]				AS 	[Parameter]
			FROM (
				SELECT
					[usu].[UsuarioId]
					,[usu].[Nome]
					,[dbo].[FNCReturnIsItemcked]([usu].[UsuarioId]) AS Blocked
				FROM [APDBDev].[seg].[Usuarios] [usu]
				WHERE 
				(LOWER(CONVERT(VARCHAR(50),[usu].[UsuarioId]))			  =			LOWER(CONVERT(VARCHAR(50),@Param))
				OR 			LOWER([usu].[Login])											LIKE 		'%' + LOWER(@Param) + '%'
				OR 			LOWER([usu].[NmrDocumento])										LIKE 		'%' + LOWER(@Param) + '%'
				OR 			LOWER([usu].[Nome]) 											LIKE 		'%' + LOWER(@Param) + '%'
				OR 			LOWER([usu].[Email]) 											LIKE 		'%' + LOWER(@Param) + '%'
				OR	@Param IS NULL)
				AND [usu].[Ativo] = 1
				ORDER BY [usu].[Nome] DESC, [usu].[Email] DESC, [usu].[DataInclusao] DESC, [usu].[DataUltimaAlteracao] DESC
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
-- Procedure [dbo].[AvaliationPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS AVALIATION UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[AvaliationPaginated]
		@Id UNIQUEIDENTIFIER,
		@ItemId UNIQUEIDENTIFIER,
		@AvaliadorId UNIQUEIDENTIFIER,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[AvaliacaoId]							AS Identifier
      			,[T].[ItemId]
      			,[T].[Comentario]
      			,[T].[Valor]
      			,[T].[AvaliadorId]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[av].[AvaliacaoId]
					,[dbo].[FNCReturnIsItemcked]([av].[UsuarioId]) 	AS 	Blocked
      				,[av].[ItemId]
      				,[av].[Comentario]
      				,[av].[Valor]
      				,[av].[AvaliadorId]
      				,[av].[UsuarioInclusaoId]
      				,[av].[UsuarioUltimaAlteracaoId]
      				,[av].[DataInclusao]
      				,[av].[DataUltimaAlteracao]
      				,[av].[Ativo]
				FROM [APDBDev].[dbo].[Avaliacoes] [av]
				WHERE 		([av].[AvaliacaoId]						=		  @Id					OR	@Id 			IS NULL)
				AND 		([av].[ItemId]							=		  @ItemId				OR	@ItemId 		IS NULL)
				AND 		([av].[AvaliadorId]						=		  @AvaliadorId			OR	@AvaliadorId	IS NULL)
				AND 		([av].[Ativo]							=		  @Ativo				OR	@Ativo			IS NULL)
				AND			([av].[UsuarioInclusaoId] 				= 		  @UserId				OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY [av].[DataInclusao] DESC
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
-- Procedure [dbo].[BlockPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS BLOCK PAGINATED
	CREATE PROCEDURE [dbo].[BlockPaginated]
		@Id UNIQUEIDENTIFIER,
		@TipoBloqueioId INT,
		@NomeBloqueio VARCHAR(100),
		@Permanente BIT,
		@DataBloqueio DATETIME,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[block].[BloqueioId]						AS Identifier
      			,[block].[TipoBloqueioId]
      			,[block].[NomeBloqueio]
      			,[block].[Permanente]
      			,[block].[UsuarioInclusaoId]
      			,[block].[UsuarioUltimaAlteracaoId]
      			,[block].[DataInicio]
      			,[block].[DataFim]
      			,[block].[DataInclusao]
      			,[block].[DataUltimaAlteracao]
      			,[block].[Detalhes]
      			,[block].[Ativo]
			FROM [APDBDev].[dbo].[Bloqueios] [block]
			WHERE 		([block].[BloqueioId]						=		  @Id							OR	@Id 				IS NULL)
			AND 		([block].[TipoBloqueioId]					=		  @TipoBloqueioId				OR	@TipoBloqueioId		IS NULL)
			AND 		([block].[NomeBloqueio]						LIKE	 '%' + @NomeBloqueio + '%' 		OR	@NomeBloqueio		IS NULL)
			AND 		([block].[TipoBloqueioId]					=		  @TipoBloqueioId				OR	@TipoBloqueioId		IS NULL)
			AND 		([block].[Permanente]						=		  @Permanente					OR	@Permanente			IS NULL)
			AND 		(@DataBloqueio							 BETWEEN	  [block].[DataInicio] 			AND [block].[DataFim]	OR	@DataBloqueio	IS NULL)
			AND 		([block].[Ativo]							=		  @Ativo						OR	@Ativo				IS NULL)
			AND			([block].[UsuarioInclusaoId] 				= 		  @UserId						OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
			ORDER BY [block].[DataInclusao] DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[CharacteristicPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS CHATACTERISTIC UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[CharacteristicPaginated]
		@Id UNIQUEIDENTIFIER,
		@ProdutoId UNIQUEIDENTIFIER,
		@Publico BIT,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[CaracteristicaId]						AS Identifier
      			,[T].[TipoCaracteristicaId]
      			,[T].[ProdutoId]
      			,[T].[Descricao]
      			,[T].[Ordem]
      			,[T].[Publico]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[ct].[CaracteristicaId]
					,[dbo].[FNCReturnIsItemcked] ([ct].[CaracteristicaId]) 	AS 	Blocked
      				,[ct].[TipoCaracteristicaId]
      				,[ct].[ProdutoId]
      				,[ct].[Descricao]
      				,[ct].[Ordem]
      				,[ct].[Publico]
      				,[ct].[UsuarioInclusaoId]
      				,[ct].[UsuarioUltimaAlteracaoId]
      				,[ct].[DataInclusao]
      				,[ct].[DataUltimaAlteracao]
      				,[ct].[Ativo]
				FROM [APDBDev].[dbo].[Caracteristicas] [ct]
				WHERE 		([ct].[CaracteristicaId]				=		  @Id					OR	@Id 			IS NULL)
				AND 		([ct].[ProdutoId]						=		  @ProdutoId			OR	@ProdutoId		IS NULL)
				AND 		([ct].[Publico]							=		  @Publico				OR	@Publico		IS NULL)
				AND 		([ct].[Ativo]							=		  @Ativo				OR	@Ativo			IS NULL)
				AND			([ct].[UsuarioInclusaoId] 				= 		  @UserId				OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[ct].[DataInclusao] DESC
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
-- Procedure [dbo].[BankCardPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS BANKCARD UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[BankCardPaginated]
		@Id UNIQUEIDENTIFIER,
		@Numero VARCHAR(16),
		@NomeNoCartao VARCHAR(50),
		@Bandeira VARCHAR(10),
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[CartaoBancarioId]				AS Identifier
      			,[T].[UsuarioId]
      			,[T].[Numero]
      			,[T].[NomeNoCartao]
      			,[T].[Bandeira]
      			,[T].[Validade]
      			,[T].[Tipo]
      			,[T].[CodSeg]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([ctb].[CartaoBancarioId]) 	AS 	Blocked
      				,[ctb].[CartaoBancarioId]
      				,[ctb].[UsuarioId]
      				,[ctb].[Numero]
      				,[ctb].[NomeNoCartao]
      				,[ctb].[Bandeira]
      				,[ctb].[Validade]
      				,[ctb].[Tipo]
      				,[ctb].[CodSeg]
      				,[ctb].[UsuarioInclusaoId]
      				,[ctb].[UsuarioUltimaAlteracaoId]
      				,[ctb].[DataInclusao]
      				,[ctb].[DataUltimaAlteracao]
      				,[ctb].[Ativo]
				FROM [APDBDev].[dbo].[CartoesBancarios] [ctb]
				WHERE 		([ctb].[CartaoBancarioId]				=		  @Id					OR	@Id 				IS NULL)
				AND 		([ctb].[Numero]							=		  @Numero				OR	@Numero				IS NULL)
				AND 		([ctb].[NomeNoCartao]					=		  @NomeNoCartao			OR	@NomeNoCartao		IS NULL)
				AND 		([ctb].[Bandeira]						=		  @Bandeira				OR	@Bandeira			IS NULL)
				AND 		([ctb].[Ativo]							=		  @Ativo				OR	@Ativo				IS NULL)
				AND			([ctb].[UsuarioInclusaoId] 				= 		  @UserId				OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[ctb].[DataInclusao] DESC
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
-- Procedure [dbo].[ConfigurationPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS CONFIGURATION UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[ConfigurationPaginated]
		@Id UNIQUEIDENTIFIER,
		@TipoConfiguracaoId UNIQUEIDENTIFIER,
		@Descricao VARCHAR(150),
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[ConfiguracaoId]				AS Identifier
      			,[T].[TipoConfiguracaoId]
      			,[T].[Descricao]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([cf].[ConfiguracaoId]) 	AS 	Blocked
      				,[cf].[ConfiguracaoId]
      				,[cf].[TipoConfiguracaoId]
      				,[cf].[Descricao]
      				,[cf].[UsuarioInclusaoId]
      				,[cf].[UsuarioUltimaAlteracaoId]
      				,[cf].[DataInclusao]
      				,[cf].[DataUltimaAlteracao]
      				,[cf].[Ativo]
				FROM [APDBDev].[dbo].[Configuracoes] [cf]
				WHERE 		([cf].[ConfiguracaoId]					=		  @Id					OR	@Id 				IS NULL)
				AND 		([cf].[TipoConfiguracaoId]				=		  @TipoConfiguracaoId	OR	@TipoConfiguracaoId	IS NULL)
				AND 		([cf].[Descricao]						LIKE  '%' + @Descricao + '%'	OR	@Descricao			IS NULL)
				AND 		([cf].[Ativo]							=		  @Ativo				OR	@Ativo				IS NULL)
				AND			([cf].[UsuarioInclusaoId] 				= 		  @UserId				OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[cf].[DataInclusao] DESC
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
-- Procedure [dbo].[ConfigurationParamaterPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS CONFIGURATIONPARAMETER PAGINATED
	CREATE PROCEDURE [dbo].[ConfigurationParamaterPaginated]
		@Id UNIQUEIDENTIFIER,
		@ParametroId UNIQUEIDENTIFIER,
		@ConfiguracaoId UNIQUEIDENTIFIER,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[cps].[ConfiguracaoParametroId]
      			,[cps].[ParametroId]
      			,[cps].[ConfiguracaoId]
			FROM [APDBDev].[dbo].[ConfiguracoesParametros] [cps]
			WHERE 		([cps].[ConfiguracaoId]					=		  @Id					OR	@Id 				IS NULL)
			AND 		([cps].[ParametroId]					=		  @ParametroId			OR	@ParametroId		IS NULL)
			AND 		([cps].[ConfiguracaoId]					=		  @ConfiguracaoId		OR	@ConfiguracaoId		IS NULL)
			ORDER BY 	[cps].[ConfiguracaoId]	 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[BankDataPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS BANK DATA UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[BankDataPaginated]
		@Id UNIQUEIDENTIFIER,
		@Banco VARCHAR(100),
		@Agencia VARCHAR(6),
		@Conta VARCHAR(20),
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[DadoBancarioId]				AS Identifier
      			,[T].[UsuarioId]
      			,[T].[Banco]
      			,[T].[Agencia]
      			,[T].[Conta]
      			,[T].[Tipo]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([dbank].[DadoBancarioId]) 	AS 	Blocked
      				,[dbank].[DadoBancarioId]
      				,[dbank].[UsuarioId]
      				,[dbank].[Banco]
      				,[dbank].[Agencia]
      				,[dbank].[Conta]
      				,[dbank].[Tipo]
      				,[dbank].[UsuarioInclusaoId]
      				,[dbank].[UsuarioUltimaAlteracaoId]
      				,[dbank].[DataInclusao]
      				,[dbank].[DataUltimaAlteracao]
      				,[dbank].[Ativo]
				FROM [APDBDev].[dbo].[DadosBancarios] [dbank]
				WHERE 		([dbank].[DadoBancarioId]					=		  @Id					OR	@Id 				IS NULL)
				AND 		([dbank].[UsuarioId]						=		  @UserId				OR	@UserId				IS NULL)
				AND 		([dbank].[Banco]							LIKE  '%' + @Banco + '%'		OR	@Banco				IS NULL)
				AND 		([dbank].[Agencia]							LIKE  '%' + @Agencia + '%'		OR	@Agencia			IS NULL)
				AND 		([dbank].[Conta]							LIKE  '%' + @Conta + '%'		OR	@Conta				IS NULL)
				AND 		([dbank].[Ativo]							=		  @Ativo				OR	@Ativo				IS NULL)
				AND			([dbank].[UsuarioInclusaoId] 				= 		  @UserId				OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[dbank].[DataInclusao] DESC
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
-- Procedure [dbo].[EmailPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS EMAIL UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[EmailPaginated]
		@Id UNIQUEIDENTIFIER,
		@TipoEmailId INT,
		@Destinatario VARCHAR(150),
		@Assunto VARCHAR(100),
		@StatusEnvio INT,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[EmailId]						AS Identifier
      			,[T].[UsuarioEnvioId]
      			,[T].[TipoEmailId]
      			,[T].[NomeEmail]
      			,[T].[Destinatario]
      			,[T].[Assunto]
      			,[T].[Mensagem]
      			,[T].[Html]
      			,[T].[StatusEnvio]
      			,[T].[Tentativas]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
				,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([em].[EmailId]) 	AS 	Blocked
      				,[em].[EmailId]
      				,[em].[UsuarioEnvioId]
      				,[em].[TipoEmailId]
      				,[em].[NomeEmail]
      				,[em].[Destinatario]
      				,[em].[Assunto]
      				,[em].[Mensagem]
      				,[em].[Html]
      				,[em].[StatusEnvio]
      				,[em].[Tentativas]
      				,[em].[UsuarioInclusaoId]
      				,[em].[UsuarioUltimaAlteracaoId]
      				,[em].[DataInclusao]
      				,[em].[DataUltimaAlteracao]
					,[em].[Ativo]
      				FROM [APDBDev].[dbo].[Emails] 	[em]	
				WHERE 		([em].[EmailId]							=		  @Id					OR	@Id 				IS NULL)
				AND 		([em].[UsuarioEnvioId]					=		  @UserId				OR	@UserId				IS NULL)
				AND 		([em].[TipoEmailId]						=		  @TipoEmailId			OR	@TipoEmailId		IS NULL)
				AND 		([em].[Destinatario]					=		  @Destinatario			OR	@Destinatario		IS NULL)
				AND 		([em].[Assunto]							LIKE  '%' + @Assunto + '%'		OR	@Assunto			IS NULL)
				AND 		([em].[StatusEnvio]						=		  @StatusEnvio			OR	@StatusEnvio		IS NULL)
				AND 		([em].[Ativo]							=		  @Ativo				OR	@Ativo				IS NULL)
				AND			([em].[UsuarioInclusaoId] 				= 		  @UserId				OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[em].[DataInclusao] DESC
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
-- Procedure [dbo].[DeliveryPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS DELIVERY UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[DeliveryPaginated]
		@Id UNIQUEIDENTIFIER,
		@TipoEntrega INT,
		@ResponsavelEntregaId UNIQUEIDENTIFIER,
		@DataEntrega DATETIME,
		@Status INT,
		@NmrDocumento VARCHAR(50),
		@CodigoRastramento VARCHAR(30),
		@TipoDocumento INT,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[EntregaId]							AS Identifier
      			,[T].[ResponsavelEntregaId]
      			,[T].[TipoEntrega]
      			,[T].[DataPrevistaEntrega]
      			,[T].[DataEfetivaEnrega]
      			,[T].[Status]
      			,[T].[ValorTotal]
      			,[T].[NmrDocumento]
      			,[T].[CodigoRastramento]
      			,[T].[TipoDocumento]
      			,[T].[NomeRecebedor]
      			,[T].[IsEntregueTitular]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([et].[EntregaId]) 	AS 	Blocked
      				,[et].[EntregaId]
      				,[et].[ResponsavelEntregaId]
      				,[et].[TipoEntrega]
      				,[et].[DataPrevistaEntrega]
      				,[et].[DataEfetivaEnrega]
      				,[et].[Status]
      				,[et].[ValorTotal]
      				,[et].[NmrDocumento]
      				,[et].[CodigoRastramento]
      				,[et].[TipoDocumento]
      				,[et].[NomeRecebedor]
      				,[et].[IsEntregueTitular]
      				,[et].[UsuarioInclusaoId]
      				,[et].[UsuarioUltimaAlteracaoId]
      				,[et].[DataInclusao]
      				,[et].[DataUltimaAlteracao]
      				,[et].[Ativo]
      				FROM [APDBDev].[dbo].[Entregas] 	[et]	
				WHERE 		([et].[EntregaId]						=		  @Id						OR	@Id 					IS NULL)
				AND 		([et].[TipoEntrega]						=		  @TipoEntrega				OR	@TipoEntrega			IS NULL)
				AND 		([et].[ResponsavelEntregaId]			=		  @ResponsavelEntregaId		OR	@ResponsavelEntregaId	IS NULL)
				AND 		([et].[DataPrevistaEntrega]				=		  @DataEntrega				OR [et].[DataEfetivaEnrega]				=		  @DataEntrega				OR	@DataEntrega			IS NULL)
				AND 		([et].[Status]							=		  @Status					OR	@Status					IS NULL)
				AND 		([et].[NmrDocumento]				  LIKE  '%' + @NmrDocumento + 	   '%'	OR	@NmrDocumento			IS NULL)
				AND 		([et].[CodigoRastramento]			  LIKE  '%' + @CodigoRastramento + '%'	OR	@CodigoRastramento		IS NULL)
				AND 		([et].[TipoDocumento]					=		  @TipoDocumento			OR	@TipoDocumento			IS NULL)
				AND 		([et].[Ativo]							=		  @Ativo					OR	@Ativo					IS NULL)
				AND			([et].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[et].[DataInclusao] DESC
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
-- Procedure [dbo].[PaymentFormPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS PAYMENT FORM UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[PaymentFormPaginated]
		@Id UNIQUEIDENTIFIER,
		@Descricao VARCHAR(50),
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[FormaPagamentoId]				AS Identifier
      			,[T].[Descricao]
      			,[T].[PermiteParcelar]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([fp].[FormaPagamentoId]) 	AS 	Blocked
      				,[fp].[FormaPagamentoId]
      				,[fp].[Descricao]
      				,[fp].[PermiteParcelar]
      				,[fp].[UsuarioInclusaoId]
      				,[fp].[UsuarioUltimaAlteracaoId]
      				,[fp].[DataInclusao]
      				,[fp].[DataUltimaAlteracao]
      				,[fp].[Ativo]
      				FROM [APDBDev].[dbo].[FormasPagamentos] 	[fp]	
				WHERE 		([fp].[FormaPagamentoId]				=		  @Id						OR	@Id 					IS NULL)
				AND 		([fp].[Descricao]			  		  LIKE  '%' + @Descricao + '%'			OR	@Descricao				IS NULL)
				AND 		([fp].[Ativo]							=		  @Ativo					OR	@Ativo					IS NULL)
				AND			([fp].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[fp].[DataInclusao] DESC
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
-- Procedure [dbo].[AssurancePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS ASSURANCE UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[AssurancePaginated]
		@Id UNIQUEIDENTIFIER,
		@TipoGarantia INT,
		@Descricao VARCHAR(50),
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[GarantiaId]					AS Identifier
      			,[T].[TipoGarantia]
      			,[T].[Descricao]
      			,[T].[Detalhes]
      			,[T].[Periodo]
      			,[T].[Inicio]
      			,[T].[Fim]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([gt].[GarantiaId]) 	AS 	Blocked
      				,[gt].[GarantiaId]
      				,[gt].[TipoGarantia]
      				,[gt].[Descricao]
      				,[gt].[Detalhes]
      				,[gt].[Periodo]
      				,[gt].[Inicio]
      				,[gt].[Fim]
      				,[gt].[UsuarioInclusaoId]
      				,[gt].[UsuarioUltimaAlteracaoId]
      				,[gt].[DataInclusao]
      				,[gt].[DataUltimaAlteracao]
      				,[gt].[Ativo]
      				FROM [APDBDev].[dbo].[Garantias] 	[gt]	
				WHERE 		([gt].[GarantiaId]						=		  @Id						OR	@Id 					IS NULL)
				AND 		([gt].[TipoGarantia]					=		  @TipoGarantia				OR	@TipoGarantia			IS NULL)
				AND 		([gt].[Descricao]			  		  LIKE  '%' + @Descricao + '%'			OR	@Descricao				IS NULL)
				AND 		([gt].[Ativo]							=		  @Ativo					OR	@Ativo					IS NULL)
				AND			([gt].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[gt].[DataInclusao] DESC
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
-- Procedure [dbo].[ImagePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS IMAGE UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[ImagePaginated]
		@Id UNIQUEIDENTIFIER,
		@Descricao VARCHAR(50),
		@Titulo VARCHAR(50),
		@UserId UNIQUEIDENTIFIER,
		@Publico BIT,
		@ImagemPrincipal BIT,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[ImagemId]					AS Identifier
      			,[T].[Titulo]
      			,[T].[File]
      			,[T].[Descricao]
      			,[T].[ImagemPrincipal]
      			,[T].[Publico]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([img].[ImagemId]) 	AS 	Blocked
      				,[img].[ImagemId]
      				,[img].[Titulo]
      				,[img].[File]
      				,[img].[Descricao]
      				,[img].[ImagemPrincipal]
      				,[img].[Publico]
      				,[img].[UsuarioInclusaoId]
      				,[img].[UsuarioUltimaAlteracaoId]
      				,[img].[DataInclusao]
      				,[img].[DataUltimaAlteracao]
      			FROM [APDBDev].[dbo].[Imagens] 	[img]	
				WHERE 		([img].[ImagemId]						=		  @Id						OR	@Id 					IS NULL)
				AND 		([img].[Descricao]			  		  LIKE  '%' + @Descricao + '%'			OR	@Descricao				IS NULL)
				AND 		([img].[Titulo]			  		  	  LIKE  '%' + @Titulo + '%'				OR	@Titulo					IS NULL)
				AND 		([img].[Publico]						=		  @Publico					OR	@Publico				IS NULL)
				AND 		([img].[ImagemPrincipal]				=		  @ImagemPrincipal			OR	@ImagemPrincipal		IS NULL)
				AND			([img].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[img].[DataInclusao] DESC
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
-- Procedure [dbo].[ProductImagePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS PRODUCT IMAGE UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[ProductImagePaginated]
		@Id UNIQUEIDENTIFIER,
		@ImagemId UNIQUEIDENTIFIER,
		@ProdutoId UNIQUEIDENTIFIER,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[ImagemProdutoId]						AS Identifier
      			,[ImagemId]
      			,[ProdutoId]
      		FROM [APDBDev].[dbo].[ImagensProdutos] 	[img]	
			WHERE 		([img].[ImagemProdutoId]				=		  @Id						OR	@Id 					IS NULL)
			AND 		([img].[ImagemId]						=		  @ImagemId					OR	@ImagemId				IS NULL)
			AND 		([img].[ProdutoId]						=		  @ProdutoId				OR	@ProdutoId				IS NULL)
			ORDER BY 	[img].[ImagemProdutoId] DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Procedure [dbo].[MensagePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS MESSAGE UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[MensagePaginated]
		@Id UNIQUEIDENTIFIER,
		@RemetenteId UNIQUEIDENTIFIER,
		@DestinatarioId UNIQUEIDENTIFIER,
		@TipoMensagemId INT,
		@IsHtml BIT,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[MensagemId]					AS Identifier
      			,[T].[RemetenteId]
      			,[T].[MensagemContexto]
      			,[T].[TipoMensagemId]
      			,[T].[IsHtml]
      			,[T].[DestinatarioId]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([msg].[MensagemId]) 	AS 	Blocked
      				,[msg].[MensagemId]
      				,[msg].[RemetenteId]
      				,[msg].[MensagemContexto]
      				,[msg].[TipoMensagemId]
      				,[msg].[IsHtml]
      				,[msg].[DestinatarioId]
      				,[msg].[UsuarioInclusaoId]
      				,[msg].[UsuarioUltimaAlteracaoId]
      				,[msg].[DataInclusao]
      				,[msg].[DataUltimaAlteracao]
      				,[msg].[Ativo]
      				FROM [APDBDev].[dbo].[Mensagens] 	[msg]	
				WHERE 		([msg].[MensagemId]						=		  @Id						OR	@Id 					IS NULL)
				AND 		([msg].[RemetenteId]					=		  @RemetenteId				OR	@RemetenteId			IS NULL)
				AND 		([msg].[DestinatarioId]					=		  @DestinatarioId			OR	@DestinatarioId			IS NULL)
				AND 		([msg].[TipoMensagemId]					=		  @TipoMensagemId			OR	@TipoMensagemId			IS NULL)
				AND 		([msg].[IsHtml]							=		  @IsHtml					OR	@IsHtml					IS NULL)
				AND 		([msg].[Ativo]							=		  @Ativo					OR	@Ativo					IS NULL)
				AND			([msg].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[msg].[DataInclusao] DESC
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
-- Procedure [dbo].[InvoicePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS INVOICE UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[InvoicePaginated]
		@Id UNIQUEIDENTIFIER,
		@ChaveAcesso VARCHAR(50),
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[TipoNotaFiscalId]				AS Identifier
      			,[T].[ChaveAcesso]
      			,[T].[UsuarioId]
      			,[T].[DestinatarioId]
      			,[T].[DadosAdicionais]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([nf].[NotaFiscalId]) 	AS 	Blocked
      				,[nf].[NotaFiscalId]
      				,[nf].[TipoNotaFiscalId]
      				,[nf].[ChaveAcesso]
      				,[nf].[UsuarioId]
      				,[nf].[DestinatarioId]
      				,[nf].[DadosAdicionais]
      				,[nf].[UsuarioInclusaoId]
      				,[nf].[UsuarioUltimaAlteracaoId]
      				,[nf].[DataInclusao]
      				,[nf].[DataUltimaAlteracao]
      				,[nf].[Ativo]
      			FROM [APDBDev].[dbo].[NotasFiscais] 	[nf]	
				WHERE 		([nf].[NotaFiscalId]					=		  @Id						OR	@Id 					IS NULL)
				AND 		([nf].[ChaveAcesso]			  		  LIKE  '%' + @ChaveAcesso + '%'		OR	@ChaveAcesso			IS NULL)
				AND 		([nf].[Ativo]							=		  @Ativo					OR	@Ativo					IS NULL)
				AND			([nf].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[nf].[DataInclusao] DESC
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
-- Procedure [dbo].[ParameterPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS PARAMETER UMBLOCKED PAGINATED
	CREATE PROCEDURE [dbo].[ParameterPaginated]
		@Id UNIQUEIDENTIFIER,
		@TipoParametroId INT,
		@TipoDadoId INT,
		@Descricao VARCHAR(100),
		@UserId UNIQUEIDENTIFIER,
		@Publico BIT,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[ParametroId]					AS Identifier
      			,[T].[TipoParametroId]
      			,[T].[TipoDadoId]
      			,[T].[Descricao]
      			,[T].[Valor]
      			,[T].[Publico]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([pr].[ParametroId]) 	AS 	Blocked
      				,[pr].[ParametroId]
      				,[pr].[TipoParametroId]
      				,[pr].[TipoDadoId]
      				,[pr].[Descricao]
      				,[pr].[Valor]
      				,[pr].[Publico]
      				,[pr].[UsuarioInclusaoId]
      				,[pr].[UsuarioUltimaAlteracaoId]
      				,[pr].[DataInclusao]
      				,[pr].[DataUltimaAlteracao]
      				,[pr].[Ativo]
      				FROM [APDBDev].[dbo].[Parametros] 	[pr]	
				WHERE 		([pr].[ParametroId]						=		  @Id						OR	@Id 					IS NULL)
				AND 		([pr].[TipoParametroId]					=		  @TipoParametroId			OR	@TipoParametroId		IS NULL)
				AND 		([pr].[TipoDadoId]						=		  @TipoDadoId				OR	@TipoDadoId				IS NULL)
				AND 		([pr].[Descricao]			  		  LIKE  '%' + @Descricao + '%'			OR	@Descricao				IS NULL)
				AND 		([pr].[Ativo]							=		  @Ativo					OR	@Ativo					IS NULL)
				AND			([pr].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[pr].[DataInclusao] DESC
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
-- Procedure [seg].[GroupPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS GROUP UMBLOCKED PAGINATED
	CREATE PROCEDURE [seg].[GroupPaginated]
		@Id UNIQUEIDENTIFIER,
		@Descricao VARCHAR(50),
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[GrupoId]						AS Identifier
      			,[T].[Descricao]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([gp].[GrupoId]) 	AS 	Blocked
      				,[gp].[GrupoId]
      				,[gp].[Descricao]
      				,[gp].[UsuarioInclusaoId]
      				,[gp].[UsuarioUltimaAlteracaoId]
      				,[gp].[DataInclusao]
      				,[gp].[DataUltimaAlteracao]
      				,[gp].[Ativo]
      				FROM [APDBDev].[seg].[Grupos] 	[gp]	
				WHERE 		([gp].[GrupoId]							=		  @Id						OR	@Id 					IS NULL)
				AND 		([gp].[Descricao]			  		  LIKE  '%' + @Descricao + '%'			OR	@Descricao				IS NULL)
				AND 		([gp].[Ativo]							=		  @Ativo					OR	@Ativo					IS NULL)
				AND			([gp].[UsuarioInclusaoId] 				= 		  @UserId					OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[gp].[DataInclusao] DESC
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
-- Procedure [seg].[ResourcePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS RESOURCE FORM UMBLOCKED PAGINATED
	CREATE PROCEDURE [seg].[ResourcePaginated]
		@Id UNIQUEIDENTIFIER,
		@Nome VARCHAR(50),
		@Chave VARCHAR(100),
		@Route VARCHAR(200),
		@Menu BIT,
		@IsSubMenu BIT,
		@RecursoIdPai UNIQUEIDENTIFIER,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[RecursoId]					AS Identifier
      			,[T].[Nome]
      			,[T].[Chave]
      			,[T].[ToolTip]
      			,[T].[Route]
      			,[T].[Menu]
      			,[T].[RecursoIdPai]
      			,[T].[Ordem]
      			,[T].[Ativo]
      			,[T].[Type]
      			,[T].[Icon]
      			,[T].[Path]
      			,[T].[IsSubMenu]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([rs].[RecursoId]) 	AS 	Blocked
      				,[rs].[RecursoId]
      				,[rs].[Nome]
      				,[rs].[Chave]
      				,[rs].[ToolTip]
      				,[rs].[Route]
      				,[rs].[Menu]
      				,[rs].[RecursoIdPai]
      				,[rs].[Ordem]
      				,[rs].[Ativo]
      				,[rs].[Type]
      				,[rs].[Icon]
      				,[rs].[Path]
      				,[rs].[IsSubMenu]
      				FROM [APDBDev].[seg].[Recursos] 	[rs]	
				WHERE 		([rs].[RecursoId]					=		  @Id					OR	@Id 				IS NULL)
				AND 		([rs].[Nome]			  		  LIKE  '%' + @Nome + '%'			OR	@Nome				IS NULL)
				AND 		([rs].[Chave]			  		  LIKE  '%' + @Chave + '%'			OR	@Chave				IS NULL)
				AND 		([rs].[Route]			  		  LIKE  '%' + @Route + '%'			OR	@Route				IS NULL)
				AND 		([rs].[Menu]						=		  @Menu					OR	@Menu				IS NULL)
				AND 		([rs].[IsSubMenu]					=		  @IsSubMenu			OR	@IsSubMenu			IS NULL)
				AND 		([rs].[RecursoIdPai]				=		  @RecursoIdPai			OR	@RecursoIdPai		IS NULL)
				AND 		([rs].[Ativo]						=		  @Ativo				OR	@Ativo				IS NULL)
				ORDER BY 	[rs].[RecursoId] DESC
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
-- Procedure [seg].[WorkflowPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 12/08/2024
	-- THIS PROCEDURE RETURNS WORKFLOW UMBLOCKED PAGINATED
	CREATE PROCEDURE [seg].[WorkflowPaginated]
		@Id UNIQUEIDENTIFIER,
		@TipoWorkflowId INT,
		@StatusAprovacaoId INT,
		@UsuarioResponsavel UNIQUEIDENTIFIER,
		@UsuarioResponsavelAprovacao UNIQUEIDENTIFIER,
		@Descricao VARCHAR(50),
		@DataWorkflowVerificacao DATETIME,
		@UserId UNIQUEIDENTIFIER,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
      			[T].[WorkflowId]				AS Identifier
      			,[T].[TipoWorkflowId]
      			,[T].[StatusAprovacaoId]
      			,[T].[UsuarioResponsavel]
				,[T].[UsuarioResponsavelAprovacao]
      			,[T].[Observacao]
      			,[T].[Descricao]
      			,[T].[DataWorkflowVerificacao]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[Ativo]
			FROM (
				SELECT
					[dbo].[FNCReturnIsItemcked] ([wf].[WorkflowId]) 	AS 	Blocked
      				,[wf].[WorkflowId]
      				,[wf].[TipoWorkflowId]
      				,[wf].[StatusAprovacaoId]
      				,[wf].[UsuarioResponsavel]
					,[wf].[UsuarioResponsavelAprovacao]
      				,[wf].[Observacao]
      				,[wf].[Descricao]
      				,[wf].[DataWorkflowVerificacao]
      				,[wf].[UsuarioInclusaoId]
      				,[wf].[UsuarioUltimaAlteracaoId]
      				,[wf].[DataInclusao]
      				,[wf].[DataUltimaAlteracao]
      				,[wf].[Ativo]
      				FROM [APDBDev].[seg].[Workflows] 	[wf]	
				WHERE 		([wf].[WorkflowId]						=		  @Id							OR	@Id 						IS NULL)
				AND 		([wf].[TipoWorkflowId]					=		  @TipoWorkflowId				OR	@TipoWorkflowId				IS NULL)
				AND 		([wf].[StatusAprovacaoId]				=		  @StatusAprovacaoId			OR	@StatusAprovacaoId			IS NULL)
				AND 		([wf].[UsuarioResponsavel]				=		  @UsuarioResponsavel			OR	@UsuarioResponsavel			IS NULL)
				AND 		([wf].[UsuarioResponsavelAprovacao]		=		  @UsuarioResponsavelAprovacao	OR	@UsuarioResponsavelAprovacao IS NULL)
				AND 		([wf].[Descricao]			  		  LIKE  '%' + @Descricao + '%'				OR	@Descricao					IS NULL)
				AND 		([wf].[DataWorkflowVerificacao]			=		  @DataWorkflowVerificacao		OR	@DataWorkflowVerificacao	IS NULL)
				AND 		([wf].[Ativo]							=		  @Ativo						OR	@Ativo						IS NULL)
				AND			([wf].[UsuarioInclusaoId] 				= 		  @UserId						OR [seg].[FNCReturnUsersIsASystemAdmin] (@UserId) = 1 OR @UserId IS NULL)
				ORDER BY 	[wf].[DataInclusao] DESC
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
-- REGION STORED PROCEDURE - END
-- -----------------------------------------------------

-- -----------------------------------------------------
-- REGION SEED DATABASE
-- -----------------------------------------------------

-- This regions will feed the inicial information that system needs to woks

-- -----------------------------------------------------
-- Feed table [seg].[Grupos]
-- -----------------------------------------------------

INSERT INTO [seg].[Grupos] ([GrupoId], [Descricao], [DataInclusao], [DataUltimaAlteracao], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [Ativo])
VALUES('59647e61-db07-4b43-993d-3f7eda18fe7f', 'System', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1),
('cb4ba730-222c-4b05-bb56-c2fec255bd9d', 'Master', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1),
('5877361c-6f05-41f6-a60d-7c7daa0feb64', 'User', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[Usuarios]
-- -----------------------------------------------------

INSERT INTO [seg].[Usuarios]([UsuarioId], [Login], [GrupoId], [NmrDocumento], [TipoDocumentoId], [Senha], [Nome], [DataNascimento], [Sexo], [EstadoCivil], [Email], [Bloqueado], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [DataInclusao], [DataUltimaAlteracao], [DataUltimaTrocaSenha], [DataUltimoLogin], [Ativo])
VALUES ('9a5f0c64-8103-4ee1-8acd-84b28090d898', 'System', '59647e61-db07-4b43-993d-3f7eda18fe7f', '00000000000', 1, '$@#$@#$FWSDWERFSSDFSDFF%Dss==', 'System', GETDATE(), 'N', 'N', 'system@appmkt.com.br', 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1),
('d2a833de-5bb4-4931-a3c2-133c8994072a', 'Master', 'cb4ba730-222c-4b05-bb56-c2fec255bd9d', '00000000000', 1, '@M45ter', 'Master', GETDATE(), 'N', 'N', 'master@appmkt.com.br', 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [dbo].[Produtos]
-- -----------------------------------------------------

INSERT INTO APDBDev.dbo.Produtos
(ProdutoId, TipoProdutoId, Titulo, Detalhes, ResumoDetalhes, CodigoBarras, Marca, Quantidade, IsIlimitado, QuantidadeCritica, PrecoCusto, PrecoVenda, Score, Relevance, Peso, Altura, Largura, Comprimento, Bloqueado, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInclusao, DataUltimaAlteracao, Ativo, VendedorId)
VALUES(N'BB27FD71-648F-4F70-E4A4-08DC7681957E', 0, 'Cesta de chocolates personalizada', 'Cesta de chocolates personalizada', 'Cesta de chocolates personalizada com diversos chocolates, chocotone.', N'', N'', 120, 0, 10, 150.01, 205.50, 4.90, 4.95, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898');

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

GO

-- ADDING PRODUCTS
INSERT INTO APDBDev.dbo.Produtos
(ProdutoId, TipoProdutoId, Titulo, Detalhes, ResumoDetalhes, CodigoBarras, Marca, Quantidade, IsIlimitado, QuantidadeCritica, PrecoCusto, PrecoVenda, Score, Relevance, Peso, Altura, Largura, Comprimento, Bloqueado, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInclusao, DataUltimaAlteracao, Ativo, VendedorId)
VALUES
(N'253BED7B-CAC9-4309-AA6C-0BBDFFEA3BE4', 0, 'Forno Microondas 220V', 'Forno Microondas 220V', 'Forno Microondas 220V', N'', N'', 120, 0, 10, 500.01, 560.01, 5.00, 5.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'3C8CD641-8A05-410D-B767-0AAA56780229', 0, 'Forno Microondas 110V', 'Forno Microondas 110V', 'Forno Microondas 110V', N'', N'', 120, 0, 10, 500.01, 560.01, 4.90, 4.90, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'F55218E2-B6BE-48FE-9D36-093CB6C55A5F', 0, 'Caixa de fom JBL', 'Caixa de fom JBL', 'Caixa de fom JBL', N'', N'', 120, 0, 10, 2000.10, 2600.99, 4.80, 4.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'810CA71B-CF2C-4E80-A77B-094559C8A02D', 0, 'Caixa de fom Sony', 'Caixa de fom Sony', 'Caixa de fom JBL', N'', N'', 120, 0, 10, 2000.10, 2600.99, 4.70, 4.70, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'C8A81D50-264A-40C4-B139-00EEEA87BF18', 0, 'Teclado Yamaha PXS210', 'Teclado Yamaha PXS210', 'Teclado Yamaha PXS210', N'', N'', 120, 0, 10, 1200.10, 1680.99, 4.60, 4.60, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S24 Ultra', 'Smarth fone galaxy S24 Ultra', 'Smarth fone galaxy S24 Ultra', N'', N'', 120, 0, 10, 5000.10, 6100.99, 5.00, 5.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S24', 'Smarth fone galaxy S24', 'Smarth fone galaxy S24', N'', N'', 120, 0, 10, 4800.10, 5600.99, 4.95, 4.95, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S23 Ultra', 'Smarth fone galaxy S23 Ultra', 'Smarth fone galaxy S23 Ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4600.10, 5500.99, 4.95, 4.95, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S23', 'Smarth fone galaxy S23', 'Smarth fone galaxy S23 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4400.10, 5200.99, 4.90, 4.90, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S22 Ultra', 'Smarth fone galaxy S22 Ultra', 'Smarth fone galaxy S22 ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4200.10, 4900.99, 4.85, 4.85, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S22', 'Smarth fone galaxy S22', 'Smarth fone galaxy S22 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4800.10, 5600.99, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S21 Ultra', 'Smarth fone galaxy S21 Ultra', 'Smarth fone galaxy S21 Ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4500.10, 5400.99, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S21', 'Smarth fone galaxy S21', 'Smarth fone galaxy S21 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4300.10, 5200.99, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S20 Ultra', 'Smarth fone galaxy S20 Ultra', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4300.10, 5200.99, 4.70, 4.70, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S20', 'Smarth fone galaxy S21', 'Smarth fone galaxy S20 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4200.10, 5100.99, 4.70, 4.70, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10 Ultra', 'Smarth fone galaxy S10 Ultra', 'Smarth fone galaxy S10 Ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4100.10, 5100.99, 4.65, 4.65, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10 Plus', 'Smarth fone galaxy S10 Plus', 'Smarth fone galaxy S10 plus ficha tecnica abreviada', N'', N'', 120, 0, 10, 4000.10, 5000.99, 4.60, 4.60, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('df0d97a9-922e-41ab-8619-1782d45d2585', 0, 'Smarth fone galaxy S10 Blocked 1', 'Smarth fone galaxy S10 Blocked 1', 'Smarth fone galaxy S10 Blocked 1 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('5dd30a70-2c84-4699-9752-1b60bfdd72bc', 0, 'Smarth fone galaxy S10 Blocked 2', 'Smarth fone galaxy S10 Blocked 2', 'Smarth fone galaxy S10 Blocked 2 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('3ab620e8-4631-4c07-a65f-3fe6c55435a5', 0, 'Smarth fone galaxy S10 Blocked 3', 'Smarth fone galaxy S10 Blocked 3', 'Smarth fone galaxy S10 Blocked 3 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('72813eed-6d5d-44d4-97fa-f1807aa729b0', 0, 'Smarth fone galaxy S10 Plus Blocked Permanente 1', 'Smarth fone galaxy S10 Blocked Permanente 1', 'Smarth fone galaxy S10 Blocked Permanente 1 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('53581e36-5f3d-4752-bba7-d1626c81729a', 0, 'Smarth fone galaxy S10 Plus Blocked Permanente 2', 'Smarth fone galaxy S10 Blocked Permanente 2', 'Smarth fone galaxy S10 Blocked Permanente 2 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('56b5e909-65ed-4e9b-b3cc-6785200b5dc2', 0, 'Smarth fone galaxy S10 Plus Blocked Permanente 3', 'Smarth fone galaxy S10 Blocked Permanente 3', 'Smarth fone galaxy S10 Blocked Permanente 3 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('9189eaa5-d8c2-44e1-845e-e127e9c484b1', 0, 'Capinha Smarth fone galaxy S10', 'Capinha Smarth fone galaxy S10', 'Capinha Preta Smarth fone galaxy S10 abreviada', N'', N'', 120, 0, 10, 20.01, 25.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898');

GO

-- ADDING PRODUCT SHOPPING CART
INSERT INTO APDBDev.dbo.ShoppingCart
(ShoppingCartId, UsuarioId, ProdutoId, UsuarioInclusaoId, DataInclusao)
VALUES(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'253BED7B-CAC9-4309-AA6C-0BBDFFEA3BE4', '9a5f0c64-8103-4ee1-8acd-84b28090d898',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'3C8CD641-8A05-410D-B767-0AAA56780229', '9a5f0c64-8103-4ee1-8acd-84b28090d898',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'F55218E2-B6BE-48FE-9D36-093CB6C55A5F', '9a5f0c64-8103-4ee1-8acd-84b28090d898',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'810CA71B-CF2C-4E80-A77B-094559C8A02D', '9a5f0c64-8103-4ee1-8acd-84b28090d898',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'C8A81D50-264A-40C4-B139-00EEEA87BF18', '9a5f0c64-8103-4ee1-8acd-84b28090d898',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'BB27FD71-648F-4F70-E4A4-08DC7681957E', '9a5f0c64-8103-4ee1-8acd-84b28090d898',GETDATE());

GO

-- ADDING BLOCK
INSERT INTO APDBDev.dbo.Bloqueios
(BloqueioId, TipoBloqueioId, NomeBloqueio, Permanente, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInicio, DataFim, DataInclusao, DataUltimaAlteracao, Detalhes, Ativo)
VALUES
('b853394f-2034-4e36-9efa-64ffd006770b', 0, 'Bloqueio - Smarth fone galaxy S10 Blocked', 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, '2020-01-01', '2025-01-01', GETDATE(), NULL, 'Bloqueio - Smarth fone galaxy S10 Blocked Detalhes', 1),
('7629714d-ffed-4298-adf5-417c9b703ff6', 0, 'Bloqueio - TESTE BLOQUEIO 2', 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, '2020-01-01', '2025-01-01', GETDATE(), NULL, 'Bloqueio - Smarth fone galaxy S10 Blocked Detalhes', 1),
('d5a8620a-d089-48e3-bc00-8ab227c40b90', 0, 'Bloqueio - Smarth fone galaxy S10 Plus Blocked Permanente', 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', NULL, NULL, NULL, GETDATE(), NULL, 'Bloqueio - Smarth fone galaxy S10 Blocked Detalhes', 1);

-- ADDING USER TO PRODUCTS
INSERT INTO APDBDev.dbo.BloqueiosItens
(BloqueioItemId, BloqueioId, ItemId)
VALUES
(NEWID(), 'b853394f-2034-4e36-9efa-64ffd006770b', 'df0d97a9-922e-41ab-8619-1782d45d2585'),
(NEWID(), 'd5a8620a-d089-48e3-bc00-8ab227c40b90', '72813eed-6d5d-44d4-97fa-f1807aa729b0');

-- ADDING END
INSERT INTO APDBDev.dbo.Enderecos
(EnderecoId, TipoEnderecoId, Logradouro, Numero, Complemento, Bairro, Cidade, Estado, CEP, PontoReferencia, UsuarioInclusaoId, DataInclusao, IsPrincipal, Ativo)
VALUES
('68a3c26e-6569-4e3e-ac70-fef24ec9f91b', 1, 'Desembargador Plinio de Carvalho Pinto', '97', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11442000', 'Hortifruti Betel', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1, 1),
('d10424c6-200d-4a3f-9451-7c3f7c88304d', 1, 'TESTE BLOQUEIO 1', '90', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11443080', 'Hortifruti Betel', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1, 1),
('17b8af41-3634-47e5-8d50-6f4b2a7b2e4f', 1, 'TESTE BLOQUEIO 2', '90', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11443080', 'Hortifruti Betel', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1, 1),
('3e9c33e1-7afd-4e2d-a2a3-c24d4102c1b6', 1, 'Av Guaruja Teste END sem USER', '90', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11443080', 'Hortifruti Betel', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1, 1),
('75eea234-45aa-431c-b765-c737fc8c778e', 1, 'Test end purchaser faria lima', '90', 'APTO 10', 'Faria Lima', 'Sao Paulo', 'SP', '01451000', 'Hortifruti Betel', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1, 1);

-- ADDING USER TO ADRESS
INSERT INTO APDBDev.dbo.EnderecosUsuarios
(EnderecoUsuarioId, EnderecoId, UsuarioId)
VALUES
(NEWID(), '68a3c26e-6569-4e3e-ac70-fef24ec9f91b', 'd2a833de-5bb4-4931-a3c2-133c8994072a'),
(NEWID(), 'd10424c6-200d-4a3f-9451-7c3f7c88304d', '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), '17b8af41-3634-47e5-8d50-6f4b2a7b2e4f', '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), '3e9c33e1-7afd-4e2d-a2a3-c24d4102c1b6', '9a5f0c64-8103-4ee1-8acd-84b28090d898');

-- ADDING USER TO PRODUCTS
INSERT INTO APDBDev.dbo.BloqueiosItens
(BloqueioItemId, BloqueioId, ItemId)
VALUES
(NEWID(), '7629714d-ffed-4298-adf5-417c9b703ff6', 'd10424c6-200d-4a3f-9451-7c3f7c88304d');

-- ADDING MERCADO PAGO GARANTIAS
INSERT INTO APDBDev.dbo.Garantias
(GarantiaId, TipoGarantia, Descricao, Detalhes, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('4884f1f5-e119-49e6-a394-b3289a2bf539', 1, 'Compra Garantida', 'É um programa que garante o reembolso do dinheiro no caso de alguma contingência ao receber a compra', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- ADDING MERCADO PAGO LANCAMENTO TESTE
INSERT INTO APDBDev.dbo.Lancamentos
(LancamentoId, TipoLancamento, [Status], Referencia, ValorLancamento, DataBaixa, Observacao, UsuarioIdBaixa, LancamentoIdPai, QtdeParcelas, NmrParcela, ValorParcela, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('42f442b0-7cc4-4e0c-b693-e594ea3a1728', 2, 9999999, 'Lançamento mercado pago teste', 10.00, GETDATE(), 'Lançamento mercado pago teste', '9a5f0c64-8103-4ee1-8acd-84b28090d898', '42f442b0-7cc4-4e0c-b693-e594ea3a1728', 1, 1, 10.00, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- INSERT ENTREGA EM MAOS
INSERT INTO APDBDev.dbo.Entregas
(EntregaId, TipoEntrega, [Status], ValorTotal, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('f5c91ff9-075d-4723-baac-a1cb8e7e41b2', 0, 7, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- INSERT ENTREGA LOJA MTK PLACE
INSERT INTO APDBDev.dbo.Entregas
(EntregaId, TipoEntrega, [Status], ValorTotal, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('86c9efc9-9812-442d-a8b5-8fed62a3f35c', 6, 7, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- INSERT ENTREGA EM TERCEIRO
INSERT INTO APDBDev.dbo.Entregas
(EntregaId, TipoEntrega, [Status], ValorTotal, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('48d51e3a-6f27-4916-94b9-e9ad53c9e8bb', 6, 7, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- COMPRADOR TESTE
INSERT INTO [seg].[Usuarios]([UsuarioId], [Login], [GrupoId], [NmrDocumento], [TipoDocumentoId], [Senha], [Nome], [DataNascimento], [Sexo], [EstadoCivil], [Email], [Bloqueado], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [DataInclusao], [DataUltimaAlteracao], [DataUltimaTrocaSenha], [DataUltimoLogin], [Ativo])
VALUES ('e0d83b70-39f3-4909-ad74-d44208520029', 'purchaser', '5877361c-6f05-41f6-a60d-7c7daa0feb64', '00000000000', 1, '$@#$@#$FWSDWERFSSDFSDFF%Dss==', 'Purchaser Test', GETDATE(), 'N', 'N', 'purchaser@appmkt.com.br', 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1);

-- ADDING USER TO ADRESS
INSERT INTO APDBDev.dbo.EnderecosUsuarios
(EnderecoUsuarioId, EnderecoId, UsuarioId)
VALUES
(NEWID(), '75eea234-45aa-431c-b765-c737fc8c778e', 'e0d83b70-39f3-4909-ad74-d44208520029');

-- ADDING USER MASTER ADDRESS
INSERT INTO APDBDev.dbo.EnderecosUsuarios
(EnderecoUsuarioId, EnderecoId, UsuarioId)
VALUES
(NEWID(), '68a3c26e-6569-4e3e-ac70-fef24ec9f91b', 'd2a833de-5bb4-4931-a3c2-133c8994072a');

-- ADDING LANCAMENTO PURCHASE PENDING TEST
INSERT INTO APDBDev.dbo.Lancamentos
(LancamentoId, TipoLancamento, [Status], Referencia, ValorLancamento, Observacao, LancamentoIdPai, QtdeParcelas, NmrParcela, ValorParcela, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES
('9ba6aba5-0d1f-431d-975c-520b56fb383d', 2, 0, 'Release Credit Approved Test', 60.50, 'Release Credit Approved Test', '42f442b0-7cc4-4e0c-b693-e594ea3a1728', 1, 1, 60.50, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1),
('0389e309-5976-486f-aa30-555a4577ccbf', 2, 0, 'Release Credit Pending Test', 3361.98, 'Release Credit Pending Test', '42f442b0-7cc4-4e0c-b693-e594ea3a1728', 1, 1, 3361.98, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- INSERT PURCHASE PENDING TEST
INSERT INTO APDBDev.dbo.Compras
(CompraId, CodigoCompra, CompradorId, FormaPagamento, Status, EntregaId, LancamentoPaiId, GarantiaId, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES
('1a7f3db4-e82b-4ff9-98a7-68559b88f19b', '1318687938', 'e0d83b70-39f3-4909-ad74-d44208520029', 3, 0, 'f5c91ff9-075d-4723-baac-a1cb8e7e41b2', '9ba6aba5-0d1f-431d-975c-520b56fb383d', '4884f1f5-e119-49e6-a394-b3289a2bf539', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1),
('2a7f3db4-e82b-4ff9-98a7-68559b88f1a0', '123456', 'e0d83b70-39f3-4909-ad74-d44208520029', 3, 0, 'f5c91ff9-075d-4723-baac-a1cb8e7e41b2', '0389e309-5976-486f-aa30-555a4577ccbf', '4884f1f5-e119-49e6-a394-b3289a2bf539', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- COMPRA PRODUTOS RELACIONADOS
INSERT INTO APDBDev.dbo.ComprasProdutos
(CompraProdutoId, CompraId, ProdutoId, Quantidade, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES
('d01943d9-e459-4b21-841a-68c37f3a6e3e', '1a7f3db4-e82b-4ff9-98a7-68559b88f19b', 'df0d97a9-922e-41ab-8619-1782d45d2585', 2, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1),
('d01943d9-e459-4b21-841b-61c37f3a6130', '1a7f3db4-e82b-4ff9-98a7-68559b88f19b', '53581e36-5f3d-4752-bba7-d1626c81729a', 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1),
('d01943d9-e459-4b21-841a-68c37f3a6e31', '2a7f3db4-e82b-4ff9-98a7-68559b88f1a0', 'df0d97a9-922e-41ab-8619-1782d45d2585', 3, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1),
('d01943d9-e459-4b21-841b-61c37f3a6132', '2a7f3db4-e82b-4ff9-98a7-68559b88f1a0', '53581e36-5f3d-4752-bba7-d1626c81729a', 4, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1)
;

-- COMPRADOR TESTE
INSERT INTO [seg].[Usuarios]([UsuarioId], [Login], [GrupoId], [NmrDocumento], [TipoDocumentoId], [Senha], [Nome], [DataNascimento], [Sexo], [EstadoCivil], [Email], [Bloqueado], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [DataInclusao], [DataUltimaAlteracao], [DataUltimaTrocaSenha], [DataUltimoLogin], [Ativo])
VALUES ('e0d83b70-39f3-4909-ad74-d44208520029', 'purchaser2', '5877361c-6f05-41f6-a60d-7c7daa0feb64', '00000000002', 1, '$@#$@#$FWSDWERFSSDFSDFF%Dss==', 'Purchaser Test 2', GETDATE(), 'N', 'N', 'purchaser2@appmkt.com.br', 0, '2BA5FFD6-94EF-41BD-BB6D-08DCB17F6F0D', '2BA5FFD6-94EF-41BD-BB6D-08DCB17F6F0D', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1);