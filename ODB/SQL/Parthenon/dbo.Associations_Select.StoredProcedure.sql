USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[Associations_Select]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Select]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Select]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[Associations_Select]
AS
    SET NOCOUNT ON;

    SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin],
		[table_id_end],
		[item_id_end],
		[associationrule_id],
		[itemtypegroup_id]	
	FROM
		Associations
' 
END
GO
