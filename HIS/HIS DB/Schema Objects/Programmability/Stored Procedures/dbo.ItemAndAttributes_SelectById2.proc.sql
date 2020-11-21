
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
CREATE PROCEDURE [dbo].[ItemAndAttributes_SelectById2]
(
	@item_id as uniqueidentifier
)
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
	 WHERE
	  [item_id] = @item_id

	SELECT
	 	[attributevalue_id],
	 	[table_id],
	 	[item_id],
	 	av.[typeattribute_id],
	 	[value],
		av.[last_changed],
		ta.[characteristics],
		ta.[datatype_id],
		ta.[version]
	 FROM
	 	[AttributeValues] av
		INNER JOIN [TypeAttributes] ta
		ON av.typeattribute_id = ta.typeattribute_id
	 WHERE
		[item_id] = @item_id
