USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Delete]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Delete]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Delete]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ConstrainedValueLists_Delete]
(
    @constrainedvaluelist_id uniqueidentifier,
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ConstrainedValueLists] 
	WHERE 
	(
		([constrainedvaluelist_id] = @constrainedvaluelist_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */ 
	)

	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
