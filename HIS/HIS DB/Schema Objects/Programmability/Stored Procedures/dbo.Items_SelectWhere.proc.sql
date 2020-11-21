
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
CREATE PROCEDURE [dbo].[Items_SelectWhere]
(
	@whereClause as varchar(1000) = NULL
)
AS
    SET NOCOUNT ON;

	DECLARE @sqlCmd varchar(4000)

	SET @sqlCmd =
	'SELECT  '
	+ '	[item_id],'
	+ '	[name],'
	+ '	[type_id],'
	+ ' [last_changed] '
	+ 'FROM '
	+ '	[Items] '

	IF (@whereClause IS NOT NULL)
		SET @sqlCmd = @sqlCmd + @whereClause
		
	EXEC(@sqlCmd)