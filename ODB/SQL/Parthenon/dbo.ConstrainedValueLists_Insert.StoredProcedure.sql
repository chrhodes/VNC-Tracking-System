USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Insert]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ConstrainedValueLists_Insert]
(
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvaluelist_name varchar(50),
    @constrainedvaluelist_description varchar(1024),
    @constrainedvaluelist_nbritems int,
	@constrainedvaluelist_datatype_id int,
	@who varchar(50),      
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;
	INSERT INTO [ConstrainedValueLists] 
   (	
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	)
	VALUES 
	(
		@constrainedvaluelist_id, 
		@constrainedvaluelist_name, 
		@constrainedvaluelist_description, 
		@constrainedvaluelist_nbritems,
		@constrainedvaluelist_datatype_id
	 );

	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 1, constrainedvaluelist_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	FROM 
		[ConstrainedValueLists] 
	WHERE 
		(constrainedvaluelist_id = @constrainedvaluelist_id)
' 
END
GO
