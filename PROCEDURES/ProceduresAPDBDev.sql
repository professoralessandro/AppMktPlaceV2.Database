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

			SELECT
				[TipoTelefoneId]
				,[Descricao]
				,[AssociadoInclusaoId]
				,[AssociadoUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
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

			SELECT
				[TipoDocumentoId]
				,[Descricao]
				,[AssociadoInclusaoId]
				,[AssociadoUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
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

			SELECT
				[TipoConfiguracaoId]
				,[Descricao]
				,[AssociadoInclusaoId]
				,[AssociadoUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
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

			SELECT
				[TipoLancamentoId]
				,[Descricao]
				,[AssociadoInclusaoId]
				,[AssociadoUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
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

			SELECT
				[TipoParametroId]
				,[Descricao]
				,[AssociadoInclusaoId]
				,[AssociadoUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
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

			SELECT
				[TipoWorkFlowId]
				,[Descricao]
				,[AssociadoInclusaoId]
				,[AssociadoUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
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
				,[AssociadoInclusaoId]
				,[AssociadoUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
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

-- -----------------------------------------------------
-- Procedure [log].[LogsPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE lLOGS PAGINATED
	CREATE PROCEDURE [log].[LogsPaginated]
		@Id INT,
		@Message VARCHAR(MAX),
		@Method VARCHAR(10),
		@Request VARCHAR(150),
		@Response INT,
		@UserId INT,
		@DateAdded DATETIME,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
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
			WHERE 		([LogId] = @Id OR @Id IS NULL)
			AND 		([Message] LIKE '%'+@Message+'%' OR @Message IS NULL)
			AND 		([Method] LIKE '%'+@Method+'%' OR @Method IS NULL)
			AND 		([Request] LIKE '%'+@Request+'%' OR @Request IS NULL)
			AND 		([Response] = @Response OR @Response IS NULL)
			AND 		([UserAddedId] = @UserId OR @UserId IS NULL)
			AND 		([DateAdded] >= @DateAdded OR @DateAdded IS NULL)
			ORDER BY 1 DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO