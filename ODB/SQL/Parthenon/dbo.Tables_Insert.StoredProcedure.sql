USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Insert]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Insert]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[Tables_Insert]
(
    @table_id int,
    @table_name varchar(50),
    @table_version int,
    @table_description varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO
		[dbo].[Tables]
	(
		[table_id], 
		[table_name], 
		[table_version], 
		[table_description]
	)
	VALUES
	(
		@table_id, 
		@table_name, 
		@table_version, 
		@table_description
	);
    
	SELECT
		table_id, 
		table_name, 
		table_version, 
		table_description,
		last_changed
	FROM 
		Tables 
	WHERE
		(table_id = @table_id)
' 
END
GO
