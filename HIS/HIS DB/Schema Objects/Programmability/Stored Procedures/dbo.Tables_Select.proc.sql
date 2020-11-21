﻿
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
CREATE PROCEDURE [dbo].[Tables_Select]

AS
    SET NOCOUNT ON;

	SELECT
		[table_id], 
		[name],
		[version],
		[description],
		[last_changed]
	FROM
		dbo.[Tables]