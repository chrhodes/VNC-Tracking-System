USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Insert]
(
    @itemtypeattribute_id uniqueidentifier,
    @itemtype_id uniqueidentifier,
    @attribute_id uniqueidentifier,
    @usage_attributes int,
    @datatype_id int,
    @itemtypeattribute_version int,
    @itemtypeattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypeAttributes] 
	(
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	) 
	VALUES 
	(
		@itemtypeattribute_id, 
		@itemtype_id, 
		@attribute_id, 
		@usage_attributes, 
		@datatype_id, 
		@itemtypeattribute_version, 
		@itemtypeattribute_description
	);

   EXEC ActivityLog_Insert 12, @itemtypeattribute_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	FROM 
		ItemTypeAttributes 
	WHERE 
		(itemtypeattribute_id = @itemtypeattribute_id)
' 
END
GO
