USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[Associations_Update]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Update]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Update]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[Associations_Update]
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

	UPDATE 
		[Associations] 
	SET 
		[table_id_begin]     = @table_id_begin,
		[item_id_begin]      = @item_id_begin, 
		[table_id_end]       = @table_id_end, 
		[item_id_end]        = @item_id_end, 
		[associationrule_id] = @associationrule_id, 
		[itemtypegroup_id]   = @itemtypegroup_id
	WHERE 
	(
		([association_id] = @association_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

    EXEC ActivityLog_Insert 4, @association_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
   
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
