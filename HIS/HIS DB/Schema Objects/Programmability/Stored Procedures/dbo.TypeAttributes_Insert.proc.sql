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
CREATE PROCEDURE [dbo].[TypeAttributes_Insert]
(
    @typeattribute_id uniqueidentifier,
    @type_id uniqueidentifier,
    @attribute_id uniqueidentifier,
    @characteristics int,
    @datatype_id int,
    @version int,
    @description varchar(1024),
    @who varchar(50),
    @notes varchar(1024)
)
AS
    SET NOCOUNT ON;

	DECLARE @last_changed DateTime
	SET @last_changed = GETDATE()

	INSERT INTO [TypeAttributes] 
	(
		[typeattribute_id], 
		[type_id], 
		[attribute_id], 
		[characteristics], 
		[datatype_id], 
		[version], 
		[description],
		[last_changed]
	) 
	VALUES 
	(
		@typeattribute_id, 
		@type_id, 
		@attribute_id, 
		@characteristics, 
		@datatype_id, 
		@version, 
		@description,
		@last_changed
	);

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

	DECLARE @Log_TableID int = 12
	DECLARE @Log_ItemID varchar(128)
	DECLARE @Log_Value varchar(2048)
	DECLARE @Log_FunctionID int = 1

	SET @Log_ItemID = CONVERT(varchar(128),  @typeattribute_id)
	SET @Log_Value = 'TypeAttributes_Insert'

	EXEC ActivityLog_Insert @Log_FunctionID, @Log_TableID, @Log_ItemID, @Log_Value, @who, @notes

	SELECT @last_changed
