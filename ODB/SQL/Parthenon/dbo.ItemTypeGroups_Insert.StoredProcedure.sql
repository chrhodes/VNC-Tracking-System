USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ItemTypeGroups_Insert]
(
    @itemtypegroup_id uniqueidentifier,
    @itemtypegroup_name varchar(50),
    @itemtypegroup_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypeGroups] 
    (
		[itemtypegroup_id], 
        [itemtypegroup_name], 
        [itemtypegroup_description]
    ) 
	VALUES 
    (
        @itemtypegroup_id, 
        @itemtypegroup_name, 
        @itemtypegroup_description
    );

    EXEC ActivityLog_Insert 13, @itemtypegroup_id, 1, @itemtypegroup_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtypegroup_id], 
        [itemtypegroup_name], 
        [itemtypegroup_description]
	FROM 
		ItemTypeGroups 
	WHERE 
      (	itemtypegroup_id = @itemtypegroup_id)
' 
END
GO
