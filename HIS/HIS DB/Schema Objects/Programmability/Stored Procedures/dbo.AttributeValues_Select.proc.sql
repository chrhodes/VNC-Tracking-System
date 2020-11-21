
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
CREATE PROCEDURE [dbo].[AttributeValues_Select]

AS
    SET NOCOUNT ON;

	SELECT
		[attributevalue_id],
		[table_id],
		[item_id],
		[typeattribute_id],
		[value],
		[last_changed] 
	 FROM
		[AttributeValues]