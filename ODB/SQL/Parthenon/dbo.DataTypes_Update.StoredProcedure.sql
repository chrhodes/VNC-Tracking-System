USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Update]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Update]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Update]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[DataTypes_Update]
(
    @datatype_id int,
    @datatype_name varchar(50),
    @datatype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)

)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[DataTypes] 
	SET 
		[datatype_id] = @datatype_id, 
		[datatype_name] = @datatype_name, 
		[datatype_description] = @datatype_description 
	WHERE 
	(
		([datatype_id] = @datatype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--  EXEC ActivityLog_Insert 10, @datatype_id, 2, @datatype_name, @who, @note /* ToDo: Update constants for each table */  

   SELECT 
      [datatype_id], 
      [datatype_name], 
      [datatype_description] 
   FROM 
      DataTypes 
   WHERE 
   (
		[datatype_id] = @datatype_id
	)
' 
END
GO
