USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[Associations_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Associations_Insert]
(
	@association_id uniqueidentifier,
	@table_id_begin int,
	@item_id_begin uniqueidentifier,
	@table_id_end int,
	@item_id_end uniqueidentifier,
	@associationrule_id uniqueidentifier,
	@itemtypegroup_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Associations] 
	(
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	)
	VALUES
	(
		@association_id,
		@table_id_begin, 
		@item_id_begin,
		@table_id_end, 
		@item_id_end,
		@associationrule_id, 
		@itemtypegroup_id
	);

	EXEC ActivityLog_Insert 4, @association_id, 1, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
    
	SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	FROM 
		Associations 
	WHERE 
		(association_id = @association_id)
' 
END
GO
