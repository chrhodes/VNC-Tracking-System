USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Insert]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[AssociationTypes_Insert]
(
    @associationtype_id int,
    @associationtype_name varchar(50),
    @associationtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AssociationTypes] 
	(
		[associationtype_id], 
		[associationtype_name], 
		[associationtype_description]
	)
	VALUES
	(	
		@associationtype_id, 
		@associationtype_name, 
		@associationtype_description);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 5, @associationtype_id, 1, @associationtype_name, @who, @note /* ToDo: Update constants for each table */  

    SELECT
		associationtype_id, 
		associationtype_name, 
		associationtype_description 
	FROM 
		AssociationTypes
	WHERE 
		(associationtype_id = @associationtype_id)
' 
END
GO
