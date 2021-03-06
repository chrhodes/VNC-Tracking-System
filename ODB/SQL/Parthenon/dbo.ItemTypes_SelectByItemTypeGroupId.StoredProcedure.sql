USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_SelectByItemTypeGroupId]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_SelectByItemTypeGroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_SelectByItemTypeGroupId]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_SelectByItemTypeGroupId]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ItemTypes_SelectByItemTypeGroupId]
(
    @ItemTypeGroupId uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT 
		itemtype_id, 
		itemtype_name, 
		itemtypegroup_id, 
		itemtype_version, 
		itemtype_description
   FROM 
		ItemTypes 
   where 
		itemtypegroup_id = @ItemTypeGroupId
' 
END
GO
