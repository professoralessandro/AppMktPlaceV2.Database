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