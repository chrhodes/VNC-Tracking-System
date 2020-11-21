
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
CREATE PROCEDURE [dbo].[Characteristics_Update]
(
    @characteristic_id int,
    @name varchar(50),
    @description varchar(1024),
    @who varchar(50),
    @notes varchar(1024),
	@last_changed DateTime
)
AS
    SET NOCOUNT ON;

	DECLARE @current_change DateTime
	SET @current_change = GETDATE()

	UPDATE 
		[Characteristics] 
	SET 
		[characteristic_id]		= @characteristic_id, 
		[name]					= @name, 
		[description]			= @description,
		[last_changed]			= @current_change
	WHERE 
	(
		([characteristic_id] = @characteristic_id)
		AND ([last_changed] = @last_changed)
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

	DECLARE @Log_TableID int = 16
	DECLARE @Log_ItemID varchar(128)
	DECLARE @Log_Value varchar(2048)
	DECLARE @Log_FunctionID int = 2

	SET @Log_ItemID = CONVERT(varchar(128), @characteristic_id)
	SET @Log_Value = @name + '|' + @description

	EXEC ActivityLog_Insert @Log_FunctionID, @Log_TableID, @Log_ItemID, @Log_Value, @who, @notes

	SELECT @current_change
