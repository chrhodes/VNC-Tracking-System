USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[UsageAttributes_Insert]
(
    @usageattribute_id int,
    @usageattribute_name varchar(50),
    @usageattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [UsageAttributes] 
	(
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description]
	) 
	VALUES 
	(
		@usageattribute_id, 
		@usageattribute_name, 
		@usageattribute_description
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 16, @usageattribute_id, 1, @usageattribute_name, @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description] 
	FROM 
		[UsageAttributes] 
	WHERE 
		(usageattribute_id = @usageattribute_id)
' 
END
GO
