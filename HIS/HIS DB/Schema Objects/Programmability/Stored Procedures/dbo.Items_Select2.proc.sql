
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
CREATE PROCEDURE [dbo].[Items_Select2]

AS
    SET NOCOUNT ON;

	SELECT
		[item_id],
		i.[name],
		i.[type_id],
		i.[last_changed],
		t.[name],
		t.[characteristics],
		t.[version]
	FROM
		[Items] i
		INNER JOIN [Types] t
		ON i.type_id = t.type_id