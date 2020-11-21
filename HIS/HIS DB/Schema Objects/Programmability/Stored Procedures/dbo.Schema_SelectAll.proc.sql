
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
CREATE PROCEDURE [dbo].[Schema_SelectAll]
AS
    SET NOCOUNT ON;

	--DECLARE @sqlCmd varchar(4000)

	-- Tables

	SELECT
		[table_id], 
		[name], 
		[version], 
		[description], 
		[last_changed] 
	FROM 
		[Tables]
	
	-- LogFunctions

	SELECT 
		[logfunction_id], 
		[name], 
		[description] 
	FROM 
		[LogFunctions]
	
	-- Attributes

	SELECT 
		[attribute_id], 
		[name], 
		[last_changed] 
	FROM 
		[Attributes]

	-- Types

	SELECT 
		[type_id], 
		[name], 
		[characteristics], 
		[version], 
		[description], 
		[last_changed] 
	FROM 
		[Types]
	
	-- TypeAttributes

	SELECT 
		[typeattribute_id], 
		[type_id], 
		[attribute_id], 
		[characteristics], 
		[datatype_id], 
		[version], 
		[description], 
		[last_changed] 
	FROM 
		[TypeAttributes]

	-- DataTypes
	
	SELECT
		[datatype_id],
		[name],
		[description],
		[last_changed]
	FROM 
		[DataTypes]

	-- Characteristics

	SELECT
		[characteristic_id],
		[name],
		[description],
		[last_changed]
	FROM
		[Characteristics]

	-- ConstrainedValueLists

	SELECT
		[constrainedvaluelist_id],
		[datatype_id],
		[name],
		[description],
		[nbritems],
		[last_changed]
	FROM
		[ConstrainedValueLists]

	-- ConstrainedValues

	SELECT
		[constrainedvalue_id],
		[constrainedvaluelist_id],
		[value],
		[description],
		[ordinal],
		[last_changed] 
	FROM
		[ConstrainedValues]

