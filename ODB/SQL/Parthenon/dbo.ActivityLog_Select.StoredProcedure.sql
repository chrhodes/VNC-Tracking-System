USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Select]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Select]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Select]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[ActivityLog_Select]
AS
    SET NOCOUNT ON;

    SELECT 
        [activitylog_id],
        [table_id],
        [item_id],
        [logfunction_id],
        [value],
        [who],
        [when],
        [notes]
    FROM 
		[ActivityLog]
' 
END
GO
