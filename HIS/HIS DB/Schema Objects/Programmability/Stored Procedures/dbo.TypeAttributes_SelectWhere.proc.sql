
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
CREATE PROCEDURE [dbo].[TypeAttributes_SelectWhere]
(
	@whereClause as varchar(1000) = NULL
)
AS
    SET NOCOUNT ON;

	DECLARE @sqlCmd varchar(4000)

	SET @sqlCmd =
	'SELECT  '
	+ '	[type_id],'
	+ '	[type_id],'
	+ '	[attribute_id],'
	+ '	[characteristics],'
	+ '	[datatype_id],'
	+ '	[version],'
	+ '	[description],'
	+ ' [last_changed] '
	+ 'FROM '
	+ '	TypeAttributes '

	IF (@whereClause IS NOT NULL)
		SET @sqlCmd = @sqlCmd + @whereClause
		
	EXEC(@sqlCmd)