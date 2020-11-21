
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
CREATE PROCEDURE [dbo].[ActivityLog_Insert] 
    @logfunction_id int,
    @table_id int, 
    @item_id varchar(128),
    @value varchar(2048),
    @who varchar(50),
    @notes varchar(1024)
AS
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DECLARE @activitylog_id uniqueidentifier

	-- TODO(crhodes) Decide if really need a guid for each row in ActivityLog

	SET @activitylog_id = NEWID()
	
	INSERT INTO 
		[ActivityLog]
	VALUES 
    (
		@activitylog_id, 
		@logfunction_id, 
		@table_id, 
		@item_id, 
		@value, 
		@who, 
		getDate(), 
		@notes
	)

	--SELECT @activitylog_id


