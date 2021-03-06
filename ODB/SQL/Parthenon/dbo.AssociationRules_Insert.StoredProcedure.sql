USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[AssociationRules_Insert]
(
    @associationrule_id uniqueidentifier,
    @table_id_begin int,
    @itemtype_id_begin uniqueidentifier,
    @table_id_end int,
    @itemtype_id_end uniqueidentifier,
    @associationtype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AssociationRules] 
	(
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id]
	) 
	VALUES 
	(
		@associationrule_id, 
		@table_id_begin, 
		@itemtype_id_begin,
 		@table_id_end, 
		@itemtype_id_end, 
		@associationtype_id
	);

    EXEC ActivityLog_Insert 3, @associationrule_id, 1, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id] 
	FROM 
		AssociationRules 
	WHERE
	(
		associationrule_id = @associationrule_id
	)
' 
END
GO
