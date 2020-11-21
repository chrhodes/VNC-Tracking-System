
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
CREATE PROCEDURE [dbo].[ConstrainedValues_Select]

AS
    SET NOCOUNT ON;

	SELECT
		[constrainedvalue_id],
		[constrainedvaluelist_id],
		[value],
		[description],
		[ordinal],
		[last_changed]
	FROM
		[ConstrainedValues]