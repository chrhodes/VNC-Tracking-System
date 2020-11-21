
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
CREATE PROCEDURE [dbo].[ItemAndAttributes_SelectById]
(
	@item_id as uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT
	 	[item_id],
	 	[name],
	 	[type_id],
		[last_changed]
	 FROM
	 	[Items]
	 WHERE
	  [item_id] = @item_id

	SELECT
	 	[attributevalue_id],
	 	[table_id],
	 	[item_id],
	 	[typeattribute_id],
	 	[value],
		[last_changed]
	 FROM
	 	[AttributeValues]
	 WHERE
		[item_id] = @item_id
