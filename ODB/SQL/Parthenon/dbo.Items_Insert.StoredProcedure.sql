USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[Items_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[Items_Insert]
(
    @item_id uniqueidentifier,
    @item_name varchar(256),
	@itemtype_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Items] 
	(
		[item_id], 
		[item_name], 
		[itemtype_id]
	) 
	VALUES 
	(
		@item_id, 
		@item_name,
		@itemtype_id
	);

   EXEC ActivityLog_Insert 12, @item_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
	FROM 
		Items 
	WHERE 
		(item_id = @item_id)
' 
END
GO
