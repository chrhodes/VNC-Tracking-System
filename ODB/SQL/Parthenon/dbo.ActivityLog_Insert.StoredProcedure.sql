USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ActivityLog_Insert] 
    @table_id int, 
    @item_id uniqueidentifier,
    @log_function_id int,
    @value varchar(2048),
    @who varchar(50),
    @notes varchar(1024)
AS
    -- SET NOCOUNT ON added to prevent extra result sets FROM
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO 
		[ActivityLog]
	VALUES 
    (
		newid(), 
		@table_id, 
		@item_id, 
		@log_function_id, 
		@value, 
		@who, 
		getDate(), 
		@notes
	)
' 
END
GO
