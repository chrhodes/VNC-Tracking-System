USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[Attributes_Insert]
(
    @attribute_id uniqueidentifier,
    @attribute_name varchar(50),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Attributes] 
	(
		[attribute_id], 
		[attribute_name]
	) 
	VALUES 
	(
		@attribute_id, 
		@attribute_name
	);

	EXEC ActivityLog_Insert 6, @attribute_id, 1, @attribute_name, @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[attribute_id], 
		[attribute_name] 
	FROM 
		Attributes 
	WHERE 
		(attribute_id = @attribute_id)
' 
END
GO
