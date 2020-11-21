
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
CREATE PROCEDURE [dbo].[Item_SelectAttributeValues]
(
    @item_id uniqueidentifier
)
AS
    SET NOCOUNT ON;

	--DECLARE @sqlCmd varchar(4000)

	SELECT 
		[item_id],
		[type_id],	 
		[name], 
		[last_changed]
	FROM 
		[Items]
	WHERE 
		item_id = @item_id

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