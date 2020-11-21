
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
CREATE PROCEDURE [dbo].[ConstrainedValueLists_Select]

AS
    SET NOCOUNT ON;

	SELECT
		[constrainedvaluelist_id],
		[datatype_id],
		[name],
		[description],
		[nbritems],
		[last_changed]
	FROM
		[ConstrainedValueLists]