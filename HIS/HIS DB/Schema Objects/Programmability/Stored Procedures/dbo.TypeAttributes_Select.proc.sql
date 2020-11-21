
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
CREATE PROCEDURE [dbo].[TypeAttributes_Select]

AS
    SET NOCOUNT ON;

	SELECT
		[type_id],
		[type_id],
		[attribute_id],
		[characteristics],
		[datatype_id],
		[version],
		[description],
		[last_changed]
	FROM
		TypeAttributes