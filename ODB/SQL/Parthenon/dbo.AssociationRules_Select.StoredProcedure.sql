USE [ODB]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Select]    Script Date: 08/19/2011 23:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Select]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Select]') AND type in (N'P', N'PC'))
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
CREATE PROCEDURE [dbo].[AssociationRules_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[associationrule_id],
		[table_id_begin],
		[table_id_end],
		[itemtype_id_begin],
		[itemtype_id_end],
		[associationtype_id]
   FROM 
		AssociationRules
' 
END
GO
