USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Update]    Script Date: 08/19/2011 23:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Update]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Update]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ConstrainedValues_Update]
(
	@constrainedvalue_id uniqueidentifier,
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvalue_value varchar(50),
    @constrainedvalue_ordinal int,
    @constrainedvalue_description varchar(1024),
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ConstrainedValues] 
	SET 
		[constrainedvaluelist_id]      = @constrainedvaluelist_id, 
		[constrainedvalue_value]       = @constrainedvalue_value, 
		[constrainedvalue_ordinal]     = @constrainedvalue_ordinal, 
		[constrainedvalue_description] = @constrainedvalue_description 
	WHERE 
	(
		([constrainedvalue_id] = @constrainedvalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */ 
	);
    
	EXEC ActivityLog_Insert 9, @constrainedvalue_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvalue_id],
		[constrainedvaluelist_id], 
		[constrainedvalue_value], 
		[constrainedvalue_ordinal], 
		[constrainedvalue_description]
	FROM 
		ConstrainedValues 
	WHERE 
		(constrainedvalue_id = @constrainedvalue_id)
' 
END
GO
