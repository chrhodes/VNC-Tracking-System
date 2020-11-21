
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
CREATE PROCEDURE [dbo].[Items_SelectByName]
(
    @name varchar(256)
)
AS
    SET NOCOUNT ON;

	DECLARE @sqlCmd varchar(4000)

	SELECT 
		[item_id], 
		[name], 
		[type_id]
   FROM 
		[Items] 
   where 
		name = @name
