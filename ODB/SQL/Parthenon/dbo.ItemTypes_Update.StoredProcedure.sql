USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Update]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Update]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Update]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ItemTypes_Update]
(
    @itemtype_id uniqueidentifier,
    @itemtype_name varchar(50),
    @itemtypegroup_id uniqueidentifier,
    @itemtype_version int,
    @itemtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ItemTypes] 
	SET 
		[itemtype_id] = @itemtype_id, 
		[itemtype_name] = @itemtype_name, 
		[itemtypegroup_id] = @itemtypegroup_id, 
		[itemtype_version] = @itemtype_version, 
		[itemtype_description] = @itemtype_description 
	WHERE 
    (
        ([itemtype_id] = @itemtype_id) 
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 14, @itemtype_id, 2, @itemtype_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description] 
	FROM 
		ItemTypes 
	WHERE 
		(itemtype_id = @itemtype_id)
' 
END
GO
