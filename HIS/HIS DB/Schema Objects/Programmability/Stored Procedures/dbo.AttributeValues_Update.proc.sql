
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
CREATE PROCEDURE [dbo].[AttributeValues_Update]
(
    @attributevalue_id uniqueidentifier,
    @table_id int,
	@item_id uniqueidentifier,
	@typeattribute_id uniqueidentifier,
	@value varchar(2048),
    @who varchar(50),
    @notes varchar(1024),
	@last_changed DateTime
)
AS
    SET NOCOUNT ON;

	DECLARE @current_change DateTime
	SET @current_change = GETDATE()

	UPDATE 
		[AttributeValues] 
	SET 
		[table_id]          = @table_id, 
		[item_id]           = @item_id, 
		[typeattribute_id]  = @typeattribute_id,
		[value]				= @value,
		[last_changed]      = @current_change
	WHERE 
	(
		([attributevalue_id] = @attributevalue_id)
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

	DECLARE @Log_TableID int = 12
	DECLARE @Log_ItemID varchar(128)
	DECLARE @Log_Value varchar(2048)
	DECLARE @Log_FunctionID int = 2

	SET @Log_ItemID = CONVERT(varchar(128),  @attributevalue_id)
	SET @Log_Value = 'AttributeValues_Update'

	EXEC ActivityLog_Insert @Log_FunctionID, @Log_TableID, @Log_ItemID, @Log_Value, @who, @notes 

   SELECT @current_change
