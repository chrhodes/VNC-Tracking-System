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
CREATE PROCEDURE [dbo].[ActivityLog_DeleteAll]
(
    @who varchar(50),
    @notes varchar(1024)
)
AS
    SET NOCOUNT ON;

	DELETE FROM 
		[ActivityLog]

-- Log the Activity (1=Insert, 2=Update, 3=Delete)
-- ID	Table
--  1	Tables
--  2	ActivityLog
--  3	LogFunctions
--  4	Attributes
--	5	Types
--	6	TypeAttributes
--	7	Characteristics
--	8	DataTypes
--	9	Items
-- 10	AttributeValues
-- 11	ConstrainedValueLists
-- 12	ConstrainedValues

-- int        guid               int              varchar(2048) varchar(50) varchar(1024)
-- @table_id, @uniqueidentifier, @logfunction_id, @value,		@who,		@notes 

	DECLARE @Log_ItemID varchar(128)
	DECLARE @Log_Value varchar(2048)

	SET @Log_ItemID = '00000000-0000-0000-0000-000000000000'
	SET @Log_Value = 'ActivityLog_DeleteAll'

	EXEC ActivityLog_Insert 2, @Log_ItemID, 3, @Log_Value, @who, @notes
