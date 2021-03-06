USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[AttributeValues_Insert]
(
    @attributevalue_id uniqueidentifier,
    @table_id int,
	@item_id uniqueidentifier,
	@itemtypeattribute_id uniqueidentifier,
	@value varchar(2048),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AttributeValues] 
	(
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	) 
	VALUES 
	(
		@attributevalue_id, 
		@table_id,
		@item_id,
		@itemtypeattribute_id,
		@value
	);

   EXEC ActivityLog_Insert 12, @attributevalue_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	FROM 
		AttributeValues 
	WHERE 
		([attributevalue_id] = @attributevalue_id)
' 
END
GO
