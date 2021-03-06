USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Delete]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Delete]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Delete]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[Tables_Delete]
(
    @table_id int,
	@last_changed timestamp
)
AS
    SET NOCOUNT OFF;

	DELETE FROM
		[dbo].[Tables]
	WHERE
		(
			([table_id] = @table_id)
			 AND ([last_changed] = @last_changed)
		)
' 
END
GO
