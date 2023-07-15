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
	    [GrupoId] CHAR(36) NOT NULL PRIMARY KEY,
	    [Grupo] [varchar](50) NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
		[UsuarioId] CHAR(36) NOT NULL PRIMARY KEY,
		[Usuario] [varchar](50) NOT NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumento] INT NOT NULL,
		[Senha] [varchar](max) NOT NULL,
		[Nome] [varchar](100) NOT NULL,
		[DataNascimento] [datetime] NULL,
		[Sexo] [varchar](1) NULL,
		[EstadoCivil] [varchar](2) NULL,
		[Email] [varchar](255) NOT NULL,
		[TrocaSenha] [bit] NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[DataUltimaTrocaSenha] [datetime] NULL,
		[DataUltimoLogin] [datetime] NULL,
		[NmrTelefone] VARCHAR(12) NOT NULL,
		[Ativo] [bit] NOT NULL
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
		[RecursoId] CHAR(36) NOT NULL PRIMARY KEY,
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
		[GrupoRecursoId] CHAR(36) NOT NULL PRIMARY KEY,
		[GrupoId] CHAR(36) NOT NULL,
		[RecursoId] CHAR(36) NOT NULL,
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
		[GrupoUsuarioId] CHAR(36) NOT NULL PRIMARY KEY,
		[GrupoId] CHAR(36) NOT NULL,
		[UsuarioId] CHAR(36) NOT NULL,
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
	    [WorkFlowId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoWorkflow] INT NOT NULL,
		[StatusAprovacaoId] INT NOT NULL,
	    [UsuarioResponsavel] INT NOT NULL,
		[DataWorkFlow] DATETIME NOT NULL,
		[Observacao] VARCHAR(MAX) NULL,
		[DataWorkFlowVerificacao] DATETIME NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
		[FormaPagamentoId] CHAR(36) NOT NULL PRIMARY KEY,
		[Descricao] [varchar](50) NOT NULL,
		[PermiteParcelar] [bit] NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
		[ProdutoId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoProduto] INT NOT NULL,
		[Descricao] VARCHAR(150) NOT NULL,
		[CodigoBarras] VARCHAR(50) NULL,
		[Marca] VARCHAR(MAX) NULL,
		[Quantidade] INT NOT NULL,
		[Peso] INT NULL,
		[IsIlimitado] BIT NOT NULL,
		[QuantidadeCritica] INT NULL,
		[PrecoCusto] DECIMAL(10,2) NOT NULL,
		[PrecoVenda] DECIMAL(10,2) NOT NULL,
		[MargemLucro] DECIMAL(10,2) NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
    	[CaracteristicaId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoCaracteristica] INT NOT NULL,
    	[Descricao] VARCHAR(MAX) NOT NULL,
    	[Ordem] INT NULL,
    	[Publico] BIT NOT NULL,
    	[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
-- Table [dbo].[Imagens]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Imagens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Imagens] (
  		[ImagemId] CHAR(36) NOT NULL PRIMARY KEY,
		[Path] VARCHAR(100) NOT NULL,
    	[Descricao] VARCHAR(50) NOT NULL,
		[ImagemPrincipal] BIT NOT NULL,
		[Publico] BIT NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
-- Table [dbo].[Avaliacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Avaliacoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Avaliacoes] (
  		[AvaliacaoId] CHAR(36) NOT NULL PRIMARY KEY,
		[ProdutoId] CHAR(36) NOT NULL,
		[VendedorId] CHAR(36) NOT NULL,
    	[Descricao] VARCHAR(MAX) NOT NULL,
		[Valor] DECIMAL(10, 2) NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
-- Table [dbo].[Enderecos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Enderecos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Enderecos] (
  		[EnderecoId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoEndereco] INT NOT NULL,
		[Logradouro] VARCHAR(50) NOT NULL,
		[Numero] VARCHAR(10) NOT NULL,
		[Complemento] VARCHAR(10) NULL,
		[Bairro] VARCHAR(30) NULL,
		[Cidade] VARCHAR(30) NOT NULL,
		[Estado] VARCHAR(2) NOT NULL,
		[CEP] VARCHAR(8) NOT NULL,
		[PontoReferencia] VARCHAR(100) NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
-- Table [dbo].[Vendas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Vendas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Vendas] (
  		[VendaId] CHAR(36) NOT NULL PRIMARY KEY,
  		[UsuarioId] CHAR(36) NOT NULL,
  		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
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
-- Table [dbo].[Lancamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Lancamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Lancamentos] (
		[LancamentoId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoLancamento] INT NOT NULL,
		[UsuarioId] CHAR(36) NOT NULL,
		[Situacao] INT NOT NULL,
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
		[ValorParcela] DECIMAL(10, 2) NULL
		CONSTRAINT [FK_Lancamentos_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
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
  		[GarantiaId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoGarantia] CHAR(36) NOT NULL,
		[Descricao] VARCHAR(50) NOT NULL,
		[Detalhes] VARCHAR(MAX) NOT NULL,
		[Periodo] VARCHAR(20)  NULL,
		[Inicio] [datetime] NULL,
		[Fim] [datetime] NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
   		[NotaFiscalId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoNotaFiscal] INT NOT NULL
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
  		[EmailId] CHAR(36) NOT NULL PRIMARY KEY,
		[UsuarioEnvioId] CHAR(36) NOT NULL,
		[TipoEmail] INT NOT NULL,
		[NomeEmail] VARCHAR(100) NULL,
      	[Destinatario] VARCHAR(150) NOT NULL,
      	[Assunto] VARCHAR(100) NULL,
      	[Mensagem] VARCHAR(MAX) NOT NULL,
      	[Html] BIT NOT NULL,
      	[StatusEnvio] INT NOT NULL,
      	[Tentativas] INT NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
  		[MensagemId] CHAR(36) NOT NULL PRIMARY KEY,
		[RemetenteId] CHAR(36) NOT NULL,
		[Mensagem] VARCHAR(MAX) NOT NULL,
		[TipoMensagem] INT NOT NULL,
		[IsHtml] BIT NOT NULL,
		[DestinatarioId] INT NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
  		[EntregaId] CHAR(36) NOT NULL PRIMARY KEY,
		[ResponsavelEntregaId] CHAR(36) NOT NULL,
		[TipoEntrega] INT NOT NULL,
		[DataPrevistaEntrega] DATETIME NOT NULL,
		[DataEfetivaEnrega] DATETIME NULL,
		[NmrDocumento] VARCHAR(50) NOT NULL,
		[TipoDocumento] INT NOT NULL,
		[NomeRecebedor] VARCHAR(100) NOT NULL,
		[isEntregueTitular] BIT NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL
		CONSTRAINT [FK_Entregas_ResponsavelEntregaId] FOREIGN KEY([ResponsavelEntregaId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
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
  		[BloqueioId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoBloqueio] INT NOT NULL,
		[ItemBloqueadoId] INT NOT NULL,
		[NomeBloqueio] VARCHAR(100) NOT NULL,
		[isBloqueiaAcesso] BIT NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
		[DataInicio] [datetime] NULL,
		[DataFim] [datetime] NULL,
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
-- Table [dbo].[DadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[DadosBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[DadosBancarios] (
  		[DadoBancarioId] CHAR(36) NOT NULL PRIMARY KEY,
		[UsuarioId] CHAR(36) NOT NULL,
		[Banco] VARCHAR(100) NOT NULL,
		[Agencia] VARCHAR(6) NOT NULL,
		[Conta] VARCHAR(20) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
  		[CartaoBancarioId] CHAR(36) NOT NULL PRIMARY KEY,
		[UsuarioId] CHAR(36) NOT NULL,
		[Numero] VARCHAR(16) NOT NULL,
		[NomeNoCartao] VARCHAR(50) NOT NULL,
		[Bandeira] VARCHAR(10) NOT NULL,
		[Validade] VARCHAR(6) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[CodSeg] VARCHAR(3) NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
  		[ConfiguracaoId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoConfiguracao] INT NOT NULL,
		[Descricao] VARCHAR(150) NOT NULL,
		[UsuarioInclusaoId] CHAR(36) NOT NULL,
		[UsuarioUltimaAlteracaoId] CHAR(36) NULL,
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
		[ParametroId] CHAR(36) NOT NULL PRIMARY KEY,
		[TipoParametro] INT NOT NULL,
		[TipoDado] INT NOT NULL,
	  	[Descricao] [varchar](100) NOT NULL,
	  	[Valor] [varchar](max) NOT NULL,
	  	[Publico] [bit] NOT NULL,
	  	[Ativo] [bit] NOT NULL
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
  		[PagamentoId] CHAR(36) NOT NULL PRIMARY KEY,
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
		[ConfiguracaoParametroId] CHAR(36) NOT NULL PRIMARY KEY,
		[ParametroId] CHAR(36) NOT NULL,
		[ConfiguracaoId] CHAR(36) NOT NULL,
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
  		[UsuarioLancamentoId] CHAR(36) NOT NULL PRIMARY KEY,
  		[LancamentoId] CHAR(36) NOT NULL,
		[UsuarioId] CHAR(36) NOT NULL,
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
  		[UsuarioDadoBancarioId] CHAR(36) NOT NULL PRIMARY KEY,
  		[UsuarioId] CHAR(36) NOT NULL,
  		[DadoBancarioId] CHAR(36) NOT NULL,
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
  		[CompraId] CHAR(36) NOT NULL PRIMARY KEY,
		[CodigoCompra] VARCHAR(20) NULL,
		[CodigoPagamento] VARCHAR(20) NULL,
  		[ProdutoId] CHAR(36) NOT NULL,
  		[CompradorId] CHAR(36) NOT NULL,
		[FormaPagamento] INT NOT NULL,
		[StatusCompra] INT NOT NULL,
		[EntregaId] CHAR(36) NULL,
		[LancamentoPaiId] CHAR(36) NOT NULL,
		[EnderecoId] CHAR(36) NOT NULL,
		[GarantiaId] CHAR(36) NOT NULL,
		[VendedorId] CHAR(36) NOT NULL,
		[AvaliacaoId] CHAR(36) NOT NULL,
		[IsPago] BIT NOT NULL,
		[IsEntregue] BIT NOT NULL,
		[IsAvaliado] BIT NOT NULL,
		[Ativo] BIT NOT NULL,
		CONSTRAINT [FK_Compras_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_Compras_CompradorId] FOREIGN KEY([CompradorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
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
		[LogId] CHAR(36) NOT NULL PRIMARY KEY,
		[Message] VARCHAR(MAX) NOT NULL,
		[Request] VARCHAR(150) NOT NULL,
		[Method] VARCHAR(10) NOT NULL,
		[Response] INT,
		[UserAddedId] CHAR(36) NOT NULL,
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
-- Procedure [seg].[UsuariosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [seg].[UsuariosPaginated]
		@Id CHAR(36),
		@Nome VARCHAR(MAX),
		@NmrDocumento VARCHAR(MAX),
		@Email VARCHAR(MAX),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT
				[UsuarioId]
      			,[Usuario]
      			,[NmrDocumento]
				,[NmrTelefone]
      			,[TipoDocumento]
      			,[Senha]
      			,[Nome]
      			,[DataNascimento]
      			,[Sexo]
      			,[EstadoCivil]
      			,[Email]
      			,[TrocaSenha]
      			,[Bloqueado]
      			,[UsuarioInclusaoId]
      			,[UsuarioUltimaAlteracaoId]
      			,[DataInclusao]
      			,[DataUltimaAlteracao]
      			,[DataUltimaTrocaSenha]
      			,[DataUltimoLogin]
      			,[Ativo]
  			FROM [APDBDev].[seg].[Usuarios]
			WHERE 		([UsuarioId] = @Id OR @Id IS NULL)
			AND 		([Nome] LIKE '%' +@Nome+ '%' OR @Nome IS NULL)
			AND 		([NmrDocumento] = @NmrDocumento OR @NmrDocumento IS NULL)
			AND 		([Email] = @Email OR @Email IS NULL)
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
-- Feed table [seg].[Usuarios]
-- -----------------------------------------------------

INSERT INTO APDBDev.seg.Usuarios (UsuarioId, Usuario, NmrDocumento, TipoDocumento, Senha, Nome, DataNascimento, Sexo, EstadoCivil, Email, TrocaSenha, Bloqueado, UsuarioInclusaoId, DataInclusao, NmrTelefone, Ativo)
VALUES('9a5f0c64-8103-4ee1-8acd-84b28090d898', 'System', '00000000000', 0, 'SENHASECRETA', 'System', GETDATE(), 'S', 'S', 'system@appmkt.com.br', 0, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), '999999999', 0),
('9a5f0c6a-0003-4ee5-8acd-10b28090da00', 'alesssandrocomprador', '00000000000', 0, 'SENHASECRETA', 'alessandro comprador', GETDATE(), 'S', 'S', 'professor_alessandro@hotmail.com', 0, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), '999999999', 0)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[Grupos]
-- -----------------------------------------------------

INSERT INTO [seg].[Grupos] ([GrupoId], [Grupo], [DataInclusao], [UsuarioInclusaoId], [Ativo])
VALUES('59647e61-db07-4b43-993d-3f7eda18fe7f','System', GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[GruposUsuarios]
-- -----------------------------------------------------

INSERT INTO [seg].[GruposUsuarios] ([GrupoUsuarioId], [GrupoId], [UsuarioId])
VALUES(NEWID() ,'59647e61-db07-4b43-993d-3f7eda18fe7f', '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID() ,'59647e61-db07-4b43-993d-3f7eda18fe7f', '9a5f0c6a-0003-4ee5-8acd-10b28090da00')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[GruposUsuarios]
-- -----------------------------------------------------

INSERT INTO [dbo].[Produtos] (ProdutoId , TipoProduto, Descricao, CodigoBarras, Marca, Quantidade, IsIlimitado, QuantidadeCritica, PrecoCusto, PrecoVenda, MargemLucro, Bloqueado, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('6ef793f6-0d6c-4a1a-a09d-1205f9986e74', 1, 'TESTE1', '12345678910', 'TESTE', 100, 0, 5, 10.00, 15.00, 20, 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [dbo].[Entregas] LANCAMENTO DO SISTEMA
-- -----------------------------------------------------
INSERT INTO APDBDev.dbo.Lancamentos
(LancamentoId, TipoLancamento, UsuarioId, Situacao, Referencia, Observacao)
VALUES('f9c4a519-2a0a-456f-b78c-9429a1a90a4b', 0, '9a5f0c6a-0003-4ee5-8acd-10b28090da00', 0, 'Lancamento do sistema', 'Lancamento do sistema')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [dbo].[Entregas] ENTREGAS DO SISTEMA
-- -----------------------------------------------------
INSERT INTO APDBDev.dbo.Entregas(EntregaId, ResponsavelEntregaId, TipoEntrega, NmrDocumento, TipoDocumento, NomeRecebedor, isEntregueTitular, UsuarioInclusaoId, DataInclusao, Ativo, DataPrevistaEntrega)
VALUES('c773d32a-f982-4892-8799-ca980fabf64d', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 0, '999999999', 0, 'System', 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1, GETDATE())
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

INSERT INTO APDBDev.dbo.Enderecos
(EnderecoId, TipoEndereco, Logradouro, Numero, Cidade, Estado, CEP, UsuarioInclusaoId, DataInclusao, IsPrincipal, Ativo)
VALUES('f9c4a519-2a0a-456f-b78c-9429a1a90a4b', 0, 'System', '10', 'System', 'SP', '01234567', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1, 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


INSERT INTO APDBDev.dbo.Garantias
(GarantiaId, TipoGarantia, Descricao, Detalhes, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('400ff5d8-e05c-4fb8-b9b7-9bba83f2022d', 0, 'Garantia do sistema', 'Garantia do sistema', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

INSERT INTO APDBDev.dbo.Avaliacoes
(AvaliacaoId, ProdutoId, VendedorId, Descricao, Valor, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('a708df8e-8c6d-48da-b033-169eab8b8fda', '6ef793f6-0d6c-4a1a-a09d-1205f9986e74', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 'Avaliacao do sistema', 0, '', GETDATE(), 1);
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