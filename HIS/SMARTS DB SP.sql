USE [SMARTS DB]
GO
/****** Object:  StoredProcedure [dbo].[crosstab]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[crosstab] 
@select varchar(8000),
@sumfunc varchar(100), 
@pivot varchar(100), 
@table varchar(100) 
AS

DECLARE @sql varchar(8000), @delim varchar(1)
SET NOCOUNT ON
SET ANSI_WARNINGS OFF

EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##pivot FROM ' + @table + ' WHERE 1=2')
EXEC ('INSERT INTO ##pivot SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE ' + @pivot + ' Is Not Null')

SELECT @sql='',  @sumfunc=stuff(@sumfunc, len(@sumfunc), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type)+CharIndex('date', data_type) ) 
WHEN 0 THEN '' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##pivot' AND column_name='pivot'

SELECT @sql=@sql + '''' + convert(varchar(100), pivot) + ''' = ' + stuff(@sumfunc,charindex( '(', @sumfunc )+1, 0, ' CASE ' + @pivot + ' WHEN ' + @delim + convert(varchar(100), pivot) + @delim + ' THEN ' ) + ', ' FROM ##pivot

DROP TABLE ##pivot

SELECT @sql=left(@sql, len(@sql)-1)
SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')

EXEC (@select)
SET ANSI_WARNINGS ON
GO
/****** Object:  StoredProcedure [dbo].[GetConstrainedValues]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetConstrainedValues] (@Table as int, @ID as int)  AS

SELECT DISTINCT 
	*
	 
FROM 
	ConstrainedValues
GO
/****** Object:  StoredProcedure [dbo].[SetLog]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetLog](@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Note as varchar(1000), @Contact as varchar(500)) AS

INSERT INTO SDLog VALUES (@Table, @ID, @Function, @Value, @Note, @Contact, getDate())
GO
/****** Object:  StoredProcedure [dbo].[GetRelation2]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetRelation2] (@ID as int) 

AS

DECLARE @Column_var varchar(100)
DECLARE @Column_var2 varchar(1000)
DECLARE @Column_int int
DECLARE @T varchar(100)
DECLARE @T_ID varchar(103)
DECLARE @T_Column varchar(1000)
DECLARE @Proc varchar(1000)

SELECT 
	Relation_ID, Relation_Name,	Relation_Desc,
	@Column_int as "Relation_TypeID",
	Abstraction_ID,
	SDTable_ID_Begin as "Item_Table",
	SD_ID_Begin as "Item_ID",
	@Column_int as "Item_TypeID",
	@Column_int as "Item_AbstractionID",
	@Column_var as "Item_Name",
	@Column_var2 as "Item_Desc",
	@Column_var as "Item_TypeName",
	@Column_var2 as "Direction",
	SDTable_ID_End as "Related_Table",
	SD_ID_End as "Related_ID",
	@Column_var as "Related_Name",
	@Column_var2 as "Related_Desc",
	@Column_int as "Related_TypeID",
	@Column_int as "Related_AbstractionID",
	@Column_var as "Related_TypeName",
	SDTable_ID_Begin, SD_ID_Begin,
	@Column_var as "Begin_Name",
	@Column_var2 as "Begin_Desc",
	@Column_int as "Begin_TypeID",
	@Column_var as "Begin_TypeName",
	SDTable_ID_End, SD_ID_End,
	@Column_var as "End_Name",
	@Column_var2 as "End_Desc",
	@Column_int as "End_TypeID",
	@Column_var as "End_TypeName"
INTO #TempTable 
FROM Relation NOLOCK
WHERE Relation_ID = @ID


UPDATE  #TempTable SET Begin_Name = (SELECT DISTINCT Shape_Name  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET Begin_Desc = (SELECT DISTINCT Shape_Desc  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET Begin_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET Begin_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  = Begin_TypeID)
UPDATE  #TempTable SET End_Name = (SELECT DISTINCT Shape_Name  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET End_Desc = (SELECT DISTINCT Shape_Desc  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET End_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_End)
UPDATE  #TempTable SET End_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  =  End_TypeID)

UPDATE #TempTable SET Relation_TypeID=
	CASE 
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')

	END

UPDATE #TempTable SET Item_Name=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_Name
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_Name
	END
UPDATE #TempTable SET Item_Desc=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_Desc
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_Desc
	END
UPDATE #TempTable SET Direction =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN 'To'
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN 'From'
	END
UPDATE #TempTable SET Related_Table =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN SDTable_ID_End
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN SDTable_ID_Begin
	END
UPDATE #TempTable SET Related_ID =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN SD_ID_End
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN SD_ID_Begin
	END
UPDATE #TempTable SET Related_Name=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_Name
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_Name
	END
UPDATE #TempTable SET Related_Desc=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_Desc
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_Desc
	END
UPDATE #TempTable SET Item_TypeID=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_TypeID
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_TypeID
	END
UPDATE #TempTable SET Item_AbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
UPDATE #TempTable SET Item_TypeName=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_TypeName
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_TypeName
	END
UPDATE #TempTable SET Related_TypeID=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_TypeID
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_TypeID
	END
UPDATE #TempTable SET Related_AbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_TypeID)

UPDATE #TempTable SET Related_TypeName=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_TypeName
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_TypeName
	END


SELECT * FROM #TempTable ORDER BY Relation_Name

DROP TABLE #TempTable
GO
/****** Object:  StoredProcedure [dbo].[GetRelation]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetRelation] (@ID as int) 


AS

DECLARE @Column_var varchar(100)
DECLARE @Column_var2 varchar(1000)
DECLARE @Column_int int
DECLARE @T varchar(100)
DECLARE @T_ID varchar(103)
DECLARE @T_Column varchar(1000)
DECLARE @Proc varchar(1000)

SELECT 
	Relation_ID, Relation_Name,	Relation_Desc,
	@Column_int as "Relation_TypeID",
	Abstraction_ID,
	SDTable_ID_Begin as "Item_Table",
	SD_ID_Begin as "Item_ID",
	@Column_int as "Item_TypeID",
	@Column_int as "Item_AbstractionID",
	@Column_var as "Item_Name",
	@Column_var2 as "Item_Desc",
	@Column_var as "Item_TypeName",
	@Column_int as "Item_ContainerID",
	@Column_int as "Item_ContainerTypeID",
	@Column_int as "Item_ContainerAbstractionID",
	@Column_var as "Item_ContainerName",
	@Column_var as "Item_ContainerAbstraction",
	@Column_var2 as "Direction",
	SDTable_ID_End as "Related_Table",
	SD_ID_End as "Related_ID",
	@Column_var as "Related_Name",
	@Column_var2 as "Related_Desc",
	@Column_int as "Related_TypeID",
	@Column_int as "Related_AbstractionID",
	@Column_var as "Related_TypeName",
	@Column_int as "Related_ContainerID",
	@Column_int as "Related_ContainerTypeID",
	@Column_int as "Related_ContainerAbstractionID",
	@Column_var as "Related_ContainerName",
	@Column_var as "Related_ContainerAbstraction",
	SDTable_ID_Begin, SD_ID_Begin,
	@Column_var as "Begin_Name",
	@Column_var2 as "Begin_Desc",
	@Column_int as "Begin_TypeID",
	@Column_var as "Begin_TypeName",
	SDTable_ID_End, SD_ID_End,
	@Column_var as "End_Name",
	@Column_var2 as "End_Desc",
	@Column_int as "End_TypeID",
	@Column_var as "End_TypeName"
INTO #TempTable 
FROM Relation NOLOCK
WHERE Relation_ID = @ID


UPDATE  #TempTable SET Begin_Name = (SELECT DISTINCT Shape_Name  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET Begin_Desc = (SELECT DISTINCT Shape_Desc  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET Begin_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET Begin_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  = Begin_TypeID)
UPDATE  #TempTable SET End_Name = (SELECT DISTINCT Shape_Name  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET End_Desc = (SELECT DISTINCT Shape_Desc  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #TempTable SET End_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_End)
UPDATE  #TempTable SET End_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  =  End_TypeID)

UPDATE #TempTable SET Relation_TypeID=
	CASE 
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')

	END

UPDATE #TempTable SET Item_Name=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_Name
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_Name
	END
UPDATE #TempTable SET Item_Desc=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_Desc
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_Desc
	END
UPDATE #TempTable SET Direction =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN 'To'
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN 'From'
	END
UPDATE #TempTable SET Related_Table =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN SDTable_ID_End
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN SDTable_ID_Begin
	END
UPDATE #TempTable SET Related_ID =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN SD_ID_End
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN SD_ID_Begin
	END
UPDATE #TempTable SET Related_Name=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_Name
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_Name
	END
UPDATE #TempTable SET Related_Desc=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_Desc
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_Desc
	END
UPDATE #TempTable SET Item_TypeID=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_TypeID
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_TypeID
	END
UPDATE #TempTable SET Item_AbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
UPDATE #TempTable SET Item_TypeName=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_TypeName
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_TypeName
	END
UPDATE #TempTable SET Related_TypeID=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_TypeID
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_TypeID
	END
UPDATE #TempTable SET Related_AbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_TypeID)

UPDATE #TempTable SET Related_TypeName=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_TypeName
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_TypeName
	END

UPDATE #TempTable SET Item_ContainerAbstraction=
	CASE 
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEM')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESS')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'PIECE') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECTPIECE')
	END

/*
UPDATE #TempTable SET Item_ContainerID=(SELECT DISTINCT SD_ID_Container FROM Container WHERE SD_ID_Contained = Item_ID AND SDTable_ID_Contained = Item_Table AND Abstraction_ID = Item_ContainerAbstraction)
UPDATE #TempTable SET Item_ContainerTypeID=(SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Item_ContainerID)
UPDATE #TempTable SET Item_ContainerAbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_ContainerTypeID)
UPDATE #TempTable SET Item_ContainerName=(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = Item_ContainerID)

UPDATE #TempTable SET Related_ContainerAbstraction=
	CASE 
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEM')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESS')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP')
		WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'PIECE') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECTPIECE')
	END

UPDATE #TempTable SET Related_ContainerID=(SELECT DISTINCT SD_ID_Container FROM Container WHERE SD_ID_Contained = Related_ID AND SDTable_ID_Contained = Related_Table AND Abstraction_ID = Related_ContainerAbstraction)
UPDATE #TempTable SET Related_ContainerTypeID=(SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Related_ContainerID)
UPDATE #TempTable SET Related_ContainerAbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_ContainerTypeID)
UPDATE #TempTable SET Related_ContainerName=(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = Related_ContainerID)
*/
SELECT * FROM #TempTable ORDER BY Relation_Name

DROP TABLE #TempTable
GO
/****** Object:  StoredProcedure [dbo].[GetLog_Shape]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLog_Shape](@Table as int,@ID as int) AS


DECLARE @varDummy  varchar(1000)

select  *, @varDummy as "FunctionName", @varDummy as "FunctionValue"	
	into #temptable2
from sdlog 
where sdtable_id = @Table and sd_id = @ID
order by sdlog_datetime

UPDATE #temptable2 SET FunctionName = 
	CASE
		WHEN (SDLogFunction_ID <> 9 AND SDLog_Note IS NULL)  THEN (SELECT SDLogFunction_Name FROM SDLogFunction WHERE SDLogFunction_ID =#temptable2.SDLogFunction_ID)
		WHEN (SDLogFunction_ID <> 9 AND SDLog_Note IS NOT NULL)  THEN (SELECT SDLogFunction_Name FROM SDLogFunction WHERE SDLogFunction_ID =#temptable2.SDLogFunction_ID)
		WHEN (SDLogFunction_ID =  9 AND SDLog_Note IS NULL)  THEN (SELECT SDLogFunction_Name FROM SDLogFunction WHERE SDLogFunction_ID = #temptable2.SDLogFunction_ID)
		WHEN (SDLogFunction_ID =  9 AND SDLog_Note IS NOT NULL)  THEN (SELECT SDLogFunction_Name FROM SDLogFunction WHERE SDLogFunction_ID =5)
	END

UPDATE #temptable2 SET FunctionValue = 
	CASE
		WHEN (SDLog_Note IS NULL)  THEN #temptable2.SDLog_Value
		WHEN (FunctionName =  'LOGFUNCTION_SET_LIFECYCLE')  THEN (SELECT LifeCycle_Name FROM LifeCycle WHERE LifeCycle_ID =CAST(#temptable2.SDLog_Note as INT))
		WHEN (FunctionName =  'LOGFUNCTION_SET_SHAPETYPEATTRIBUTE')  THEN (SELECT ShapeType_Name FROM ShapeType WHERE ShapeType_ID =CAST(#temptable2.SDLog_Note as INT))
	END 

select * from #temptable2

drop table #temptable2
GO
/****** Object:  StoredProcedure [dbo].[GetLog_Relation]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLog_Relation](@Table as int, @ID as int) AS

DECLARE @dummyint INT	
DECLARE @dummyvar varchar(500)

DECLARE @intFunction INT

DECLARE @intTable_Relation INT 
DECLARE @intTable_Shape INT 
DECLARE @intTable_ShapeType INT 
DECLARE @intTable_Abstraction  INT

DECLARE @strTable_Shape varchar(3) 
DECLARE @strTable_ShapeType varchar(3)
DECLARE @strTable_Artifact varchar(3)
DECLARE @strTable_Abstraction varchar(3)

SET @intFunction= (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_RELATION')
SET @intTable_Relation= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Relation')

SET @intTable_Shape= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape')
SET @intTable_ShapeType= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ShapeType')
SET @intTable_Abstraction= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Abstraction')

SET @strTable_Shape= CAST(@intTable_Shape as varchar(3))
SET @strTable_ShapeType= CAST(@intTable_ShapeType as varchar(3))
SET @strTable_Abstraction= CAST(@intTable_Abstraction as varchar(3))


-- GET ALL CONTAINER RELATIONSHIPS  OF SELECTED TABLE AND ID
select * into #temptable1
from sdlog 
where sdlog_note = CAST(@ID as varchar(10)) 
	and sdlog_value = CAST(@Table as varchar(5)) 
	and sdtable_id = @intTable_Relation


-- CREATE ANOTHER TEMPTABLE WITH EXTRA COLUMNS
select *, 
	@dummyint as "ItemFunction", @dummyint as "ItemFunction2", @dummyvar as "FunctionName", 
	@dummyint as "ItemTableID",  @dummyint as "ItemID", @dummyvar as "ItemName", @dummyint as "ItemType", @dummyint as "ItemAbstraction" 
	into #temptable2
from sdlog 
where sdtable_id = @intTable_Relation
	and sd_id in (select distinct sd_id from #temptable1) 
order by sd_id, sdlog_datetime


UPDATE #temptable2 SET ItemFunction =
	CASE
		WHEN #temptable2.SDLog_Note IS NULL THEN NULL
		ELSE @intFunction
	END  

UPDATE #temptable2 SET FunctionName = (SELECT SDLogFunction_Name FROM SDLogFunction WHERE SDLogFunction_ID = #temptable2.SDLogFunction_ID)


UPDATE #temptable2 SET ItemFunction2 =
	CASE
		WHEN SDLog_Value = @strTable_Shape AND SDLog_Note IS NOT NULL THEN (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_SHAPE')
	END

UPDATE #temptable2 SET ItemTableID =
	CASE
		WHEN #temptable2.ItemFunction IS NULL THEN NULL
		ELSE  CAST(#temptable2.SDLog_Value as int)
	END


UPDATE #temptable2 SET ItemID =
	CASE
		WHEN #temptable2.ItemFunction IS NULL THEN NULL
		ELSE  CAST(#temptable2.SDLog_Note as int)
	END

--UPDATE #temptable2 SET ItemName = (SELECT Shape_Name FROM Shape WHERE Shape_ID = CAST (#temptable2.SDLog_Note as int))
UPDATE #temptable2 SET ItemName = 
	CASE
		WHEN #temptable2.ItemFunction IS NULL THEN SDLog_Value
		ELSE (SELECT Shape_Name FROM Shape WHERE Shape_ID = #temptable2.ItemID)
	END

--IF TEMP NAME IS STILL NULL, CHECK IN LOG TO GET OLD (DELETED) NAME
UPDATE #temptable2 SET ItemName = 
	CASE
		WHEN #temptable2.ItemName IS NULL THEN (SELECT SDLog_Value FROM SDLog WHERE SD_ID = #temptable2.ItemID AND SDLogFunction_ID = #temptable2.ItemFunction2 AND SDTable_ID = #temptable2.ItemTableID AND SDLog_Note IS NULL)	
   		ELSE  #temptable2.ItemName
	END

update #temptable2 set ItemType = (SELECT SDLog_Note FROM SDLog WHERE SD_ID= #temptable2.ItemID AND SDLogFunction_ID =  (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_SHAPE') AND SDTable_ID = #temptable2.ItemTableID AND SDLog_Value = @strTable_ShapeType)	


update #temptable2 set ItemAbstraction =
	CASE
		WHEN #temptable2.ItemTableID = @intTable_Abstraction THEN CAST(#temptable2.SDLog_Note as int)
		WHEN #temptable2.ItemTableID = @intTable_Shape THEN (SELECT Abstraction_ID FROM ShapeType WHERE ShapeType_ID= #temptable2.ItemType)	
		WHEN #temptable2.ItemTableID IS NULL THEN NULL
	END 


-- CREATE ANOTHER TEMPTABLE WITH EXTRA COLUMNS
select * from #temptable2 order by sd_id, sdlog_datetime

drop table #temptable1
drop table #temptable2
GO
/****** Object:  StoredProcedure [dbo].[GetLog_Container]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLog_Container](@ContainType as int, @Table as int, @ID as int) AS

DECLARE @dummyint INT	
DECLARE @dummyvar varchar(500)

DECLARE @intFunction_SetShape INT
DECLARE @intFunction_SetArtifact INT

DECLARE @intTable_Shape INT 
DECLARE @intTable_ShapeType INT 
DECLARE @intTable_Container INT
DECLARE @intTable_Abstraction  INT
DECLARE @intTable_Artifact INT

DECLARE @strTable_Shape varchar(3)
DECLARE @strTable_ShapeType varchar(3)
DECLARE @strTable_Abstraction varchar(3)
DECLARE @strTable_Artifact varchar(3)

SET @intFunction_SetShape= (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_SHAPE')
SET @intFunction_SetArtifact= (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ARTIFACT')

SET @intTable_Shape= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape')
SET @intTable_ShapeType= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ShapeType')
SET @intTable_Container= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Container')
SET @intTable_Abstraction= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Abstraction')
SET @intTable_Artifact= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Artifact')

SET @strTable_Shape= CAST(@intTable_Shape as varchar(3))
SET @strTable_ShapeType= CAST(@intTable_ShapeType as varchar(3))
SET @strTable_Abstraction= CAST(@intTable_Abstraction as varchar(3))
SET @strTable_Artifact= CAST(@intTable_Artifact as varchar(3))

-- GET ALL CONTAINER RELATIONSHIPS  OF SELECTED TABLE AND ID
select * into #temptable1
from sdlog 
where sdlog_note = CAST(@ID as varchar(10)) 
	and sdlog_value = CAST(@Table as varchar(5)) 
	and sdtable_id = @intTable_Container

-- IF CONTAINERTYPE IS SPECIFIED, DELETE ALL OTHER CONTAINERTYPES
IF @ContainType IS NOT NULL
BEGIN
	DELETE FROM #temptable1 WHERE sdlogfunction_id <> @ContainType
END

-- CREATE ANOTHER TEMPTABLE WITH EXTRA COLUMNS
select *, 
	@dummyint as "ItemFunction", @dummyint as "ItemFunction2", @dummyvar as "FunctionName",
	@dummyint as "ItemTableID",  @dummyint as "ItemID", @dummyvar as "ItemName", @dummyint as "ItemType", @dummyint as "ItemAbstraction" 
	into #temptable2
from sdlog 
where sdtable_id = @intTable_Container
	and sd_id in (select distinct sd_id from #temptable1) 
order by sd_id, sdlog_datetime


UPDATE #temptable2 SET ItemFunction2 =
	CASE
		WHEN SDLog_Value = @strTable_Artifact THEN @intFunction_SetArtifact
		WHEN SDLog_Value = @strTable_Shape THEN @intFunction_SetShape
	END


UPDATE #temptable2 SET ItemFunction = 
	CASE
		WHEN SDLog_Value = @strTable_Abstraction and SDLog_Note = '7' THEN @intFunction_SetArtifact
		ELSE SDLogFunction_ID
	END

UPDATE #temptable2 SET FunctionName = (SELECT SDLogFunction_Name FROM SDLogFunction WHERE SDLogFunction_ID = #temptable2.ItemFunction)


UPDATE #temptable2 SET ItemTableID =
	CASE
		WHEN ItemFunction2 IS NULL THEN NULL
		ELSE  CAST(#temptable2.SDLog_Value as int)
	END


UPDATE #temptable2 SET ItemID =
	CASE
		WHEN ItemFunction2 IS NULL THEN NULL
		ELSE  CAST(#temptable2.SDLog_Note as int)
	END



UPDATE #temptable2 SET ItemName = 
	CASE
		WHEN SDLog_Value = @strTable_Shape THEN (SELECT Shape_Name FROM Shape WHERE Shape_ID = CAST (#temptable2.SDLog_Note as int))
		WHEN SDLog_Value = @strTable_Artifact THEN (SELECT Artifact_Name FROM Artifact WHERE Artifact_ID = CAST (#temptable2.SDLog_Note as int))
	END

--IF TEMP NAME IS STILL NULL, CHECK IN LOG TO GET OLD (DELETED) NAME
UPDATE #temptable2 SET ItemName = 
	CASE
		WHEN #temptable2.ItemName IS NULL THEN (SELECT SDLog_Value FROM SDLog WHERE SD_ID = #temptable2.ItemID AND SDLogFunction_ID = #temptable2.ItemFunction2 AND SDTable_ID = #temptable2.ItemTableID AND SDLog_Note IS NULL)	
   		ELSE  #temptable2.ItemName
	END

update #temptable2 set ItemType = (SELECT SDLog_Note FROM SDLog WHERE SD_ID= #temptable2.ItemID  AND SDLogFunction_ID =  #temptable2.ItemFunction AND SDTable_ID = #temptable2.ItemTableID AND SDLog_Value = @strTable_ShapeType)	


update #temptable2 set ItemAbstraction =
	CASE
		WHEN SDLog_Value = @strTable_Abstraction THEN CAST(#temptable2.SDLog_Note as int)
		WHEN SDLog_Value = @strTable_Shape THEN (SELECT Abstraction_ID FROM ShapeType WHERE ShapeType_ID= ItemType)	
		WHEN SDLog_Value = @strTable_Artifact THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT')
	END 




select * from #temptable2

drop table #temptable1
drop table #temptable2
GO
/****** Object:  StoredProcedure [dbo].[GetLog_AttributeValuesExisting]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLog_AttributeValuesExisting](@Table as int, @ID as int)  AS

SELECT * FROM attributevalue as av
	left join shapetypeattribute as sta on sta.shapetypeattribute_id = av.shapetypeattribute_id
	left join attribute as a on a.attribute_id = sta.attribute_id
	left join sdlog as sdl on sdl.sdtable_id = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'AttributeValue')
		and av.attributevalue_id = sdl.sd_id 
	where av.sd_id = @ID 
		and av.sdtable_id = @Table 
		and sdl.sdlog_note is NULL
	order by attribute_name, sdlog_id
GO
/****** Object:  StoredProcedure [dbo].[GetLog_AttributeValuesDeleted]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLog_AttributeValuesDeleted](@Table as int, @ID as int) AS


DECLARE @intFunctionSet int
DECLARE @intFunctionDel int
DECLARE @strTable varchar(6)
DECLARE @strID varchar(6)

SET @intFunctionSet = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ATTRIBUTEVALUE')
SET @intFunctionDel = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_ATTRIBUTEVALUE')
SET @strTable = CAST(@Table as varchar(6))
SET @strID = CAST(@ID as varchar(6))

select 	sdlog_id,
	sdtable_id,
	sd_id,
	sdlogfunction_id,
	sdlog_value,
	sdlog_note,
	sdlog_contact,
	sdlog_datetime,
	sta.shapetypeattribute_id,
	a.attribute_id,
	a.attribute_name
into #temptable
from sdlog nolock
	left join shapetypeattribute as sta on sta.shapetypeattribute_id = CAST(sdlog_note as int) 
	left join attribute as a on a.attribute_id = sta.attribute_id 
where sdtable_id in
(select sdtable_id from sdlog 
	where sdtable_id in (select sdtable_id from sdlog where sdlogfunction_id = @intFunctionSet and sdlog_value = @strTable and sdlog_note = @strID)
		and sd_id in (select sd_id from sdlog where sdlogfunction_id = @intFunctionSet and sdlog_value = @strTable and sdlog_note = @strID)
		and sdlogfunction_id = @intFunctionDel)
and 
sd_id in
(select sd_id from sdlog 
	where sdtable_id in (select sdtable_id from sdlog where sdlogfunction_id = @intFunctionSet and sdlog_value = @strTable and sdlog_note = @strID)
		and sd_id in (select sd_id from sdlog where sdlogfunction_id = @intFunctionSet and sdlog_value = @strTable and sdlog_note = @strID)
		and sdlogfunction_id = @intFunctionDel)


DECLARE @intFunctionSetSTA int
DECLARE @strFunctionSetSTA varchar(6)
DECLARE @strTableSTA varchar(6)
DECLARE @intFunctionSetA int
DECLARE @strTableA varchar(6)

/* grab the STA from SDLOG in case it has already been deleted from the STA table */
SET @intFunctionSetSTA = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_SHAPETYPEATTRIBUTE') 
SET @strFunctionSetSTA = CAST(@intFunctionSetSTA as varchar(6))
SET @strTableSTA = CAST((SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ShapeTypeAttribute') as varchar(6))
SET @intFunctionSetA = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ATTRIBUTE') 
SET @strTableA = CAST((SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Attribute') as varchar(6))

UPDATE #temptable set shapetypeattribute_id = 
	CASE
		WHEN (sdlog_value = @strFunctionSetSTA) THEN cast(sdlog_note as int) 
	END

update #temptable set attribute_id = 
	CASE
		WHEN attribute_id IS NULL THEN (SELECT sdlog_note FROM sdlog where sdtable_id = @strTableSTA and sd_id = #temptable.shapetypeattribute_id and sdlogfunction_id = @intFunctionSetSTA and sdlog_value = @strTableA )
		WHEN attribute_id is NOT NULL then attribute_id
	END 

/* grab the Attribute from SDLOG in case it has already been deleted from the Attribute table */
update #temptable set attribute_name = 
	CASE
		WHEN attribute_name is NULL then (SELECT sdlog_value FROM sdlog where sdtable_id = @strTableA and sd_id = #temptable.attribute_id and sdlogfunction_id = @intFunctionSetA)
		WHEN attribute_name is NOT NULL then attribute_name
	END 

select * from #temptable order by sdlog_id

drop table #temptable

/*

select * from sdlog
where sdtable_id in
(select sdtable_id from sdlog 
	where sdtable_id in (select sdtable_id from sdlog where sdlogfunction_id = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ATTRIBUTEVALUE') 
		and (sdlog_value = CAST(@Table as varchar(6))) and (sdlog_note = CAST(@ID as varchar(6)))
		and sd_id in (select sd_id from sdlog where sdlogfunction_id = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ATTRIBUTEVALUE') 
		and (sdlog_value = CAST(@Table as varchar(6))) and (sdlog_note = CAST(@ID as varchar(6)))
		and sdlogfunction_id = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_ATTRIBUTEVALUE') )
and 
sd_id in
(select sd_id from sdlog 
	where sdtable_id in (select sdtable_id from sdlog where sdlogfunction_id = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ATTRIBUTEVALUE') 
		and (sdlog_value = CAST(@Table as varchar(6))) and (sdlog_note = CAST(@ID as varchar(6)))
		and sd_id in (select sd_id from sdlog where sdlogfunction_id = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ATTRIBUTEVALUE') 
		and (sdlog_value = CAST(@Table as varchar(6))) and (sdlog_note = CAST(@ID as varchar(6)))
		and sdlogfunction_id = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_ATTRIBUTEVALUE') )

order by sdlog_id

*/
GO
/****** Object:  StoredProcedure [dbo].[GetLog_AttributeValues]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLog_AttributeValues](@Table as int, @ID as int) AS

DECLARE @dummyint INT	
DECLARE @dummyvar varchar(500)

DECLARE @intFunction INT

DECLARE @intTable_Relation INT 
DECLARE @intTable_Shape INT 
DECLARE @intTable_ShapeType INT 
DECLARE @intTable_Abstraction  INT

DECLARE @strTable_Shape INT 
DECLARE @strTable_ShapeType varchar(3)
DECLARE @strTable_Artifact varchar(3)
DECLARE @strTable_Abstraction varchar(3)

SET @intFunction= (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_RELATION')
SET @intTable_Relation= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Relation')

SET @intTable_Shape= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape')
SET @intTable_ShapeType= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ShapeType')
SET @intTable_Abstraction= (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Abstraction')

SET @strTable_Shape= CAST(@intTable_Shape as varchar(3))
SET @strTable_ShapeType= CAST(@intTable_ShapeType as varchar(3))
SET @strTable_Abstraction= CAST(@intTable_Abstraction as varchar(3))


-- GET ALL CONTAINER RELATIONSHIPS  OF SELECTED TABLE AND ID
select * into #temptable1
from sdlog 
where sdlog_note = CAST(@ID as varchar(10)) 
	and (sdlogfunction_id = 17 or sdlogfunction_id = 22)
	and sdtable_id = 6
	and sdlog_value = CAST(@Table as varchar(5)) 


-- CREATE ANOTHER TEMPTABLE WITH EXTRA COLUMNS
select *, 
	@dummyvar as "FunctionName", @dummyvar as "Attribute",  @dummyvar as "ItemName"
	into #temptable2
from sdlog 
where sdtable_id = 6
	and sd_id in (select distinct sd_id from #temptable1) 
order by sd_id, sdlog_datetime


UPDATE #temptable2 SET FunctionName = (SELECT SDLogFunction_Name FROM SDLogFunction WHERE SDLogFunction_ID = #temptable2.SDLogFunction_ID)

UPDATE #temptable2 SET ItemName = 
	CASE
		WHEN #temptable2.SDLog_Value = '4' AND #temptable2.SDLog_Note IS NOT NULL THEN (SELECT Shape_Name FROM Shape WHERE Shape_ID = CAST(#temptable2.SDLog_Note as int))
	END

--IF TEMP NAME IS STILL NULL, CHECK IN LOG TO GET OLD (DELETED) NAME

UPDATE #temptable2 SET ItemName = 
	CASE
		WHEN #temptable2.ItemName IS NULL AND #temptable2.SDLog_Value = '4' THEN (SELECT Top 1(SDLog_Value) FROM SDLog WHERE SDLogFunction_ID = 9 AND SDTable_ID = 4 AND SDLog_Note IS NULL AND SD_ID = CAST(#temptable2.SDLog_Note as int) ORDER BY SDLog_DateTime DESC )	
		ELSE #temptable2.ItemName
	END


UPDATE #temptable2 SET Attribute = 
	CASE
		WHEN #temptable2.SDLog_Value = '5' AND #temptable2.SDLog_Note IS NOT NULL THEN (SELECT TOP 1(SDLog_Value) FROM SDLog WHERE SDTable_ID = 5 AND SDLogFunction_ID =5 AND SDLog_Note IS NULL AND SD_ID = CAST(#temptable2.SDLog_Note as int) ORDER BY SDLog_DateTime DESC )	
	END


-- CREATE ANOTHER TEMPTABLE WITH EXTRA COLUMNS
select * from #temptable2

drop table #temptable1
drop table #temptable2
GO
/****** Object:  StoredProcedure [dbo].[GetLifecycleList]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLifecycleList] AS

SELECT 
	* 
FROM 
	Lifecycle
ORDER BY 
	Lifecycle_ID
GO
/****** Object:  StoredProcedure [dbo].[GetItem_Search]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_Search] (@Function as int, @Abstraction as int, @Type as int, @Attribute as int, @Value as varchar(1000)) 
AS

DECLARE @Columnint int
DECLARE @Columnvar varchar(2000)
DECLARE @Pattern varchar(500)


SET @Pattern = "%" + CAST(@Value as varchar) + "%"
--- FIRST RETURN EVERYTHING (NAME, DESCRIPTION, & ATTRIBUTEVALUE) THAT FITS THE PATTERN 
SELECT 	(SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_ATTRIBUTEVALUE')  as "SDLogFunction", 
	Shape_ID as "Item_ID", Shape_Name as "Item_Name", Shape_Desc as "Item_Desc", AttributeValue_Value as "Item_Value",	
	STA.ShapeTypeAttribute_ID, A.Attribute_ID,  A.Attribute_Name as "Item_Field", 
	ST.ShapeType_Name as "Item_Type", ST.ShapeType_ID as "Item_TypeID", ST.Abstraction_ID as "Item_Abstraction"
	INTO #Temp
	FROM AttributeValue as AV 
		LEFT JOIN ShapeTypeAttribute as STA ON STA.ShapeTypeAttribute_ID = AV.ShapeTypeAttribute_ID 
		LEFT JOIN Attribute as A ON STA.Attribute_ID = A.Attribute_ID
		LEFT JOIN ShapeType as ST ON STA.ShapeType_ID = ST.ShapeType_ID
		LEFT JOIN Shape as S ON AV.SD_ID = S.Shape_ID
	WHERE AV.AttributeValue_Value LIKE @Pattern 
		AND STA.ShapeTypeAttribute_ID IS NOT NULL  AND AV.SDTable_ID = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape')
UNION
SELECT (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_NAME') as "SDLogFunction", 
	Shape_ID as "Item_ID", Shape_Name as "Item_Name", Shape_Desc as "Item_Desc", Shape_Name as "Item_Value",	
	@Columnint as "ShapeTypeAttribute_ID", @Columnint as "Attribute_ID", "Name" as "Item_Field", 
	ST.ShapeType_Name as "Item_Type", ST.ShapeType_ID as "Item_TypeID", ST.Abstraction_ID as "Item_Abstraction"
	FROM Shape as S 
		LEFT JOIN ShapeType as ST ON S.ShapeType_ID = ST.ShapeType_ID
	WHERE S.Shape_Name LIKE @Pattern
UNION
SELECT (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_DESCRIPTION')  as "SDLogFunction", Shape_ID as "Item_ID", Shape_Name as "Item_Name", Shape_Desc as "Item_Desc", Shape_Desc as "Item_Value",	
	@ColumnVar as "ShapeTypeAttribute_ID", @Columnint as "Attribute_ID", "Description" as "Item_Field", 
	ST.ShapeType_Name as "Item_Type", ST.ShapeType_ID as "Item_TypeID", ST.Abstraction_ID as "Item_Abstraction"
	FROM Shape as S 
		LEFT JOIN ShapeType as ST ON S.ShapeType_ID = ST.ShapeType_ID
	WHERE S.Shape_Desc LIKE @Pattern

--- FILTER OUT : DELETE BY FUNCTION CRITERIA
IF @Function IS NOT NULL
BEGIN
	DELETE FROM #Temp WHERE SDLogFunction <> @Function 
END

--- FILTER OUT : DELETE BY ABSTRACTION CRITERIA
IF @Abstraction IS NOT NULL
BEGIN
	DELETE FROM #Temp WHERE Item_Abstraction <> @Abstraction
END

--- FILTER OUT : DELETE BY SHAPETYPE CRITERIA
IF @Type IS NOT NULL
BEGIN
	DELETE FROM #Temp WHERE Item_TypeID <> @Type
END

--- FILTER OUT : DELETE BY ATTRIBUTE CRITERIA
IF @Attribute IS NOT NULL
BEGIN
	DELETE FROM #Temp WHERE Attribute_ID <> @Attribute
END


SELECT * FROM #Temp ORDER BY Item_Type,  Item_Name,  Item_Field, Item_Value

DROP TABLE #Temp
GO
/****** Object:  StoredProcedure [dbo].[GetItem_Relation]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_Relation] (@Relation as int, @Table as int, @ID as int, @Abstraction as int) 

-- IF @Relation IS NULL get all relations of that item
-- IF @Relation IS NOT NULL get that relation only

AS


DECLARE @Column_var varchar(100)
DECLARE @Column_var2 varchar(1000)
DECLARE @Column_int int
DECLARE @T varchar(100)
DECLARE @T_ID varchar(103)
DECLARE @T_Column varchar(1000)
DECLARE @Proc varchar(1000)

SELECT 
	Relation_ID, 
	IsNULL(Relation_Name,'') as "Relation_Name",	
	IsNULL(Relation_Desc,'') as "Relation_Desc",
	@Column_int as "Relation_TypeID",
	Abstraction_ID,
	@Column_int as "Item_Table",
	@Column_int as "Item_ID",
	@Column_int as "Item_TypeID",
	@Column_int as "Item_AbstractionID",
	@Column_var as "Item_Name",
	@Column_var2 as "Item_Desc",
	@Column_var as "Item_TypeName",
	@Column_var2 as "Direction",
	@Column_int as "Related_Table",
	@Column_int as "Related_ID",
	@Column_var as "Related_Name",
	@Column_var2 as "Related_Desc",
	@Column_int as "Related_TypeID",
	@Column_int as "Related_AbstractionID",
	@Column_var as "Related_TypeName",
	@Column_int as "Related_ContainerID",
	@Column_int as "Related_ContainerTypeID",
	@Column_int as "Related_ContainerAbstractionID",
	@Column_var as "Related_ContainerName",
	@Column_var as "Related_ContainerAbstraction",
	SDTable_ID_Begin, SD_ID_Begin,
	@Column_var as "Begin_Name",
	@Column_var2 as "Begin_Desc",
	@Column_int as "Begin_TypeID",
	@Column_var as "Begin_TypeName",
	SDTable_ID_End, SD_ID_End,
	@Column_var as "End_Name",
	@Column_var2 as "End_Desc",
	@Column_int as "End_TypeID",
	@Column_var as "End_TypeName"
INTO #TempTable 
FROM Relation NOLOCK
WHERE (SDTable_ID_Begin = @Table AND SD_ID_Begin = @ID)
	OR (SDTable_ID_End = @Table AND SD_ID_End = @ID) OR (Relation_ID = @Relation)


IF @Table IS NOT NULL
	BEGIN
		UPDATE  #TempTable SET Item_Table = @Table
	END

IF @ID IS NOT NULL
	BEGIN
		UPDATE  #TempTable SET Item_ID = @ID
	END

IF @Abstraction IS NOT NULL
	BEGIN
		DELETE FROM #TempTable WHERE Abstraction_ID <> @Abstraction
	END

IF @Relation IS NOT NULL
	BEGIN
		DELETE FROM #TempTable WHERE Relation_ID <> @Relation
		SET @Table = (SELECT SDTable_ID_Begin FROM #TempTable)
		SET @ID = (SELECT SD_ID_Begin FROM #TempTable)
		UPDATE  #TempTable SET Item_Table = @Table
		UPDATE  #TempTable SET Item_ID = @ID
	END

SET @T  = (SELECT SDTable_Name FROM SDTable WHERE SDTable_ID = @Table)
SET @T_ID = @T + '_ID'
SET @T_Column = @T + '_Name'

SET @Proc = 'UPDATE  #TempTable SET Begin_Name = (SELECT DISTINCT ' +  @T_Column + ' FROM ' + @T + ' WHERE ' + @T_ID + ' = SD_ID_Begin)'
EXEC (@Proc)
SET @Proc = 'UPDATE  #TempTable SET End_Name = (SELECT DISTINCT ' +  @T_Column + ' FROM ' + @T + ' WHERE ' + @T_ID + ' = SD_ID_End)'
EXEC (@Proc)

SET @T_Column = @T + '_Desc'

SET @Proc = 'UPDATE  #TempTable SET Begin_Desc = (SELECT DISTINCT ' +  @T_Column + ' FROM ' + @T + ' WHERE ' + @T_ID + ' = SD_ID_Begin)'
EXEC (@Proc)
SET @Proc = 'UPDATE  #TempTable SET End_Desc = (SELECT DISTINCT ' +  @T_Column + ' FROM ' + @T + ' WHERE ' + @T_ID + ' = SD_ID_End)'
EXEC (@Proc)

IF @T = 'Shape'
	BEGIN
		UPDATE  #TempTable SET Begin_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
		UPDATE  #TempTable SET Begin_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  = Begin_TypeID)
		UPDATE  #TempTable SET End_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_End)
		UPDATE  #TempTable SET End_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  =  End_TypeID)
	END

UPDATE #TempTable SET Relation_TypeID=
	CASE 
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')
	END

UPDATE #TempTable SET Item_Name=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_Name
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_Name
	END
UPDATE #TempTable SET Item_Desc=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_Desc
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_Desc
	END
UPDATE #TempTable SET Direction =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN 'To'
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN 'From'
	END
UPDATE #TempTable SET Related_Table =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN SDTable_ID_End
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN SDTable_ID_Begin
	END
UPDATE #TempTable SET Related_ID =
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN SD_ID_End
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN SD_ID_Begin
	END
UPDATE #TempTable SET Related_Name=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_Name
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_Name
	END
UPDATE #TempTable SET Related_Desc=
	CASE 
		WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_Desc
		WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_Desc
	END
IF @T = 'Shape'
	BEGIN
		UPDATE #TempTable SET Item_TypeID=
			CASE 
				WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_TypeID
				WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_TypeID
			END
		UPDATE #TempTable SET Item_AbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
		UPDATE #TempTable SET Item_TypeName=
			CASE 
				WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN Begin_TypeName
				WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN End_TypeName
			END
		UPDATE #TempTable SET Related_TypeID=
			CASE 
				WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_TypeID
				WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_TypeID
			END
		UPDATE #TempTable SET Related_AbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_TypeID)

		UPDATE #TempTable SET Related_TypeName=
			CASE 
				WHEN Item_Table = SDTable_ID_Begin AND Item_ID = SD_ID_Begin THEN End_TypeName
				WHEN Item_Table = SDTable_ID_End AND Item_ID = SD_ID_End THEN Begin_TypeName
			END
		UPDATE #TempTable SET Related_ContainerAbstraction=
			CASE 
				WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT')
				WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP')
				WHEN Abstraction_ID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'PIECE') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECTPIECE')
			END

		UPDATE #TempTable SET Related_ContainerID=(SELECT DISTINCT SD_ID_Container FROM Container WHERE SD_ID_Contained = Related_ID AND SDTable_ID_Contained = Related_Table AND Abstraction_ID = Related_ContainerAbstraction)
		UPDATE #TempTable SET Related_ContainerTypeID=(SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Related_ContainerID)
		UPDATE #TempTable SET Related_ContainerAbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_ContainerTypeID)
		UPDATE #TempTable SET Related_ContainerName=(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = Related_ContainerID)

	END

SELECT * FROM #TempTable ORDER BY Related_ContainerName, Related_Name, Relation_Name

DROP TABLE #TempTable
GO
/****** Object:  StoredProcedure [dbo].[GetItem_ContainerAll]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_ContainerAll](@Table as int, @ID as int) AS

SET NOCOUNT ON

DECLARE @SD_ID_Container int
DECLARE @SD_ID_Contained int

CREATE TABLE #Temp(SD_ID_Contained int, SD_ID_Container int, Name_Container varchar(500), ShapeType_Container int, Abstraction_Container int)
SELECT @SD_ID_Container = SD_ID_Container FROM Container WHERE SDTable_ID_Contained = @Table and SD_ID_Contained = @ID
SELECT @SD_ID_Contained = @ID

WHILE @@Rowcount > 0
	BEGIN
		INSERT #Temp(SD_ID_Contained, SD_ID_Container, Name_Container, ShapeType_Container, Abstraction_Container)
		SELECT SD_ID_Contained, SD_ID_Container, Shape_Name, ShapeType.ShapeType_ID, ShapeType.Abstraction_ID FROM Container 
			LEFT JOIN Shape ON Shape.Shape_ID = SD_ID_Container 
			LEFT JOIN ShapeType ON Shape.ShapeType_ID = ShapeType.ShapeType_ID WHERE SD_ID_Container = @SD_ID_Container AND SD_ID_Contained = @SD_ID_Contained
		SELECT @SD_ID_Contained = @SD_ID_Container
		SELECT @SD_ID_Container = SD_ID_Container FROM Container WHERE SDTable_ID_Contained = @Table AND SD_ID_Contained = @SD_ID_Container
	END

SELECT * FROM #Temp 

DROP TABLE #Temp
GO
/****** Object:  StoredProcedure [dbo].[GetItem_Container]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_Container] (@Table as int, @ID as int, @Abstraction as int) 
AS

DECLARE @Column_var varchar(1000)
DECLARE @Column_int int
DECLARE @Temp int
DECLARE @Proc varchar(1000)


SELECT Container_ID,
	SDTable_ID_Container, SD_ID_Container,
	SDTable_ID_Contained, SD_ID_Contained,
	Abstraction_ID,
	@Column_var as "Contained_Name",
	@Column_var as "Contained_Desc",
	@Column_var as "Contained_Environment",
	@Column_int as "Contained_ShapeTypeID",
	@Column_var as "Contained_ShapeTypeName",
	-- Container shape
	@Column_var as "Container_Name",
	@Column_var as "Container_Desc",
	@Column_var as "Container_Environment",
	@Column_int as "Container_Abstraction",
	-- Shapetype of Container shape
	@Column_int as "ShapeType_ID",
	@Column_var as "ShapeType_Name",
	-- Level Container of the container shape (e.g. System shape container or object shape)
	@Column_var as "LevelContainer_Table",
	@Column_var as "LevelContainer_ID",
	@Column_var as "LevelContainer_Name",
	@Column_var as "LevelContainer_Desc",
	@Column_int as "LevelContainer_ShapeType_ID",
	-- FOR VISIO Drawing simplification
	Container_ID as "Relation_ID",
	@Column_int as "Relation_TypeID",
	@Column_var as "Relation_Name",
	@Column_var as "Relation_Desc",
	@Column_int as "Related_ContainerID",
	@Column_int as "Related_ContainerTypeID",
	@Column_int as "Related_ContainerAbstractionID",
	@Column_var as "Related_ContainerName",
	@Column_var as "Related_ContainerAbstraction",
	SDTable_ID_Contained as "Item_Table",
	SD_ID_Contained as "Item_ID",
	@Column_int as "Item_TypeID",
	@Column_int as "Item_AbstractionID",
	@Column_var as "Item_Name",
	@Column_var as "Item_Desc",
	@Column_var as "Item_TypeName",
	SDTable_ID_Container as "Related_Table",
	SD_ID_Container as "Related_ID",
	@Column_int as "Related_TypeID",
	@Column_int as "Related_AbstractionID",
	@Column_var as "Related_Name",
	@Column_var as "Related_Desc",
	@Column_var as "Related_TypeName",
	SDTable_ID_Container as "SDTable_ID_BEGIN",
	SD_ID_Container as "SD_ID_BEGIN",
	SDTable_ID_Contained as "SDTable_ID_END",
	SD_ID_Contained as "SD_ID_END",
	@Column_int as "Begin_TypeID",
	@Column_var as "Begin_TypeName",
	@Column_int as "End_TypeID",
	@Column_var as "End_TypeName"
INTO #Temp1 
FROM Container NOLOCK
WHERE SDTable_ID_Contained = @Table 
	AND SD_ID_Contained = @ID

BEGIN TRAN

UPDATE  #Temp1 SET ShapeType_ID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #Temp1 SET ShapeType_Name = (SELECT DISTINCT ShapeType_Name FROM ShapeType WHERE ShapeType.ShapeType_ID = #Temp1.ShapeType_ID)
UPDATE  #Temp1 SET Container_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #Temp1 SET Container_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #Temp1 SET Container_Environment = (SELECT DISTINCT AttributeValue_Value FROM AttributeValue WHERE ShapeTypeAttribute_ID = (SELECT ShapeTypeAttribute_ID FROM ShapeTypeAttribute WHERE Attribute_ID = (SELECT Attribute_ID FROM Attribute WHERE Attribute_Name = 'Environment') AND ShapeType_ID = #Temp1.ShapeType_ID) AND SDTable_ID = SDTable_ID_Container AND SD_ID = SD_ID_Container)
UPDATE  #Temp1 SET Container_Abstraction = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType.ShapeType_ID = #Temp1.ShapeType_ID)
UPDATE  #Temp1 SET Contained_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #Temp1 SET Contained_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #Temp1 SET Contained_ShapeTypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #Temp1 SET Contained_ShapeTypeName = (SELECT DISTINCT ShapeType_Name FROM ShapeType WHERE ShapeType.ShapeType_ID = #Temp1.Contained_ShapeTypeID)
UPDATE  #Temp1 SET Contained_Environment = (SELECT DISTINCT AttributeValue_Value FROM AttributeValue WHERE ShapeTypeAttribute_ID = (SELECT ShapeTypeAttribute_ID FROM ShapeTypeAttribute WHERE Attribute_ID = (SELECT Attribute_ID FROM Attribute WHERE Attribute_Name = 'Environment') AND ShapeType_ID = #Temp1.Contained_ShapeTypeID) AND SDTable_ID = SDTable_ID_Contained AND SD_ID = SD_ID_Contained)

UPDATE  #Temp1 SET LevelContainer_Table = 
	CASE 
		WHEN Container_Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT SDTable_ID_Container FROM Container WHERE SDTable_ID_Contained = #Temp1.SDTable_ID_Container AND SD_ID_Contained = #Temp1.SD_ID_Container AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP'))
		WHEN Container_Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT SDTable_ID_Container FROM Container WHERE SDTable_ID_Contained = #Temp1.SDTable_ID_Container AND SD_ID_Contained = #Temp1.SD_ID_Container AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT'))
	END

UPDATE  #Temp1 SET LevelContainer_ID = 
	CASE 
		WHEN Container_Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT SD_ID_Container FROM Container WHERE SDTable_ID_Contained = #Temp1.SDTable_ID_Container AND SD_ID_Contained = #Temp1.SD_ID_Container AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP'))
		WHEN Container_Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT SD_ID_Container FROM Container WHERE SDTable_ID_Contained = #Temp1.SDTable_ID_Container AND SD_ID_Contained = #Temp1.SD_ID_Container AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT'))
	END

UPDATE  #Temp1 SET LevelContainer_Name = 
	CASE 
		WHEN LevelContainer_Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape') THEN (SELECT Shape_Name FROM Shape WHERE Shape_ID = LevelContainer_ID)
	END

UPDATE  #Temp1 SET LevelContainer_Desc = 
	CASE 
		WHEN LevelContainer_Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape') THEN (SELECT Shape_Desc FROM Shape WHERE Shape_ID = LevelContainer_ID)
	END

UPDATE  #Temp1 SET LevelContainer_ShapeType_ID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = LevelContainer_ID)

UPDATE  #Temp1 SET Relation_TypeID = 
	CASE
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
		WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')
	END

UPDATE  #Temp1 SET Item_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #Temp1 SET Item_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
UPDATE  #Temp1 SET Item_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #Temp1 SET Item_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #Temp1 SET Related_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Related_ID)
UPDATE  #Temp1 SET Related_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_TypeID)
UPDATE  #Temp1 SET Related_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #Temp1 SET Related_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Container)

UPDATE #Temp1 SET Related_ContainerAbstraction=
	CASE 
		WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT')
		WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP')
		WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'PIECE') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECTPIECE')
	END

UPDATE #Temp1 SET Related_ContainerID=(SELECT DISTINCT SD_ID_Container FROM Container WHERE SD_ID_Contained = Related_ID AND SDTable_ID_Contained = Related_Table AND Abstraction_ID = Related_ContainerAbstraction)
UPDATE #Temp1 SET Related_ContainerTypeID=(SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Related_ContainerID)
UPDATE #Temp1 SET Related_ContainerAbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_ContainerTypeID)
UPDATE #Temp1 SET Related_ContainerName=(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = Related_ContainerID)

UPDATE  #Temp1 SET Begin_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
UPDATE  #Temp1 SET Begin_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  = Begin_TypeID)
UPDATE  #Temp1 SET End_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_End)
UPDATE  #Temp1 SET End_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  =  End_TypeID)

--- MOSTLY FOR VISIO : USE ABSTRACTION IS NULL TO GET ALL RELATIONS EXCEPT FOR ARTIFACT RELATIONS
--- OVERWRITE Contained_Name and Contained_Desc if SEARCHING FOR ARTIFACT RELATIONS
IF @Abstraction IS NOT NULL
	BEGIN
		DELETE FROM #Temp1 WHERE Abstraction_ID <> @Abstraction
		IF @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT')			
			BEGIN
				UPDATE  #Temp1 SET Contained_Name = (SELECT DISTINCT Artifact_Name FROM Artifact WHERE Artifact_ID = SD_ID_Contained)
				UPDATE  #Temp1 SET Contained_Desc = (SELECT DISTINCT Artifact_Desc FROM Artifact WHERE Artifact_ID = SD_ID_Contained)
			END
	END	
ELSE
	BEGIN
		DELETE FROM #Temp1 WHERE Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT')			
	END

COMMIT TRAN

SELECT * FROM #Temp1 ORDER BY Container_Name

DROP TABLE #Temp1
GO
/****** Object:  StoredProcedure [dbo].[GetItem_ContainedAll]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_ContainedAll](@Table as int, @ID as int) AS

SET NOCOUNT ON

DECLARE @SD_ID_Container int
DECLARE @SD_ID_Contained int

CREATE TABLE #Temp(SD_ID_Container int, SD_ID_Contained int, Name_Contained varchar(500), ShapeType_Contained int, Abstraction_Contained int)
SELECT @SD_ID_Contained = SD_ID_Contained FROM Container WHERE SDTable_ID_Container = @Table and SD_ID_Container = @ID
SELECT @SD_ID_Container = @ID
INSERT INTO #Temp(SD_ID_Container, SD_ID_Contained, Name_Contained, ShapeType_Contained, Abstraction_Contained)
SELECT SD_ID_Container, SD_ID_Contained, Shape_Name, ShapeType.ShapeType_ID, ShapeType.Abstraction_ID FROM Container 
	LEFT JOIN Shape ON Shape.Shape_ID = SD_ID_Container 
	LEFT JOIN ShapeType ON Shape.ShapeType_ID = ShapeType.ShapeType_ID WHERE SD_ID_Container = @SD_ID_Container

WHILE @@Rowcount > 0
	BEGIN
--		SELECT @SD_ID_Container = (SELECT SD_ID_Contained FROM #Temp WHERE SD_ID_Container = @SD_ID_Container)
		INSERT INTO #Temp(SD_ID_Container, SD_ID_Contained, Name_Contained, ShapeType_Contained, Abstraction_Contained)
		SELECT SD_ID_Container, SD_ID_Contained, Shape_Name, ShapeType.ShapeType_ID, ShapeType.Abstraction_ID FROM Container 
			LEFT JOIN Shape ON Shape.Shape_ID = SD_ID_Container 
			LEFT JOIN ShapeType ON Shape.ShapeType_ID = ShapeType.ShapeType_ID 
			WHERE SD_ID_Container IN (SELECT SD_ID_Contained FROM #Temp WHERE SD_ID_Container = @SD_ID_Container)
	END

SELECT * FROM #Temp 

DROP TABLE #Temp
GO
/****** Object:  StoredProcedure [dbo].[GetItem_Contained]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_Contained] (@Table as int, @ID as int, @Abstraction as int) 
AS

DECLARE @Column_var varchar(1000)
DECLARE @Column_int int
DECLARE @Proc varchar(1000)


SELECT Container_ID,
	SDTable_ID_Container, SD_ID_Container,
	SDTable_ID_Contained, SD_ID_Contained,
	Abstraction_ID,
	@Column_var as "NameContainer",
	@Column_var as "Contained_Name",
	@Column_var as "Contained_Desc",
	@Column_var as "Contained_ShapeContainerName",
	@Column_var as "Contained_ShapeContainerID",
	@Column_var as "Container_Name",
	@Column_var as "Container_Desc",
	@Column_int as "ShapeType_ID",
	@Column_var as "ShapeType_Name",
	Container_ID as "Relation_ID",
	@Column_int as "Relation_TypeID",
	@Column_var as "Relation_Name",
	@Column_var as "Relation_Desc",
	@Column_int as "Related_ContainerID",
	@Column_int as "Related_ContainerTypeID",
	@Column_int as "Related_ContainerAbstractionID",
	@Column_var as "Related_ContainerName",
	@Column_var as "Related_ContainerAbstraction",
	SDTable_ID_Container as "Item_Table",
	SD_ID_Container as "Item_ID",
	@Column_int as "Item_TypeID",
	@Column_int as "Item_AbstractionID",
	@Column_var as "Item_Name",
	@Column_var as "Item_Desc",
	@Column_var as "Item_TypeName",
	SDTable_ID_Contained as "Related_Table",
	SD_ID_Contained as "Related_ID",
	@Column_int as "Related_TypeID",
	@Column_int as "Related_AbstractionID",
	@Column_var as "Related_Name",
	@Column_var as "Related_Desc",
	@Column_var as "Related_TypeName",
	SDTable_ID_Container as "SDTable_ID_BEGIN",
	SD_ID_Container as "SD_ID_BEGIN",
	@Column_int as "Begin_TypeID",
	@Column_var as "Begin_TypeName",
	SDTable_ID_Contained as "SDTable_ID_END",
	SD_ID_Contained as "SD_ID_END",
	@Column_int as "End_TypeID",
	@Column_var as "End_TypeName"
INTO #TempTable 
FROM Container NOLOCK
WHERE SDTable_ID_Container = @Table 
	AND SD_ID_Container = @ID

BEGIN TRAN 

UPDATE  #TempTable SET Container_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #TempTable SET Container_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #TempTable SET Contained_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #TempTable SET Contained_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #TempTable SET ShapeType_ID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Contained)
UPDATE  #TempTable SET ShapeType_Name = (SELECT DISTINCT ShapeType_Name FROM ShapeType WHERE ShapeType.ShapeType_ID = #TempTable.ShapeType_ID)
UPDATE  #TempTable SET NameContainer = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)+'('+(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Contained)+')'

-- Contained is a shape, check for its container shape (currently the only shape is object, dont know if this will change later)
UPDATE #TempTable SET Contained_ShapeContainerID = (SELECT DISTINCT SD_ID_Container FROM Container WHERE Container.SDTable_ID_Contained = #TempTable.SDTable_ID_Contained AND Container.SD_ID_Contained = #TempTable.SD_ID_Contained AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT'))
UPDATE #TempTable SET Contained_ShapeContainerName = (SELECT Shape_Name FROM Shape WHERE Shape_ID = Contained_ShapeContainerID)				
UPDATE  #TempTable SET Item_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #TempTable SET Item_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
UPDATE  #TempTable SET Item_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)
UPDATE  #TempTable SET Item_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Container)

UPDATE  #TempTable SET Relation_TypeID = 
CASE
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
	WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')

END

	UPDATE  #TempTable SET Item_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Container)
	UPDATE  #TempTable SET Item_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
	UPDATE  #TempTable SET Item_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)
	UPDATE  #TempTable SET Item_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Container)
	UPDATE  #TempTable SET Related_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Contained)
	UPDATE  #TempTable SET Related_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_TypeID)
	UPDATE  #TempTable SET Related_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Contained)
	UPDATE  #TempTable SET Related_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Contained)

	UPDATE #TempTable SET Related_ContainerAbstraction=
		CASE 
			WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT')
			WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP')
			WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'PIECE') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECTPIECE')
		END

	UPDATE #TempTable SET Related_ContainerID=(SELECT DISTINCT SD_ID_Container FROM Container WHERE SD_ID_Contained = Related_ID AND SDTable_ID_Contained = Related_Table AND Abstraction_ID = Related_ContainerAbstraction)
	UPDATE #TempTable SET Related_ContainerTypeID=(SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Related_ContainerID)
	UPDATE #TempTable SET Related_ContainerAbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_ContainerTypeID)
	UPDATE #TempTable SET Related_ContainerName=(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = Related_ContainerID)

	UPDATE  #TempTable SET Begin_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
	UPDATE  #TempTable SET Begin_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  = Begin_TypeID)
	UPDATE  #TempTable SET End_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_End)
	UPDATE  #TempTable SET End_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  =  End_TypeID)

--- MOSTLY FOR VISIO : USE ABSTRACTION IS NULL TO GET ALL RELATIONS EXCEPT FOR ARTIFACT RELATIONS
--- OVERWRITE Contained_Name and Contained_Desc if SEARCHING FOR ARTIFACT RELATIONS
IF @Abstraction IS NOT NULL
	BEGIN
		DELETE FROM #TempTable WHERE Abstraction_ID <> @Abstraction
		IF @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT')			
			BEGIN
				UPDATE  #TempTable SET Contained_Name = (SELECT DISTINCT Artifact_Name FROM Artifact WHERE Artifact_ID = SD_ID_Contained)
				UPDATE  #TempTable SET Contained_Desc = (SELECT DISTINCT Artifact_Loc FROM Artifact WHERE Artifact_ID = SD_ID_Contained)
			END
	END	
ELSE
	BEGIN
		DELETE FROM #TempTable WHERE Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT')			
	END

SELECT * FROM #TempTable ORDER BY ShapeType_Name, Contained_Name

DROP TABLE #TempTable

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[GetItem_ConstrainedValues]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_ConstrainedValues] (@Table as int, @ID as int) 
AS

SELECT *
FROM ConstrainedValue
WHERE SDTable_ID = @Table 
	AND SD_ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[GetItem_AttributeValue2]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_AttributeValue2] (@Table as int, @ID as int, @STA as int) 
AS

/* 
SDTable Shape = 4
GET all attribute w/ their values if @STA is null
GET specified @STA is value is not null
*/

IF @Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name='Shape')
	BEGIN
		IF @STA IS NULL
			BEGIN
				SELECT DISTINCT STA.ShapeTypeAttribute_ID, STA.ShapeTypeAttribute_Desc,
					A.Attribute_ID, A.Attribute_Name, 
					AV.AttributeValue_ID, AV.AttributeValue_Value
				FROM AttributeValue AS AV 
					RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
						AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
					LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  				
					LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
				WHERE ST.ShapeType_ID = (SELECT ShapeType_ID FROM Shape WHERE Shape_ID = @ID)
				ORDER BY A.Attribute_Name
			END
		ELSE
			BEGIN
				SELECT DISTINCT STA.ShapeTypeAttribute_ID, 
					A.Attribute_ID, A.Attribute_Name,
					AV.AttributeValue_ID, AV.AttributeValue_Value
				FROM AttributeValue AS AV 
					RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
						AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
					LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  				
					LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
				WHERE STA.ShapeTypeAttribute_ID = @STA
				ORDER BY A.Attribute_Name
			END
	END
ELSE
	BEGIN
		IF @Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name='Relation')
			BEGIN
				DECLARE @Abstraction int
				DECLARE @Type int
				DECLARE @TypeSystem int
				DECLARE @TypeObject int
				DECLARE @TypeMachine int
				SET @Abstraction = (SELECT Abstraction_ID FROM Relation WHERE Relation_ID = @ID)
				SET @TypeSystem = (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')
				SET @TypeObject = (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
				SET @TypeMachine = (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SERVERRELATION')
				SET @Type =
					CASE 
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='MACHINE') THEN @TypeMachine
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECT') THEN @TypeObject
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEM') THEN @TypeSystem
					END

				IF @STA IS NULL
					BEGIN
						SELECT DISTINCT STA.ShapeTypeAttribute_ID, 
							A.Attribute_ID, A.Attribute_Name,
							AV.AttributeValue_ID, AV.AttributeValue_Value
						FROM AttributeValue AS AV 
							RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
								AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
							LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  										LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
						WHERE ST.ShapeType_ID = @Type
						ORDER BY A.Attribute_Name
					END
				ELSE
					BEGIN
						SELECT DISTINCT STA.ShapeTypeAttribute_ID, 
							A.Attribute_ID, A.Attribute_Name,
							AV.AttributeValue_ID, AV.AttributeValue_Value
						FROM AttributeValue AS AV 
							RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
								AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
							LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  										LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
						WHERE STA.ShapeTypeAttribute_ID = @STA
						ORDER BY A.Attribute_Name
					END
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[GetItem_AttributeValue]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_AttributeValue] (@Table as int, @ID as int, @STA as int) 
AS

/* 
SDTable Shape = 4
GET all attribute w/ their values if @STA is null
GET specified @STA is value is not null
*/

IF @Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name='Shape')
	BEGIN
		IF @STA IS NULL
			BEGIN
				SELECT DISTINCT STA.ShapeTypeAttribute_ID, STA.ShapeTypeAttribute_Desc,
					A.Attribute_ID, A.Attribute_Name,
					AV.AttributeValue_ID, AV.AttributeValue_Value
				FROM AttributeValue AS AV 
					RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
						AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
					LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  				
					LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
				WHERE ST.ShapeType_ID = (SELECT ShapeType_ID FROM Shape WHERE Shape_ID = @ID)
				ORDER BY A.Attribute_Name
			END
		ELSE
			BEGIN
				SELECT DISTINCT STA.ShapeTypeAttribute_ID, STA.ShapeTypeAttribute_Desc, 
					A.Attribute_ID, A.Attribute_Name,
					AV.AttributeValue_ID, AV.AttributeValue_Value
				FROM AttributeValue AS AV 
					RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
						AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
					LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  				
					LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
				WHERE STA.ShapeTypeAttribute_ID = @STA
				ORDER BY A.Attribute_Name
			END
	END
ELSE
	BEGIN
		IF @Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name='Relation')
			BEGIN
				DECLARE @Abstraction int
				DECLARE @Type int
				SET @Abstraction = (SELECT Abstraction_ID FROM Relation WHERE Relation_ID = @ID)
				SET @Type =
					CASE 
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECT') THEN  (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
						WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
					END

				IF @STA IS NULL
					BEGIN
						SELECT DISTINCT STA.ShapeTypeAttribute_ID, STA.ShapeTypeAttribute_Desc, 
							A.Attribute_ID, A.Attribute_Name,
							AV.AttributeValue_ID, AV.AttributeValue_Value
						FROM AttributeValue AS AV 
							RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
								AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
							LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  										LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
						WHERE ST.ShapeType_ID = @Type
						ORDER BY A.Attribute_Name
					END
				ELSE
					BEGIN
						SELECT DISTINCT STA.ShapeTypeAttribute_ID, STA.ShapeTypeAttribute_Desc, 
							A.Attribute_ID, A.Attribute_Name,
							AV.AttributeValue_ID, AV.AttributeValue_Value
						FROM AttributeValue AS AV 
							RIGHT JOIN ShapeTypeAttribute AS STA ON AV.ShapeTypeAttribute_ID = STA.ShapeTypeAttribute_ID
								AND AV.SDTable_ID = @Table AND AV.SD_ID = @ID 
							LEFT JOIN ShapeType AS ST ON STA.ShapeType_ID = ST.ShapeType_ID  										LEFT JOIN Attribute AS A ON STA.Attribute_ID = A.Attribute_ID
						WHERE STA.ShapeTypeAttribute_ID = @STA
						ORDER BY A.Attribute_Name
					END
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[GetItem_Abstraction]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem_Abstraction] (@Table as int, @ID as int) 
AS

DECLARE @T varchar(100)
DECLARE @T_ID varchar(103)
DECLARE @ProcSelect varchar(2000)

SET @T = (SELECT SDTable_Name FROM SDTable WHERE SDTable_ID = @Table)
SET @T_ID = @T + '_ID'

SET @ProcSelect = "SELECT * FROM " + @T + " WHERE " + @T_ID + " = " +  CAST(@ID as varchar(100))

EXEC (@ProcSelect)
GO
/****** Object:  StoredProcedure [dbo].[GetItem]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetItem] (@Table as int, @ID as int) 
AS

DECLARE @T varchar(100)
DECLARE @T_ID varchar(103)
DECLARE @ProcSelect varchar(2000)

SET @T = (SELECT SDTable_Name FROM SDTable WHERE SDTable_ID = @Table)
SET @T_ID = @T + '_ID'

IF @T = 'Shape' 
	BEGIN
		SET @ProcSelect = "SELECT * FROM Shape, Lifecycle,ShapeType WHERE Shape_ID = " +  CAST(@ID as varchar(100)) + " AND Lifecycle.Lifecycle_ID = Shape.Lifecycle_ID AND ShapeType.ShapeType_ID = Shape.ShapeType_ID " 
	END
ELSE
	BEGIN
		SET @ProcSelect = "SELECT * FROM " + @T + " WHERE " + @T_ID + " = " +  CAST(@ID as varchar(100))
	END


EXEC (@ProcSelect)
GO
/****** Object:  StoredProcedure [dbo].[GetContainer2]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContainer2] (@ID as int) 
AS

DECLARE @Column_var varchar(1000)
DECLARE @Column_int int
DECLARE @Temp int
DECLARE @Proc varchar(1000)


SELECT Container_ID,
	SDTable_ID_Container, SD_ID_Container,
	SDTable_ID_Contained, SD_ID_Contained,
	Abstraction_ID,
	-- FOR VISIO Drawing simplification
	Container_ID as "Relation_ID",
	@Column_int as "Relation_TypeID",
	@Column_var as "Relation_Name",
	@Column_var as "Relation_Desc",
	@Column_int as "Related_ContainerID",
	@Column_int as "Related_ContainerTypeID",
	@Column_int as "Related_ContainerAbstractionID",
	@Column_var as "Related_ContainerName",
	@Column_var as "Related_ContainerAbstraction",
	SDTable_ID_Container as "Item_Table",
	SD_ID_Container as "Item_ID",
	@Column_int as "Item_TypeID",
	@Column_int as "Item_AbstractionID",
	@Column_var as "Item_Name",
	@Column_var as "Item_Desc",
	@Column_var as "Item_TypeName",
	@Column_int as "Item_ContainerID",
	@Column_int as "Item_ContainerTypeID",
	@Column_int as "Item_ContainerAbstractionID",
	@Column_var as "Item_ContainerName",
	@Column_var as "Item_ContainerAbstraction",
	SDTable_ID_Contained as "Related_Table",
	SD_ID_Contained as "Related_ID",
	@Column_int as "Related_TypeID",
	@Column_int as "Related_AbstractionID",
	@Column_var as "Related_Name",
	@Column_var as "Related_Desc",
	@Column_var as "Related_TypeName",
	SDTable_ID_Container as "SDTable_ID_BEGIN",
	SD_ID_Container as "SD_ID_BEGIN",
	SDTable_ID_Contained as "SDTable_ID_END",
	SD_ID_Contained as "SD_ID_END",
	@Column_int as "Begin_TypeID",
	@Column_var as "Begin_TypeName",
	@Column_int as "End_TypeID",
	@Column_var as "End_TypeName"
INTO #Temp1 
FROM Container NOLOCK
WHERE Container_ID = @ID

	UPDATE  #Temp1 SET Relation_TypeID = 
		CASE
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')


			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')
		END
	
	UPDATE  #Temp1 SET Item_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Container)
	UPDATE  #Temp1 SET Item_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
	UPDATE  #Temp1 SET Item_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)
	UPDATE  #Temp1 SET Item_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Container)

	UPDATE #Temp1 SET Item_ContainerAbstraction=
		CASE 
			WHEN Item_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT')
			WHEN Item_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP')
			WHEN Item_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'PIECE') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECTPIECE')
		END
	
	UPDATE #Temp1 SET Item_ContainerID=(SELECT DISTINCT SD_ID_Container FROM Container WHERE SD_ID_Contained = Item_ID AND SDTable_ID_Contained = Item_Table AND Abstraction_ID = Item_ContainerAbstraction)
	UPDATE #Temp1 SET Item_ContainerTypeID=(SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Item_ContainerID)
	UPDATE #Temp1 SET Item_ContainerAbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_ContainerTypeID)
	UPDATE #Temp1 SET Item_ContainerName=(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = Item_ContainerID)


	UPDATE  #Temp1 SET Related_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Contained)
	UPDATE  #Temp1 SET Related_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_TypeID)
	UPDATE  #Temp1 SET Related_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Contained)
	UPDATE  #Temp1 SET Related_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Contained)
	
	UPDATE #Temp1 SET Related_ContainerAbstraction=
		CASE 
			WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT')
			WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP')
			WHEN Related_AbstractionID= (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'PIECE') THEN (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='OBJECTPIECE')
		END
	
	UPDATE #Temp1 SET Related_ContainerID=(SELECT DISTINCT SD_ID_Container FROM Container WHERE SD_ID_Contained = Related_ID AND SDTable_ID_Contained = Related_Table AND Abstraction_ID = Related_ContainerAbstraction)
	UPDATE #Temp1 SET Related_ContainerTypeID=(SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = Related_ContainerID)
	UPDATE #Temp1 SET Related_ContainerAbstractionID=(SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_ContainerTypeID)
	UPDATE #Temp1 SET Related_ContainerName=(SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = Related_ContainerID)
	
	UPDATE  #Temp1 SET Begin_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
	UPDATE  #Temp1 SET Begin_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  = Begin_TypeID)
	UPDATE  #Temp1 SET End_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_End)
	UPDATE  #Temp1 SET End_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  =  End_TypeID)


SELECT * FROM #Temp1

DROP TABLE #Temp1
GO
/****** Object:  StoredProcedure [dbo].[GetContainer]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContainer] (@ID as int) 
AS

DECLARE @Column_var varchar(1000)
DECLARE @Column_int int
DECLARE @Temp int
DECLARE @Proc varchar(1000)


SELECT Container_ID,
	SDTable_ID_Container, SD_ID_Container,
	SDTable_ID_Contained, SD_ID_Contained,
	Abstraction_ID,
	-- FOR VISIO Drawing simplification
	Container_ID as "Relation_ID",
	@Column_int as "Relation_TypeID",
	@Column_var as "Relation_Name",
	@Column_var as "Relation_Desc",
	SDTable_ID_Container as "Item_Table",
	SD_ID_Container as "Item_ID",
	@Column_int as "Item_TypeID",
	@Column_int as "Item_AbstractionID",
	@Column_var as "Item_Name",
	@Column_var as "Item_Desc",
	@Column_var as "Item_TypeName",
	SDTable_ID_Contained as "Related_Table",
	SD_ID_Contained as "Related_ID",
	@Column_int as "Related_TypeID",
	@Column_int as "Related_AbstractionID",
	@Column_var as "Related_Name",
	@Column_var as "Related_Desc",
	@Column_var as "Related_TypeName",
	SDTable_ID_Container as "SDTable_ID_BEGIN",
	SD_ID_Container as "SD_ID_BEGIN",
	SDTable_ID_Contained as "SDTable_ID_END",
	SD_ID_Contained as "SD_ID_END",
	@Column_int as "Begin_TypeID",
	@Column_var as "Begin_TypeName",
	@Column_int as "End_TypeID",
	@Column_var as "End_TypeName"
INTO #Temp1 
FROM Container NOLOCK
WHERE Container_ID = @ID

	UPDATE  #Temp1 SET Relation_TypeID = 
		CASE
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEPOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICEOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'STEPRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'DEVICERELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'OBJECTRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'CROSSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSRELATION')
			WHEN Abstraction_ID = (SELECT DISTINCT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM') THEN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEMRELATION')
		END
	
	UPDATE  #Temp1 SET Item_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Container)
	UPDATE  #Temp1 SET Item_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Item_TypeID)
	UPDATE  #Temp1 SET Item_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Container)
	UPDATE  #Temp1 SET Item_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Container)

	UPDATE  #Temp1 SET Related_TypeID = (SELECT DISTINCT ShapeType_ID FROM Shape WHERE Shape_ID = SD_ID_Contained)
	UPDATE  #Temp1 SET Related_AbstractionID = (SELECT DISTINCT Abstraction_ID FROM ShapeType WHERE ShapeType_ID = Related_TypeID)
	UPDATE  #Temp1 SET Related_Name = (SELECT DISTINCT Shape_Name FROM Shape WHERE Shape_ID = SD_ID_Contained)
	UPDATE  #Temp1 SET Related_Desc = (SELECT DISTINCT Shape_Desc FROM Shape WHERE Shape_ID = SD_ID_Contained)
	
	UPDATE  #Temp1 SET Begin_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_Begin)
	UPDATE  #Temp1 SET Begin_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  = Begin_TypeID)
	UPDATE  #Temp1 SET End_TypeID = (SELECT DISTINCT ShapeType_ID  FROM Shape WHERE Shape_ID  = SD_ID_End)
	UPDATE  #Temp1 SET End_TypeName = (SELECT DISTINCT ShapeType_Name  FROM ShapeType WHERE ShapeType_ID  =  End_TypeID)


SELECT * FROM #Temp1

DROP TABLE #Temp1
GO
/****** Object:  StoredProcedure [dbo].[GetAttributeList]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAttributeList] AS

SELECT 	
*
FROM 	
	Attribute
ORDER BY
	Attribute_Name
GO
/****** Object:  StoredProcedure [dbo].[GetArtifactList]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetArtifactList] AS

SELECT 
	* 
FROM 
	Artifact
ORDER BY 
	Artifact_Name
GO
/****** Object:  StoredProcedure [dbo].[GetReport_LevelAttributeList]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[GetReport_LevelAttributeList]  AS

select distinct 
	(select top 1 shapetypeattribute_id 
		from shapetypeattribute 
		where attribute_id = sta.attribute_id
			and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ab.abstraction_id ) )as sta_id,
	(abstraction_name + ' ' + attribute_name) as sta_name,
	sta.attribute_id, attribute_name, ab.abstraction_id, abstraction_name
	from shapetypeattribute as sta
	left join attribute as a 
		on sta.attribute_id = a.attribute_id
	left join shapetype as st	
		on sta.shapetype_id = st.shapetype_id	
	left join abstraction as ab
		on ab.abstraction_id = st.abstraction_id
where ab.abstraction_id in (1,2,3,10,11)
order by ab.abstraction_id,  attribute_name
GO
/****** Object:  StoredProcedure [dbo].[DeleteItem]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteItem](@Table as int, @ID as int, @Function as int, @Name as varchar(1000), @Note as varchar(1000), @Contact as varchar(500), @NewID as int out) AS

DECLARE @Column_VarChar varchar(1000)

	-- DO ONE MORE CHECK TO BE SURE THAT ITEM QUALIFIES FOR DELETION
	IF (SELECT COUNT(*) FROM Relation WHERE (SDTable_ID_Begin = @Table AND SD_ID_Begin = @ID) OR (SDTable_ID_End = @Table AND SD_ID_End = @ID)) > 0
		BEGIN
			SET @NewID = 0
		END
	ELSE
		BEGIN
			IF (SELECT COUNT(*) FROM Container WHERE (SDTable_ID_Container = @Table AND SD_ID_Container = @ID) AND (Abstraction_ID NOT IN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name IN ('ARTIFACT','IP')))) > 0		
				BEGIN
					SET @NewID = 0				
				END
			ELSE
				BEGIN
					-- 1.0 GET LIST OF IPs THAT NEEDS TO BE DELETED
					SELECT 
						SDTable_ID_Contained as "DeleteTable",
						SD_ID_Contained as "DeleteID",
						(SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_SHAPE') as "DeleteFunction",
						@Column_VarChar as "DeleteValue",
						@Note as "DeleteNote",
						@Contact as "DeleteContact",
						getDate() as "DeleteDateTime"
					INTO #TempTable
					FROM Container
					WHERE SDTable_ID_Contained = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'SHAPE') AND SDTable_ID_Container = @Table and SD_ID_Container = @ID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'IP')
					-- 1.1 GET IP CONTAINER THAT NEEDS TO BE DELETED
					UNION SELECT 
						(SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Container') as "DeleteTable",
						Container_ID as "DeleteID",
						(SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_CONTAINER') as "DeleteFunction",
						@Column_VarChar as "DeleteValue",
						@Note as "DeleteNote",
						@Contact as "DeleteContact",
						getDate() as "DeleteDateTime"
					FROM Container
					WHERE SDTable_ID_Contained = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'SHAPE') AND SDTable_ID_Container = @Table and SD_ID_Container = @ID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'IP')
					-- 1.2 GET ARTIFACT CONTAINER THAT NEEDS TO BE DELETED
					UNION SELECT 
						(SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Container') as "DeleteTable",
						Container_ID as "DeleteID",
						(SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_CONTAINER') as "DeleteFunction",
						@Column_VarChar as "DeleteValue",
						@Note as "DeleteNote",
						@Contact as "DeleteContact",
						getDate() as "DeleteDateTime"
					FROM Container
					WHERE SDTable_ID_Contained = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ARTIFACT') AND SDTable_ID_Container = @Table and SD_ID_Container = @ID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT')
					-- 1.3 GET LIST OF ATTRIBUTEVALUEs THAT NEEDS TO BE DELETED
					UNION SELECT 
						(SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'AttributeValue') as "DeleteTable",
						AttributeValue_ID as "DeleteID",
						(SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_ATTRIBUTEVALUE') as "DeleteFunction",
						@Column_VarChar as "DeleteValue",
						@Note as "DeleteNote",
						@Contact as "DeleteContact",
						getDate() as "DeleteDateTime"
					FROM AttributeValue
					WHERE SDTable_ID = @Table AND SD_ID = @ID 
					-- 1.4 GET SHAPE CONTAINER THAT NEEDS TO BE DELETED
					UNION SELECT 
						(SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Container') as "DeleteTable",
						Container_ID as "DeleteID",
						(SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_CONTAINER') as "DeleteFunction",
						@Column_VarChar as "DeleteValue",
						@Note as "DeleteNote",
						@Contact as "DeleteContact",
						getDate() as "DeleteDateTime"
					FROM Container
					WHERE SDTable_ID_Contained = @Table and SD_ID_Contained = @ID 
					-- 1.5 GET SHAPE THAT NEEDS TO BE DELETED
					UNION SELECT
						@Table as "DeleteTable",
						@ID as "DeleteID",
						@Function as "DeleteFunction",
						@Column_VarChar as "DeleteValue",
						@Note as "DeleteNote",
						@Contact as "DeleteContact",
						getDate() as "DeleteDateTime"
					FROM Shape
					WHERE Shape_ID = @ID
				
					-- 2 LOG DELETION
					INSERT INTO SDLog(SDTable_ID, SD_ID, SDLogFunction_ID, SDLog_Value, SDLog_Note, SDLog_Contact, SDLog_DateTime)
						SELECT   DeleteTable, DeleteID, DeleteFunction, DeleteValue, DeleteNote, DeleteContact, DeleteDateTime FROM #TempTable
				
					-- 3.0 DELETE IPs AND SHAPE
					DELETE FROM Shape WHERE Shape_ID IN (SELECT DeleteID FROM #TempTable WHERE DeleteFunction = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_SHAPE') )
					-- 3.1 DELETE ATTRIBUTE VALUEs
					DELETE FROM AttributeValue WHERE AttributeValue_ID IN (SELECT DeleteID FROM #TempTable WHERE DeleteFunction = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_ATTRIBUTEVALUE') )
					-- 3.2 DELETE CONTAINERs
					DELETE FROM Container WHERE Container_ID IN (SELECT DeleteID FROM #TempTable WHERE DeleteFunction = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_CONTAINER') )

					SET @NewID = 1
		
				END
	END
GO
/****** Object:  StoredProcedure [dbo].[GetShapeTypeList]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetShapeTypeList] (@Abstraction as int)  AS

IF @Abstraction IS NULL 
	BEGIN
		SELECT * FROM ShapeType ORDER BY ShapeType_Name
	END
ELSE
	BEGIN
		SELECT * FROM ShapeType WHERE Abstraction_ID = @Abstraction  ORDER BY ShapeType_Name
	END
GO
/****** Object:  StoredProcedure [dbo].[GetShapeTypeAttributeList]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetShapeTypeAttributeList](@ST_ID as int,@A_ID as int) AS

/*
	IF no shapetype or attribute criteria
		RETURN non-null shapetypes & attributes
	IF attribute only criteria
		RETURN non-null shapetypes & all attributes
	IF shapetype only criteria
		RETURN non-null attributes & all shapetypes
*/

IF @ST_ID = 0 
	BEGIN
		IF @A_ID = 0
			BEGIN --IF no shapetype or attribute criteria
				SELECT DISTINCT 
						ShapeTypeAttribute.ShapeTypeAttribute_ID,
						ShapeTypeAttribute.ShapeTypeAttribute_Desc,
						Attribute.Attribute_Name + ' - ' + ShapeType.ShapeType_Name as ShapeTypeAttribute_Name,
						ShapeType.ShapeType_ID, 
						ShapeType.ShapeType_Name, 
						Attribute.Attribute_ID,
						Attribute.Attribute_Name
				FROM Attribute
				RIGHT JOIN ShapeTypeAttribute ON Attribute.Attribute_ID = ShapeTypeAttribute.Attribute_ID 
				LEFT JOIN ShapeType ON ShapeTypeAttribute.ShapeType_ID = ShapeType.ShapeType_ID 
				ORDER BY Attribute.Attribute_Name, ShapeType.ShapeType_Name
			END --IF no shapetype or attribute criteria
		ELSE
			BEGIN -- IF attribute only criteria
				SELECT DISTINCT 
					ShapeTypeAttribute.ShapeTypeAttribute_ID,
					ShapeTypeAttribute.ShapeTypeAttribute_Desc,
					ShapeType.ShapeType_ID, 
					ShapeType.ShapeType_Name, 
					Attribute.Attribute_ID,
					Attribute.Attribute_Name
				FROM ShapeType 
				LEFT JOIN ShapeTypeAttribute ON ShapeType.ShapeType_ID = ShapeTypeAttribute.ShapeType_ID 
					AND (ShapeTypeAttribute.Attribute_ID = @A_ID OR ShapeTypeAttribute.Attribute_ID IS NULL)
				LEFT JOIN Attribute ON ShapeTypeAttribute.Attribute_ID = Attribute.Attribute_ID
				ORDER BY ShapeType_Name
			END -- IF attribute only criteria
	END	
ELSE
	BEGIN
		IF @A_ID = 0
			BEGIN --IF shapetype only criteria
				SELECT DISTINCT 
					ShapeTypeAttribute.ShapeTypeAttribute_ID,
					ShapeTypeAttribute.ShapeTypeAttribute_Desc,
					ShapeType.ShapeType_ID, 
					ShapeType.ShapeType_Name, 
					Attribute.Attribute_ID,
					Attribute.Attribute_Name
				FROM Attribute
				LEFT JOIN ShapeTypeAttribute ON Attribute.Attribute_ID = ShapeTypeAttribute.Attribute_ID AND ShapeTypeAttribute.ShapeType_ID = @ST_ID
				LEFT JOIN ShapeType ON ShapeTypeAttribute.ShapeType_ID = ShapeType.ShapeType_ID 
				ORDER BY Attribute.Attribute_Name
			END --IF shapetype only criteria
	END
GO
/****** Object:  StoredProcedure [dbo].[GetShapeTypeAttribute]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetShapeTypeAttribute] (@ID as int)  AS

select sta.shapetypeattribute_id, shapetypeattribute_desc, 
	shape_id, shape_name, shape_desc,
	st.shapetype_id, st.shapetype_name,
	a.attribute_id, a.attribute_name, 
	cv.constrainedvalue_values,
	av.attributevalue_id, av.attributevalue_value
from shapetypeattribute as sta
	left join attribute as a on sta.attribute_id = a.attribute_id
	left join shapetype as st on sta.shapetype_id = st.shapetype_id
	left join constrainedvalue as cv on sta.shapetypeattribute_id = cv.sd_id AND cv.sdtable_id = 5
	left join attributevalue as av on sta.shapetypeattribute_id = av.shapetypeattribute_id
	left join shape as s on s.shape_id = av.SD_id
where sta.shapetypeattribute_id = @iD

order by shape_name
GO
/****** Object:  StoredProcedure [dbo].[GetShapeList_Deletable]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetShapeList_Deletable] (@Type as int) 

AS

DECLARE @Column_var varchar(500)
DECLARE @Column_int int

SELECT 
	@Column_int as "Item_Table",
	Shape_ID as "Item_ID" ,
	Shape_Name as "Item_Name",
	Shape_Desc as "Item_Desc",
	ShapeType_ID as "Item_TypeID",
	@Column_var as "Item_TypeName",
	@Column_int as "Container_ID",
	@Column_var as "Container_Name",
	@Column_var as "Display_Name"
INTO #TempTable 
FROM Shape NOLOCK
	WHERE ShapeType_ID = @Type

UPDATE  #TempTable SET Item_Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape')


UPDATE  #TempTable SET Container_ID =
	CASE
		WHEN Item_TypeID IN (SELECT ShapeType_ID FROM ShapeType WHERE Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name ='OBJECT'))THEN (SELECT SD_ID_Container FROM Container WHERE SDTable_ID_Container = #TempTable.Item_Table AND SDTable_ID_Contained = #TempTable.Item_Table AND SD_ID_Contained = #TempTable.Item_ID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT'))
		WHEN Item_TypeID IN (SELECT ShapeType_ID FROM ShapeType WHERE Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name ='STEP'))THEN (SELECT SD_ID_Container FROM Container WHERE SDTable_ID_Container = #TempTable.Item_Table AND SDTable_ID_Contained = #TempTable.Item_Table AND SD_ID_Contained = #TempTable.Item_ID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP'))
	END

UPDATE  #TempTable SET Container_Name = (SELECT Shape_Name FROM Shape WHERE Shape_ID= #TempTable.Container_ID)

UPDATE  #TempTable SET Display_Name =
	CASE
		WHEN Container_Name IS NOT NULL THEN '[' + Container_Name  + '] ' + Item_Name 
		ELSE Item_Name
	END

-- IF SHAPE HAS RELATIONS, IT IS NOT DELETEABLE, SO REMOVE FROM LIST
DELETE FROM #TempTable WHERE Item_ID IN (SELECT SD_ID_Begin FROM Relation WHERE SDTable_ID_Begin = Item_Table AND SD_ID_Begin = Item_ID)
DELETE FROM #TempTable WHERE Item_ID IN (SELECT SD_ID_End FROM Relation WHERE SDTable_ID_End = Item_Table AND SD_ID_End = Item_ID)

-- IF SHAPE IS A NON-ARTIFACT CONTAINER, IT IS NOT DELETEABLE, SO REMOVE FROM LIST
DELETE FROM #TempTable WHERE Item_ID IN (SELECT SD_ID_Container FROM Container WHERE SDTable_ID_Container = Item_Table AND SD_ID_Container = Item_ID AND ((Abstraction_ID <> (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT')) AND (Abstraction_ID <> (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'IP'))))

SELECT * FROM #TempTable ORDER BY Display_Name

DROP TABLE #TempTable
GO
/****** Object:  StoredProcedure [dbo].[GetShapeList_Browser]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetShapeList_Browser] (@Type as int) 

AS

DECLARE @Column_var varchar(500)
DECLARE @Column_int int

SELECT 
	@Column_int as "Item_Table",
	Shape_ID as "Item_ID" ,
	Shape_Name as "Item_Name",
	@Column_int as "Container_ID",
	@Column_var as "Container_Name",
	ISNULL(Shape_Desc,'') as "Item_Desc",
	ShapeType_ID as "Item_TypeID",
	@Column_var as "Item_TypeName",
	@Column_var as "Display_Name"
INTO #TempTable 
FROM Shape NOLOCK
	WHERE ShapeType_ID = @Type

UPDATE  #TempTable SET Item_Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape')

UPDATE  #TempTable SET Container_ID =
	CASE
		WHEN Item_TypeID IN (SELECT ShapeType_ID FROM ShapeType WHERE Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name ='OBJECT'))THEN (SELECT SD_ID_Container FROM Container WHERE SDTable_ID_Container = #TempTable.Item_Table AND SDTable_ID_Contained = #TempTable.Item_Table AND SD_ID_Contained = #TempTable.Item_ID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='SYSTEMOBJECT'))
		WHEN Item_TypeID IN (SELECT ShapeType_ID FROM ShapeType WHERE Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name ='STEP'))THEN (SELECT SD_ID_Container FROM Container WHERE SDTable_ID_Container = #TempTable.Item_Table AND SDTable_ID_Contained = #TempTable.Item_Table AND SD_ID_Contained = #TempTable.Item_ID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name='BUSINESSSTEP'))
	END

UPDATE  #TempTable SET Item_TypeName = ISNULL((SELECT ShapeType_Name FROM ShapeType WHERE ShapeType_ID = #TempTable.Item_TypeID),'')

UPDATE  #TempTable SET Container_Name = ISNULL((SELECT Shape_Name FROM Shape WHERE Shape_ID= #TempTable.Container_ID),'')

UPDATE  #TempTable SET Display_Name =
	CASE
		WHEN Container_Name IS NOT NULL THEN Item_Name + ' [' + Container_Name  + ']' 
		ELSE Item_Name
	END


SELECT * FROM #TempTable ORDER BY Display_Name

DROP TABLE #TempTable
GO
/****** Object:  StoredProcedure [dbo].[GetShapeList]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetShapeList]  (@Abstraction as int, @ShapeType as int)

AS

IF @Abstraction is not null 
	BEGIN
		IF @ShapeType is not null
			BEGIN
				select shape_id, shape_name, shape_desc,
					shapetype.shapetype_id, shapetype.shapetype_name,
					abstraction.abstraction_id, abstraction.abstraction_name  
				from abstraction
					left join shapetype on abstraction.abstraction_ID = shapetype.abstraction_ID 
					left join shape on shapetype.shapetype_id = shape.shapetype_id 
				where shape_name is not null 
					and abstraction.abstraction_id =@Abstraction
					and shapetype.shapetype_id = @ShapeType
				order by shape_name
			END
		ELSE
			BEGIN
				select shape_id, shape_name, shape_desc,
					shapetype.shapetype_id, shapetype.shapetype_name,
					abstraction.abstraction_id, abstraction.abstraction_name  
				from abstraction
					left join shapetype on abstraction.abstraction_ID = shapetype.abstraction_ID 
					left join shape on shapetype.shapetype_id = shape.shapetype_id 
				where shape_name is not null 
					and abstraction.abstraction_id =@Abstraction
				order by shape_name
			END
	END
ELSE
	BEGIN
		IF @ShapeType is not null
			BEGIN
				select shape_id, shape_name, shape_desc,
					shapetype.shapetype_id, shapetype.shapetype_name,
					abstraction.abstraction_id, abstraction.abstraction_name  
				from abstraction
					left join shapetype on abstraction.abstraction_ID = shapetype.abstraction_ID 
					left join shape on shapetype.shapetype_id = shape.shapetype_id 
				where shape_name is not null 
					and shapetype.shapetype_id = @ShapeType
				order by shape_name
			END
		ELSE
			BEGIN
				select shape_id, shape_name, shape_desc,
					shapetype.shapetype_id, shapetype.shapetype_name,
					abstraction.abstraction_id, abstraction.abstraction_name  
				from abstraction
					left join shapetype on abstraction.abstraction_ID = shapetype.abstraction_ID 
					left join shape on shapetype.shapetype_id = shape.shapetype_id 
				where shape_name is not null 
				order by shape_name
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[GetReport_ShapeTypeAttribute]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[GetReport_ShapeTypeAttribute] (@ID as int)  AS


select shape_id, shape_name, 
	(select sd_id_container from container where abstraction_id in (SELECT abstraction_id FROM abstraction WHERE abstraction_name = 'SYSTEMOBJECT' OR abstraction_name = 'BUSINESSSTEP') and sd_id_contained = s.shape_id) as sd_id_container,
	(select shape_name from shape where shape_id = (select sd_id_container from container where abstraction_id in (SELECT abstraction_id FROM abstraction WHERE abstraction_name = 'SYSTEMOBJECT' OR abstraction_name = 'BUSINESSSTEP') and sd_id_contained = s.shape_id)) as container_name,
	(select attribute_name from attribute where attribute_id = sta.attribute_id) as attribute_name,
	(select attributevalue_value from attributevalue where sdtable_id = 4 and sd_id = s.shape_id and shapetypeattribute_id = sta.shapetypeattribute_id) as attributevalue_value
into #temptable
from shape as s 
	join shapetypeattribute as sta on sta.shapetype_id = s.shapetype_id
where sta.shapetype_id = @ID

order by attribute_name
/*

select  shape_id, shape_name, sd_id_container,
	(SELECT Shape_name from shape where shape_id = sd_id_container) as container_name,
	 attribute_name, attributevalue_value 
	into #temptable
	from shapetypeattribute 
	left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id
	left join shapetype on shapetype.shapetype_id  = shapetypeattribute.shapetype_id
	left join shape on shape.shapetype_id = shapetype.shapetype_id
	left join container on container.sd_id_contained = shape.shape_id 
		and container.sdtable_id_contained =  (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape') 
		and container.abstraction_id  in (SELECT abstraction_id FROM abstraction WHERE abstraction_name = 'SYSTEMOBJECT' OR abstraction_name = 'BUSINESSSTEP')
	left join attributevalue on attributevalue.sdtable_id = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Shape')
		and attributevalue.sd_id = shape.shape_id 
		and shapetypeattribute.shapetypeattribute_id = attributevalue.shapetypeattribute_id
where  shapetypeattribute.shapetype_id = @ID
*/

SET NOCOUNT ON
SET CONCAT_NULL_YIELDS_NULL OFF
DECLARE @SELECT_FROM_TABLE nvarchar(1000)

CREATE TABLE #columns (col1 int identity(1,1),col2 varchar(100) default 'No data')

SET @SELECT_FROM_TABLE='INSERT INTO #Columns(col2) SELECT DISTINCT Attribute_Name FROM #temptable '

EXEC sp_executesql @SELECT_FROM_TABLE

DECLARE @LoopCount int
DECLARE @RecordCount int
DECLARE @ColumnsToSelect varchar(2000)
DECLARE @SumStatements varchar(4000)
DECLARE @QUERY nvarchar(4000)
DECLARE @Column_Value varchar(2000)

SET @ColumnsToSelect=''
SET @RecordCount=(Select Count(*) FROM #Columns)
SET @LoopCount=0

WHILE @LoopCount<=@RecordCount
BEGIN
SET @LoopCount= @LoopCount + 1
SET @Column_Value=(Select col2 from #Columns where col1=@LoopCount)
if DataLength(@Column_Value)>0
BEGIN
SET @ColumnsToSelect= @ColumnsToSelect + ' P1.[' + @Column_Value + '] + '
SET @SumStatements=@SumStatements + ' MAX(CASE P.Attribute_Name WHEN ''' + @Column_Value + ''' THEN AttributeValue_Value ELSE NULL END) AS [' + @Column_Value + '], '

END
END

SET @ColumnsToSelect='P1.*  '


SET @SumStatements=LEFT(@SumStatements,len(@SumStatements)-1) + '  FROM #temptable AS P GROUP BY P.Shape_Name, P.Container_Name WITH CUBE) AS P1'
SET @QUERY='SELECT ' + @columnsToSelect + ' FROM ( SELECT DISTINCT MAX(Shape_Name) AS Shape,  MAX(Container_Name) as Container '

IF CHARINDEX('MAX',@SumStatements)>0
SET @QUERY=@QUERY + ',' + @SumStatements
ELSE
SET @QUERY=@QUERY + @SumStatements

--print @query

exEC sp_executesql @QUERY

drop table #temptable
GO
/****** Object:  StoredProcedure [dbo].[TestSQL]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[TestSQL] AS

select  shape_id, shape_name, attribute_name, attributevalue_value into #temptable from shapetypeattribute 
	left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id
	left join shapetype on shapetype.shapetype_id  = shapetypeattribute.shapetype_id
	left join shape on shape.shapetype_id = shapetype.shapetype_id
	left join attributevalue on attributevalue.sdtable_id = 4 and attributevalue.sd_id = shape.shape_id and shapetypeattribute.shapetypeattribute_id = attributevalue.shapetypeattribute_id
where  shapetypeattribute.shapetype_id = 1

SET NOCOUNT ON
SET CONCAT_NULL_YIELDS_NULL OFF
DECLARE @SELECT_FROM_TABLE nvarchar(1000)

CREATE TABLE #columns (col1 int identity(1,1),col2 varchar(100) default 'No data')

SET @SELECT_FROM_TABLE='INSERT INTO #Columns(col2) SELECT DISTINCT [' + 'Attribute_Name' + '] FROM [' + '#temptable' + ']'

EXEC sp_executesql @SELECT_FROM_TABLE

DECLARE @LoopCount int
DECLARE @RecordCount int
DECLARE @ColumnsToSelect varchar(2000)
DECLARE @SumStatements varchar(4000)
DECLARE @QUERY nvarchar(4000)
DECLARE @Column_Value varchar(100)

SET @ColumnsToSelect=''
SET @RecordCount=(Select Count(*) FROM #Columns)
SET @LoopCount=0

WHILE @LoopCount<=@RecordCount
BEGIN
SET @LoopCount= @LoopCount + 1
SET @Column_Value=(Select col2 from #Columns where col1=@LoopCount)
if DataLength(@Column_Value)>0
BEGIN
SET @ColumnsToSelect= @ColumnsToSelect + ' P1.[' + @Column_Value + '] + '
SET @SumStatements=@SumStatements + ' MAX(CASE P.[' + 'Attribute_Name' + '] WHEN ''' + @Column_Value + ''' THEN ' + 'AttributeValue_Value' + ' ELSE NULL END) AS [' + @Column_Value + '], '

END
END

SET @ColumnsToSelect='P1.* '

SET @SumStatements=LEFT(@SumStatements,len(@SumStatements)-1) + ' FROM [' + '#temptable' + '] AS P GROUP BY P.[' +  'Shape_Name' + '] WITH CUBE) AS P1'

SET @QUERY='SELECT ' + @columnsToSelect + ' FROM (SELECT ISNULL([' + 'Shape_Name' + '],''TOTAL'') As [' +  'Shape_Name' +'] '

IF CHARINDEX('MAX',@SumStatements)>0
SET @QUERY=@QUERY + ',' + @SumStatements
ELSE
SET @QUERY=@QUERY + @SumStatements


exEC sp_executesql @QUERY

drop table #temptable

/*
-- SET ATTRIBUTE VALUES ENTRIES WITH DESCRIPTION IF ANY  INTO LOG
select distinct * into #temptable from AttributeValue nolock
	where AttributeValue_ID < 657
order by AttributeValue_ID 

DECLARE @Counter INT
DECLARE @Value varchar(1000)
DECLARE @Table INT
DECLARE @ID INT
DECLARE @STA_ID INT
DECLARE @Contact varchar(50)


SET @Counter = 0
SET @Contact = 'PACIFICMUTUAL\PLIN'

WHILE @Counter <  657
BEGIN
	IF (SELECT COUNT(*) FROM #temptable WHERE AttributeValue_ID = @Counter) > 0 
	BEGIN
		SET @Value = (SELECT AttributeValue_Value from #temptable WHERE AttributeValue_ID = @Counter)
		SET @Table = (SELECT SDTable_ID from #temptable WHERE AttributeValue_ID = @Counter)
		SET @ID = (SELECT SD_ID from #temptable WHERE AttributeValue_ID = @Counter)
		SET @STA_ID = (SELECT ShapeTypeAttribute_ID from #temptable WHERE AttributeValue_ID = @Counter)
		-- LOG  VALUE
		EXEC SetLog 6, @Counter, 17, @Value, NULL, @Contact
		-- LOG ITEM THAT HAS THIS VALUE
		EXEC SetLog 6, @Counter, 17, @Table, @ID, @Contact
		-- LOG SHAPETYPEATTRIBUTE OF THIS VALUE
		EXEC SetLog 6, @Counter, 17, 5, @STA_ID, @Contact
	END
	SET @Counter = @Counter + 1
END 


drop table #temptable
*/

/*
-- SET RELATION  ENTRIES WITH DESCRIPTION IF ANY  INTO LOG
select distinct * into #temptable from relation  nolock
	where relation_id < 1021
order by relation_id 

DECLARE @Counter INT
SET @Counter = 0

DECLARE @Value varchar(1000)
DECLARE @Table INT
DECLARE @ID INT

WHILE @Counter <  1021
BEGIN
	IF (SELECT COUNT(*) FROM #temptable WHERE Relation_ID = @Counter) > 0 
	BEGIN
		SET @Value = (SELECT Relation_Name from #temptable WHERE Relation_ID = @Counter)
		EXEC SetLog 7, @Counter, 13, @Value, NULL, 'PACIFICMUTUAL\PLIN'
		SET @ID = (SELECT Abstraction_ID  from #temptable WHERE Relation_ID = @Counter)
		EXEC SetLog 7, @Counter, 13, 1,  @ID, 'PACIFICMUTUAL\PLIN'
		SET @Table = (SELECT SDTable_ID_Begin from #temptable WHERE Relation_ID = @Counter)
		SET @ID = (SELECT SD_ID_Begin from #temptable WHERE Relation_ID = @Counter)
		EXEC SetLog 7, @Counter, 13, @Table,  @ID, 'PACIFICMUTUAL\PLIN'
		SET @Table = (SELECT SDTable_ID_End from #temptable WHERE Relation_ID = @Counter)
		SET @ID = (SELECT SD_ID_End from #temptable WHERE Relation_ID = @Counter)
		EXEC SetLog 7, @Counter, 13, @Table,  @ID, 'PACIFICMUTUAL\PLIN'
		SET @Value = (SELECT Relation_Desc from #temptable WHERE Relation_ID = @Counter)
		IF @Value <> ''  and @Value is not null
		BEGIN
			EXEC SetLog 7, @Counter, 15, @Value, NULL, 'PACIFICMUTUAL\PLIN'
		END

	END
	SET @Counter = @Counter + 1
END 	


drop table #temptable

*/

/*
DECLARE @dummyint INT	
DECLARE @dummyvar varchar(500)

select *, 
	@dummyvar as "ItemName", @dummyint as "ItemType", @dummyint as "ItemAbstraction" 
	into #temptable
from sdlog 
where sdtable_id = 12 
	and sd_id in (select sd_id from sdlog where sdlog_note = '361' and sdlog_value = '4' and sdtable_id = 12) 
order by sd_id, sdlog_datetime


Update #temptable set ItemName =
	CASE
--		WHEN SDLog_Value = '1' THEN CAST(SDLog_Note as int)
		WHEN SDLog_Value = '4' THEN (SELECT SDLog_Value FROM SDLog WHERE SD_ID= CAST(#temptable.SDLog_Note as int) AND SDLogFunction_ID = 9 AND SDTable_ID = 4 AND SDLog_Note IS NULL)	
--		WHEN SDLog_Value = '11' THEN CAST(#temptable.SDLog_Note as int)
	END 

update #temptable set ItemType =
	CASE
--		WHEN SDLog_Value = '1' THEN (SELECT Abstraction_Name FROM Abstraction WHERE Abstraction_ID = #temptable.TempID)
		WHEN SDLog_Value = '4' THEN (SELECT SDLog_Note FROM SDLog WHERE SD_ID= CAST(#temptable.SDLog_Note as int) AND SDLogFunction_ID = 9 AND SDTable_ID = 4 AND SDLog_Value = '3')	
--		WHEN SDLog_Value = '11' THEN (SELECT Artifact_Name FROM Artifact WHERE Artifact_ID = #temptable.TempID)
	END 

update #temptable set ItemAbstraction =
	CASE
--		WHEN SDLog_Value = '1' THEN (SELECT Abstraction_Name FROM Abstraction WHERE Abstraction_ID = #temptable.TempID)
		WHEN SDLog_Value = '4' THEN (SELECT Abstraction_ID FROM ShapeType WHERE ShapeType_ID= ItemType)	
--		WHEN SDLog_Value = '11' THEN (SELECT Artifact_Name FROM Artifact WHERE Artifact_ID = #temptable.TempID)
	END 

--IF TEMP NAME IS STILL NULL, CHECK IN LOG TO GET OLD (DELETED) NAME


select * from #temptable

drop table #temptable

*/

/*

--DELETE_CONTAINER LOG ENTRIES THAT HAD NO CORRESPONDING SET_CONTAINER ENTRIES

declare @dummyint  INT

select *, @dummyint as "SDLogID"
 	into #temptable 
	from sdlog 
	where sdtable_id = 12 and sdlogfunction_id = 12
	order by sd_id, sdlog_id

update #temptable set SDLogID =
	CASE
		WHEN sdlogfunction_id = 12 THEN (Select Sdlog_id from sdlog where sdlog.sdlogfunction_id = 11 and sdlog.sdlog_value = '1' and sdlog.sd_id = #temptable.sd_id)
	END 
	
delete from sdlog where sdlog_id in (select sdlog_id from #temptable where sdlogid is null)

drop table #temptable
*/

/*
-- SET_CONTAINER ENTRIES INTO LOG

DECLARE @Table INT
DECLARE @New INT
DECLARE @Function INT
DECLARE @AbstractionTable INT
DECLARE @Abstraction_ID INT
DECLARE @Table_Container INT
DECLARE @Table_Contained INT
DECLARE @ID_Container INT
DECLARE @ID_Contained INT
DECLARE @Contact varchar(50)
DECLARE @Counter INT

SET @Counter = 16

WHILE @Counter < 655

BEGIN

	SET @Table = 12
	SET @New = @Counter
	
	IF (SELECT COUNT(*) FROM Container WHERE Container_ID = @New) > 0 
		BEGIN
			SET @Abstraction_ID = (SELECT Abstraction_ID FROM Container WHERE Container_ID = @New)
			SET @AbstractionTable = 1
			SET @Table_Container = (SELECT SDTable_ID_Container FROM Container WHERE Container_ID = @New)
			SET @Table_Contained = (SELECT SDTable_ID_Contained FROM Container WHERE Container_ID = @New)
			SET @ID_Container = (SELECT SD_ID_Container FROM Container WHERE Container_ID = @New)
			SET @ID_Contained = (SELECT SD_ID_Contained FROM Container WHERE Container_ID = @New)
			SET @Contact = 'PACIFICMUTUAL\PLIN'
			SET @Function = 
				CASE
					WHEN @Abstraction_ID = 1 THEN 11
					WHEN @Abstraction_ID = 2 THEN 11
					WHEN @Abstraction_ID = 3 THEN 11
					WHEN @Abstraction_ID = 4 THEN 9
					WHEN @Abstraction_ID = 5 THEN 9
					WHEN @Abstraction_ID = 6 THEN 9
					WHEN @Abstraction_ID = 7 THEN 11
					WHEN @Abstraction_ID = 8 THEN 11
					WHEN @Abstraction_ID = 9 THEN 9
					WHEN @Abstraction_ID = 10 THEN 11
					WHEN @Abstraction_ID = 11 THEN 11
					WHEN @Abstraction_ID = 12 THEN 9
					WHEN @Abstraction_ID = 14 THEN 9
					WHEN @Abstraction_ID = 15 THEN 11
				END
			
			EXEC SetLog @Table, @New, @Function, @AbstractionTable, @Abstraction_ID, @Contact
			EXEC SetLog @Table, @New, @Function, @Table_Container, @ID_Container, @Contact
			EXEC SetLog @Table, @New, @Function, @Table_Contained, @ID_Contained, @Contact
		
		END

	SET @Counter = @Counter + 1
END

*/


/*
-- SET_CONTAINER ENTRIES INTO LOG
select distinct sd_id into #temptable from sdlog nolock
	left join container on sd_id = container_id
where sdtable_id = 12 and container_id is null and sdlog_value = '1'
order by sd_id 

DECLARE @Counter INT
SET @Counter = 0

WHILE @Counter < 1982
BEGIN
	IF (SELECT COUNT(*) FROM #temptable WHERE sd_id = @Counter) > 0 
	BEGIN
		EXEC SetLog 12, @Counter, 12, NULL, NULL, 'PACIFICMUTUAL\PLIN'
	END
	SET @Counter = @Counter + 1
END 	

drop table #temptable
*/

/* 

-- LOGS SHAPE NAME, SHAPETYPE, DESC, LIFECYCLE ENTRIES INTO LOG TABLE 
select * into #temptable
from shape 
where shape_id < 758

DECLARE @Counter INT
DECLARE @Value varchar(500)
DECLARE @ShapeType INT
DECLARE @Desc varchar(500)
DECLARE @Lifecycle INT
DECLARE @Contact varchar(50)

SET @Counter = 0
SET @Contact = 'PACIFICMUTUAL\PLIN'

WHILE @Counter < 758
BEGIN
	IF (SELECT COUNT(*) FROM #temptable WHERE shape_id = @Counter) > 0 
	BEGIN
		SET @Value = (SELECT Shape_Name FROM Shape WHERE Shape_ID = @Counter)
		IF (SELECT COUNT(*) from sdlog WHERE sdtable_id = 4 and sd_id = @Counter and sdlogfunction_id = 9 and sdlog_value = @Value and sdlog_note is null) = 0
		BEGIN
			EXEC SetLog 4, @Counter, 9, @Value, NULL, @Contact
		END
		SET @ShapeType = (SELECT ShapeType_ID FROM Shape WHERE Shape_ID = @Counter)
		IF (SELECT COUNT(*) from sdlog WHERE sdtable_id = 4 and sd_id = @Counter and sdlogfunction_id = 9 and sdlog_value = '3' and sdlog_note = @ShapeType ) = 0 
		BEGIN
			EXEC SetLog 4, @Counter, 9, 3, @ShapeType, @Contact
		END

		SET @Lifecycle = (SELECT LifeCycle_ID FROM Shape WHERE Shape_ID = @Counter)
		IF (SELECT COUNT(*) from sdlog WHERE sdtable_id = 4 and sd_id = @Counter and sdlogfunction_id = 18 and sdlog_value = '14' and sdlog_note = @Lifecycle ) = 0 
		BEGIN
			EXEC SetLog 4, @Counter, 18, 14, @Lifecycle, @Contact
		END

		SET @Desc = (SELECT Shape_Desc FROM Shape WHERE Shape_ID = @Counter)
		IF (@Desc IS NOT NULL) AND  ((SELECT COUNT(*) from sdlog WHERE sdtable_id = 4 and sd_id = @Counter and sdlogfunction_id = 15 and sdlog_value = @Desc and sdlog_note is null) = 0 )
		BEGIN
			EXEC SetLog 4, @Counter, 15, @Desc, NULL, @Contact
		END

	END
	SET @Counter = @Counter + 1
END

drop table #temptable

*/



/*
-- LOGS ARTIFACT ENTRIES INTO LOG TABLE 
select * into #temptable
from artifact 
where artifact_id < 256

DECLARE @Counter INT
DECLARE @Value varchar(500)
DECLARE @Contact varchar(50)

SET @Counter = 0
SET @Contact = 'PACIFICMUTUAL\PLIN'

WHILE @Counter < 256
BEGIN
	IF (SELECT COUNT(*) FROM #temptable WHERE artifact_id = @Counter) > 0 
	BEGIN
		SET @Value = (SELECT Artifact_Name FROM Artifact WHERE Artifact_ID = @Counter)
		EXEC SetLog 11, @Counter, 1, @Value, NULL, @Contact

		IF (SELECT Artifact_Desc from Artifact where Artifact_ID = @Counter) IS NOT NULL
		BEGIN
			SET @Value = (SELECT Artifact_Desc FROM Artifact WHERE Artifact_ID = @Counter)
			EXEC SetLog 11, @Counter, 15, @Value, NULL, @Contact
		END

		IF (SELECT Artifact_Loc from Artifact where Artifact_ID = @Counter) IS NOT NULL
		BEGIN
			SET @Value = (SELECT Artifact_Loc FROM Artifact WHERE Artifact_ID = @Counter)
			EXEC SetLog 11, @Counter, 19, @Value, NULL, @Contact
		END

		IF (SELECT Artifact_Contact from Artifact where Artifact_ID = @Counter) IS NOT NULL
		BEGIN
			SET @Value = (SELECT Artifact_Contact FROM Artifact WHERE Artifact_ID = @Counter)
			EXEC SetLog 11, @Counter, 20, @Value, NULL, @Contact
		END

		IF (SELECT Artifact_Note from Artifact where Artifact_ID = @Counter) IS NOT NULL
		BEGIN
			SET @Value = (SELECT Artifact_Note FROM Artifact WHERE Artifact_ID = @Counter)
			EXEC SetLog 11, @Counter, 21, @Value, NULL, @Contact
		END

	END
	SET @Counter = @Counter + 1
END

drop table #temptable
*/

/*
-- LOGS ARTIFACT ENTRIES INTO LOG TABLE FROM DELETED ARTIFACTS LOG ENTRY

DECLARE @ID INT
DECLARE @Counter INT
DECLARE @Value varchar(500)
DECLARE @Contact varchar(50)


select * 
	into #temptable
from sdlog 
where sdlog_id in (select sdlog_id from sdlog where sdtable_id = 11 and sdlogfunction_id = 2 and (sd_id = 2)) order by sd_id

select IDENTITY(INT, 1, 1) as "TempID", sdtable_id, sd_id, sdlogfunction_id, sdlog_value, sdlog_note 
	into #temptable2
from #temptable


SET @Counter = 1
SET @Contact = 'PACIFICMUTUAL\PLIN'

WHILE @Counter <= (SELECT COUNT(*) FROM #temptable2)
BEGIN
	SET @ID = (SELECT sd_id from #temptable2 WHERE TempID = @Counter)
	SET @Value = (SELECT sdlog_value from #temptable2 WHERE TempID = @Counter)
	EXEC SetLog 11, @ID, 1, @Value, NULL, @Contact
	SET @Value = (SELECT sdlog_note from #temptable2 WHERE TempID = @Counter)
	EXEC SetLog 11, @ID, 19, @Value, NULL, @Contact
	SET @Counter = @Counter + 1
END


select * from #temptable2
	
drop table #temptable2
drop table #temptable
*/
GO
/****** Object:  StoredProcedure [dbo].[SetAttribute_Name]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetAttribute_Name] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Attribute SET Attribute_Name = @Value WHERE Attribute_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetAttribute]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetAttribute] (@Table as int,@Function as int, @Value as varchar(1000), @Contact as varchar(1000) , @NewID as int 
out)
AS

	INSERT INTO Attribute VALUES(@Value)
	SET @NewID = SCOPE_IDENTITY()
	EXEC SetLog @Table, @NewID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetArtifact_Note]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetArtifact_Note] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Artifact SET Artifact_Note = @Value WHERE Artifact_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetArtifact_Name]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetArtifact_Name] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Artifact SET Artifact_Name = @Value WHERE Artifact_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetArtifact_Loc]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetArtifact_Loc] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Artifact SET Artifact_Loc = @Value WHERE Artifact_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetArtifact_Desc]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetArtifact_Desc] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Artifact SET Artifact_Desc = @Value WHERE Artifact_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetArtifact_Contact]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetArtifact_Contact] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Artifact SET Artifact_Contact = @Value WHERE Artifact_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetArtifact]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetArtifact] (@Table as int, @ID as int, @Function as int, @Name as varchar(100), @Contact as varchar(500),@NewID as 
int out) 
AS

	INSERT INTO Artifact (Artifact_Name) VALUES (@Name)
	SET @NewID = SCOPE_IDENTITY()
	EXEC SetLog @Table, @NewID, @Function, @Name, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[GetReport_LevelRelationSystem]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[GetReport_LevelRelationSystem]  AS



SELECT 
	shapecontainer_name as [System Name],
	shapecontainer_desc as [System Description],
	shapecontained_name as [Object Name],
	shapecontained_desc as [Object Description],
	shapecontained_type as [Object Type],
	relation_name as [Relation Name],
	relation_desc as [Relation Description],
	relationcontainer_begin_name as [Relation Begin System Name],
	relationshape_begin_name as [Relation Begin Object Name],
	relationshape_begin_desc as [Relation Begin Object Desc],
	relationshape_begin_type as [Relation Begin Object Type],
	relationcontainer_end_name as [Relation End System Name],
	relationshape_end_name as [Relation End Object Name],
	relationshape_end_desc as [Relation End Object Desc],
	relationshape_end_type as [Relation End Object Type]

FROM vwSystemLevel

ORDER BY [System Name], [Object Name]
GO
/****** Object:  StoredProcedure [dbo].[GetReport_LevelRelationInfrastructure]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[GetReport_LevelRelationInfrastructure]  AS



SELECT 
	shapecontained_name as [Device Name],
	shapecontained_desc as [Device Description],
	shapecontained_type as [Device Type],
	shapecontainer_name as [Container Device Name],
	shapecontainer_desc as [Container Device Description],
	relation_name as [Relation Name],
	relation_desc as [Relation Description],
	relationshape_begin_name as [Relation Begin Device Name],
	relationshape_begin_desc as [Relation Begin Device Desc],
	relationshape_begin_type as [Relation Begin Device Type],
	relationshape_end_name as [Relation End Device Name],
	relationshape_end_desc as [Relation End Device Desc],
	relationshape_end_type as [Relation End Device Type]

FROM vwInfrastructureLevel

ORDER BY [Device Name], [Container Device Name]
GO
/****** Object:  StoredProcedure [dbo].[GetReport_LevelRelationBusinessProcess]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[GetReport_LevelRelationBusinessProcess]  AS



SELECT 
	shapecontainer_name as [Business Process Name],
	shapecontainer_desc as [Business Process Description],
	shapecontained_name as [Process Step Name],
	shapecontained_desc as [Process Step Description],
	shapecontained_type as [Process Step Type],
	relation_name as [Relation Name],
	relation_desc as [Relation Description],
	relationcontainer_begin_name as [Relation Begin Business Process Name],
	relationshape_begin_name as [Relation Begin Process Step Name],
	relationshape_begin_desc as [Relation Begin Process Step Desc],
	relationshape_begin_type as [Relation Begin Process Step Type],
	relationcontainer_end_name as [Relation End Business Process Name],
	relationshape_end_name as [Relation End Process Step Name],
	relationshape_end_desc as [Relation End Process Step Desc],
	relationshape_end_type as [Relation End Process Step Type]

FROM vwBusinessProcessLevel

ORDER BY [Business Process Name]
GO
/****** Object:  StoredProcedure [dbo].[SetShapeTypeAttribute_Desc]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetShapeTypeAttribute_Desc] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE ShapeTypeAttribute SET ShapeTypeAttribute_Desc = @Value WHERE ShapeTypeAttribute_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetShapeTypeAttribute]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetShapeTypeAttribute](@Table as int, @A_ID as int, @ST_ID as int,  @Function as int, @Contact as varchar(100),@NewID as int out) AS

DECLARE @New int
DECLARE @Name varchar(200)
DECLARE @ST_Table int
DECLARE @A_Table int

BEGIN TRAN
	
IF (SELECT COUNT(*) FROM ShapeTypeAttribute WHERE ShapeType_ID = @ST_ID AND Attribute_ID = @A_ID) = 0
   BEGIN
	INSERT INTO ShapeTypeAttribute VALUES (@ST_ID, @A_ID, NULL)
	SET @New = SCOPE_IDENTITY()
	SET @Name  = (SELECT Attribute_Name FROM Attribute WHERE Attribute_ID = @A_ID) + ' - ' + (SELECT ShapeType_Name FROM ShapeType WHERE ShapeType_ID = @ST_ID)
	SET @ST_Table  = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ShapeType')
	SET @A_Table  = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name =  'Attribute')
	EXEC SetLog @Table, @New, @Function, @Name, NULL, @Contact
	EXEC SetLog @Table, @New, @Function, @ST_Table, @ST_ID, @Contact
	EXEC SetLog @Table, @New, @Function, @A_Table, @A_ID, @Contact

	SELECT @NewID = SCOPE_IDENTITY() FROM ShapeTypeAttribute

    END

COMMIT TRAN

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[SetShape]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetShape] (@Table as int, @ShapeType as int, @Lifecycle as int, @Function as int, @Value as varchar(1000), @Contact as varchar(1000), @NewID as int out) 

AS
/*
		- setlog ShapeTable, ShapeID, Function_SET_XXX, Name,
		- setlog ShapeTable, ShapeID, Function_SET_XXX, ShapeType_Table, ShapeType_ID
		- setlog ShapeTable, ShapeID, Function_SET_XXX, Lifecycle_Table, LifeCycle_ID
*/


DECLARE @Table_ShapeType int
DECLARE @Table_Lifecycle int
DECLARE @Function_Lifecycle int

INSERT INTO Shape (ShapeType_ID, Shape_Name, Lifecycle_ID) VALUES (@ShapeType,@Value,@Lifecycle)
SET @NewID = SCOPE_IDENTITY()
SET @Table_ShapeType = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ShapeType')
SET @Table_Lifecycle = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Lifecycle')
SET @Function_Lifecycle = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_LIFECYCLE')
EXEC SetLog @Table, @NewID, @Function, @Value, NULL, @Contact
EXEC SetLog @Table, @NewID, @Function, @Table_ShapeType, @ShapeType, @Contact
EXEC SetLog @Table, @NewID, @Function_Lifecycle, @Table_Lifecycle, @Lifecycle, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetRelation_Name]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetRelation_Name] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

BEGIN TRAN 

UPDATE Relation SET Relation_Name = @Value WHERE Relation_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SetRelation_Direction]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetRelation_Direction] (@Table as int, @ID as int, @Function as int, @Begin_ID as int, @Contact as varchar(500)) 
AS

DECLARE @Table_Begin int
DECLARE @Table_End int
DECLARE @ID_Begin int
DECLARE @ID_End int

SET @Table_Begin = 
	CASE 
		WHEN @Begin_ID = (SELECT SD_ID_Begin FROM Relation WHERE Relation_ID = @ID) THEN (SELECT SDTable_ID_End FROM Relation WHERE Relation_ID = @ID)
		ELSE (SELECT SDTable_ID_Begin FROM Relation WHERE Relation_ID = @ID)
	END

SET @Table_End = 
	CASE 
		WHEN @Begin_ID = (SELECT SD_ID_Begin FROM Relation WHERE Relation_ID = @ID) THEN (SELECT SDTable_ID_Begin FROM Relation WHERE Relation_ID = @ID)
		ELSE (SELECT SDTable_ID_End FROM Relation WHERE Relation_ID = @ID)
	END

SET @ID_Begin = 
	CASE 
		WHEN @Begin_ID = (SELECT SD_ID_Begin FROM Relation WHERE Relation_ID = @ID) THEN (SELECT SD_ID_End FROM Relation WHERE Relation_ID = @ID)
		ELSE (SELECT SD_ID_Begin FROM Relation WHERE Relation_ID = @ID)
	END

SET @ID_End = 
	CASE 
		WHEN  @Begin_ID = (SELECT SD_ID_Begin FROM Relation WHERE Relation_ID = @ID) THEN @Begin_ID
		ELSE (SELECT SD_ID_End FROM Relation WHERE Relation_ID = @ID)
	END

BEGIN TRAN

UPDATE Relation SET SDTable_ID_Begin = @Table_Begin, SD_ID_Begin = @ID_Begin, SDTable_ID_End = @Table_End, SD_ID_End = @ID_End WHERE Relation_ID = @ID
-- "NULL,NULL" SHOWS THAT RELATION HAS CHANGED DIRECTION
EXEC SetLog @Table, @ID, @Function, NULL, NULL, @Contact
EXEC SetLog @Table, @ID, @Function, @Table_Begin, @ID_Begin, @Contact
EXEC SetLog @Table, @ID, @Function, @Table_End, @ID_End, @Contact

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SetRelation_Desc]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetRelation_Desc] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

BEGIN TRAN

UPDATE Relation SET Relation_Desc = @Value WHERE Relation_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SetRelation]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetRelation](@ID as int, @Relation as varchar(100), @Table_Begin as int, @ID_Begin as int, @Table_End as int, @ID_End as int, @Abstraction_ID as int, @Function as int, @Contact as varchar(100)) AS

/*
 Insert into RELATION table
		- setlog Relation_Table, Relation_ID, Function_SetRelation, Relation_Name, Relation_Desc
		- setlog Relation_Table, Relation_ID, Function_SetRelation, Abstraction_Table, Abstraction_ID
		- setlog Relation_Table, Relation_ID, Function_SetRelation, Item_Table_Begin, Item_ID_Begin
		- setlog Relation_Table, Relation_ID, Function_SetRelation, Item_Table_End, Item_ID_End
*/

DECLARE @Table int
DECLARE @New int
DECLARE @Table_Abstraction int
DECLARE @Container_Abstraction int
DECLARE @TempAbstraction int
DECLARE @TempFunction int
DECLARE @TempID_Begin int
DECLARE @TempID_End int

BEGIN TRAN
	--- DONT ALLOW FOR RELATION TO SAME SHAPE
IF @Table_Begin <> @Table_End OR @ID_Begin <> @ID_End 
BEGIN
	--- INSERT NEW RELATION
	IF @ID IS NULL 
	BEGIN
		INSERT INTO RELATION VALUES (@Table_Begin, @ID_Begin, @Table_End, @ID_End, @Relation,  NULL, @Abstraction_ID)
		SET @New  = SCOPE_IDENTITY()
		SET @Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Relation')
		SET @Table_Abstraction = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Abstraction')
		EXEC SetLog @Table, @New, @Function, @Relation, NULL, @Contact
		EXEC SetLog @Table, @New, @Function, @Table_Abstraction, @Abstraction_ID, @Contact
		EXEC SetLog @Table, @New, @Function, @Table_Begin, @ID_Begin, @Contact
		EXEC SetLog @Table, @New, @Function, @Table_End, @ID_End, @Contact
	

		--- IF OBJECT RELATION, CHECK TO SEE IF SYSTEM RELATION EXISTS, IF NOT, CREATE IT
		IF @Abstraction_ID IN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT' OR Abstraction_Name ='STEP')  
			BEGIN
				SET @Container_Abstraction = 
					CASE
						WHEN @Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT')  THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT')
						WHEN @Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP')  THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP')
					END
				SET @TempID_Begin  = (SELECT SD_ID_Container FROM Container WHERE Abstraction_ID = @Container_Abstraction AND SDTable_ID_Contained = @Table_Begin AND SD_ID_Contained = @ID_Begin )
				SET @TempID_End  = (SELECT SD_ID_Container FROM Container WHERE Abstraction_ID = @Container_Abstraction AND SDTable_ID_Contained = @Table_End AND SD_ID_Contained = @ID_End )
				IF @TempID_Begin <> @TempID_End 
					--- DONT BOTHER IF FROM SAME SYSTEM
					BEGIN
						SET @TempAbstraction =
							CASE
								WHEN @Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT')  THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM')
								WHEN @Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP')  THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS')
							END
						IF ((SELECT COUNT(*) FROM Relation WHERE SDTable_ID_Begin = @Table_Begin AND SD_ID_Begin = @TempID_Begin AND SDTable_ID_End = @Table_End AND SD_ID_End = @TempID_End) = 0 )
							AND ((SELECT COUNT(*) FROM Relation WHERE SDTable_ID_Begin = @Table_End AND SD_ID_Begin = @TempID_End AND SDTable_ID_End = @Table_Begin AND SD_ID_End = @TempID_Begin) = 0 )
							--- CREATE SYSTEM RELATION
							BEGIN
								INSERT INTO RELATION VALUES (@Table_Begin, @TempID_Begin, @Table_End, @TempID_End, NULL,  NULL, @TempAbstraction)
								SET @New  = SCOPE_IDENTITY()
								EXEC SetLog @Table, @New, @Function, NULL, NULL, @Contact
								EXEC SetLog @Table, @New, @Function, @Table_Abstraction, @TempAbstraction, @Contact
								EXEC SetLog @Table, @New, @Function, @Table_Begin, @TempID_Begin, @Contact
								EXEC SetLog @Table, @New, @Function, @Table_End, @TempID_End, @Contact
							END
					END
			END
	END
END

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[DeleteContainer]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteContainer] (@Table as int, @ID as int, @Function as int,@Contact as varchar(500)) AS

-- DELETE IF Container is found
IF (SELECT COUNT(*) FROM Container WHERE Container_ID = @ID) > 0
	BEGIN
/* -- THIS IS NOT CURRENTLY USED AS AN IP SHAPE HAS NOT BEEN CREATED
		-- IF this is an ContainerIP, delete IP shape too
		DECLARE @AbstractionIP int
		SET @AbstractionIP = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'IP')
		IF  @AbstractionIP = (SELECT Abstraction_ID FROM Container WHERE Container_ID = @ID)
			BEGIN
				DECLARE @LogTable int
				DECLARE @LogID int 
				SET @LogTable = (SELECT SDTable_ID_Contained FROM Container WHERE Container_ID = @ID)
				SET @LogID = (SELECT SD_ID_Contained FROM Container WHERE Container_ID = @ID)
				-- IF IP shape exists, delete it and log deletion
				IF (SELECT COUNT(*) FROM Shape WHERE Shape_ID= @LogID) > 0 
					BEGIN
						DECLARE @LogFunction int 
						SET @LogFunction = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_SHAPE')
						EXEC SetLog @LogTable, @LogID, @LogFunction, NULL, NULL, @Contact
						DELETE FROM Shape WHERE Shape_ID = @LogID
					END
			END
*/
		-- LOG and DELETE Container
		EXEC SetLog @Table, @ID, @Function, NULL, NULL, @Contact
		DELETE FROM Container WHERE Container_ID = @ID

	END
GO
/****** Object:  StoredProcedure [dbo].[DeleteConstrainedValue]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteConstrainedValue] (@Table as int, @ID as int, @Function as int, @Contact as varchar(500)) AS


IF (SELECT COUNT(*) FROM ConstrainedValue WHERE ConstrainedValue_ID = @ID) > 0
	BEGIN
		EXEC SetLog @Table, @ID, @Function, NULL, NULL, @Contact
		DELETE FROM ConstrainedValue WHERE ConstrainedValue_ID = @ID
	END
GO
/****** Object:  StoredProcedure [dbo].[DeleteAttributeValue]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteAttributeValue] (@Table as int, @ID as int, @Function as int, @Contact as varchar(500)) AS


IF (SELECT COUNT(*) FROM AttributeValue WHERE AttributeValue_ID = @ID) > 0
	BEGIN
		EXEC SetLog @Table, @ID, @Function, NULL, NULL, @Contact
		DELETE FROM AttributeValue WHERE AttributeValue_ID = @ID
	END
GO
/****** Object:  StoredProcedure [dbo].[DeleteAttribute]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteAttribute] (@Table as int, @ID as int, @Function as int, @Name as varchar(1000), @Note as varchar(1000),@Contact as varchar(500)) AS

/* THIS ATTRIBUTE CAN ONLY BE DELETED IF THERE ARE NO DEPENDANT SHAPETYPES */

IF (SELECT COUNT(*) FROM Attribute WHERE Attribute_ID = @ID) > 0
	BEGIN
		EXEC SetLog @Table, @ID, @Function, @Name, @Note, @Contact
		DELETE FROM Attribute WHERE Attribute_ID = @ID
	END
GO
/****** Object:  StoredProcedure [dbo].[DeleteArtifact]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteArtifact](@Table as int, @ID as int, @Function as int, @Name as varchar(1000), @Note as varchar(1000), @Contact as varchar(500)) AS


IF (SELECT COUNT(*) FROM Container WHERE SDTable_ID_Contained = @Table AND SD_ID_Contained = @ID) > 0
	BEGIN
		-- DELETE ARTIFACT CONTAINER(S), NO NEED TO LOG IT
		DELETE FROM Container WHERE Container_ID IN (SELECT Container_ID FROM Container WHERE SDTable_ID_Contained = @Table AND SD_ID_Contained = @ID)
/*
		DECLARE @LogTable int
		DECLARE @LogID int
		DECLARE @LogFunction int
		SET @LogTable = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Container')
		SET @LogID = (SELECT Container_ID FROM Container WHERE SDTable_ID_Contained = @Table AND SD_ID_Contained = @ID)
		SET @LogFunction = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_CONTAINER')
		EXEC SetLog @LogTable, @LogID,  @LogFunction, NULL, NULL, @Contact
		DELETE FROM Container WHERE Container_ID = @LogID
*/
	END 

IF (SELECT COUNT(*) FROM Artifact WHERE Artifact_ID = @ID) > 0
	BEGIN
		-- LOG DELETE ARTIFACT
		EXEC SetLog @Table, @ID, @Function, @Name, @Note, @Contact
		DELETE FROM Artifact WHERE Artifact_ID = @ID
	END
GO
/****** Object:  StoredProcedure [dbo].[GetReport_EnterpriseAttributeNew]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[GetReport_EnterpriseAttributeNew] (@A1 as int, @A2 as int, @A3 as int, @A4 as int, @A5 as int, @A6 as int)  AS

DECLARE @intDummy int
DECLARE @varDummy varchar(100)
DECLARE @AttributeName varchar(100)
DECLARE @AttributeID int
DECLARE @AbsID int
DECLARE @SDColumn varchar(100)
DECLARE @AbsName varchar(100)
DECLARE @SQL varchar(1000)


IF @A1 IS NOT NULL 
	BEGIN

		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A1)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A1)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)
	END


SELECT 
	*,
	@varDummy as "Attribute1",
	@varDummy as "Attribute2", 
	@varDummy as "Attribute3", 
	@varDummy as "Attribute4", 
	@varDummy as "Attribute5", 
	@varDummy as "Attribute6"
INTO #tempReport
FROM vwEnterprise



IF @A1 IS NOT NULL 
	BEGIN

		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A1)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A1)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)

		IF @@ERROR = 0
		BEGIN
			SET @SDColumn = 
				CASE
					WHEN @AbsID = 1 THEN 'systemid'
					WHEN @AbsID = 2 THEN 'objectid'
					WHEN @AbsID = 3 THEN 'infrastructureid'
					WHEN @AbsID = 10 THEN 'businessprocessid'
					WHEN @AbsID = 11 THEN 'stepid'
				END
			
			set @SQL = 'UPDATE #tempReport SET Attribute1 = (select attributevalue_value  from attributevalue where sdtable_id = 4 and sd_id = '
				+ @SDColumn + ' and shapetypeattribute_id in 
				(select shapetypeattribute_id from shapetypeattribute where attribute_id =  ' + CAST(@AttributeID as char(5)) 
				+ ' and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ' +  CAST(@AbsID as char(5))  + ')))'

			exec (@sql)
		END

	END


--set @sql = 'SELECT *, Attribute1 AS [' + @AttributeName + '] FROM #tempreport'
--exec (@sql)

select * from #tempReport

DROP TABLE #tempReport
GO
/****** Object:  StoredProcedure [dbo].[GetReport_EnterpriseAttribute]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[GetReport_EnterpriseAttribute] (@A1 as int, @A2 as int, @A3 as int, @A4 as int, @A5 as int, @A6 as int)  AS

DECLARE @intDummy int
DECLARE @varDummy varchar(100)

SELECT 
	*,
	@varDummy as "Attribute1", 
	@varDummy as "Attribute2", 
	@varDummy as "Attribute3", 
	@varDummy as "Attribute4", 
	@varDummy as "Attribute5", 
	@varDummy as "Attribute6"
INTO tempReport
FROM vwEnterprise

DECLARE @AttributeName varchar(100)
DECLARE @AttributeID int
DECLARE @AbsID int
DECLARE @SDColumn varchar(100)
DECLARE @AbsName varchar(100)
DECLARE @SQL varchar(1000)

IF @A1 IS NOT NULL 
	BEGIN

		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A1)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A1)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)

		EXEC sp_rename 'tempReport.Attribute1',   @AttributeName ,  'Column'

		IF @@ERROR = 0
		BEGIN
			SET @SDColumn = 
				CASE
					WHEN @AbsID = 1 THEN 'systemid'
					WHEN @AbsID = 2 THEN 'objectid'
					WHEN @AbsID = 3 THEN 'infrastructureid'
					WHEN @AbsID = 10 THEN 'businessprocessid'
					WHEN @AbsID = 11 THEN 'stepid'
				END
			
			set @SQL = 'UPDATE tempReport SET [' + @AttributeName + '] = (select attributevalue_value  from attributevalue where sdtable_id = 4 and sd_id = '
				+ @SDColumn + ' and shapetypeattribute_id in 
				(select shapetypeattribute_id from shapetypeattribute where attribute_id =  ' + CAST(@AttributeID as char(5)) 
				+ ' and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ' +  CAST(@AbsID as char(5))  + ')))'

			exec (@sql)
		END

	END

IF @A2 IS NOT NULL 
	BEGIN

		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A2)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A2)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)

		EXEC sp_rename 'tempReport.Attribute2',   @AttributeName ,  'Column'

		IF @@ERROR = 0
		BEGIN
			SET @SDColumn = 
				CASE
					WHEN @AbsID = 1 THEN 'systemid'
					WHEN @AbsID = 2 THEN 'objectid'
					WHEN @AbsID = 3 THEN 'infrastructureid'
					WHEN @AbsID = 10 THEN 'businessprocessid'  
					WHEN @AbsID = 11 THEN 'stepid'
				END
			
			set @SQL = 'UPDATE tempReport SET [' + @AttributeName + '] = (select attributevalue_value  from attributevalue where sdtable_id = 4 and sd_id = '
				+ @SDColumn + ' and shapetypeattribute_id in 
				(select shapetypeattribute_id from shapetypeattribute where attribute_id =  ' + CAST(@AttributeID as char(5)) 
				+ ' and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ' +  CAST(@AbsID as char(5))  + ')))'

			exec (@sql)
		END

	END

IF @A3 IS NOT NULL 
	BEGIN

		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A3)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A3)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)

		EXEC sp_rename 'tempReport.Attribute3',   @AttributeName ,  'Column'

		IF @@ERROR = 0
		BEGIN
			SET @SDColumn = 
				CASE
					WHEN @AbsID = 1 THEN 'systemid'
					WHEN @AbsID = 2 THEN 'objectid'
					WHEN @AbsID = 3 THEN 'infrastructureid'
					WHEN @AbsID = 10 THEN 'businessprocessid'  
					WHEN @AbsID = 11 THEN 'stepid'
				END
			
			set @SQL = 'UPDATE tempReport SET [' + @AttributeName + '] = (select attributevalue_value  from attributevalue where sdtable_id = 4 and sd_id = '
				+ @SDColumn + ' and shapetypeattribute_id in 
				(select shapetypeattribute_id from shapetypeattribute where attribute_id =  ' + CAST(@AttributeID as char(5)) 
				+ ' and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ' +  CAST(@AbsID as char(5))  + ')))'

			exec (@sql)
		END


	END

IF @A4 IS NOT NULL 
	BEGIN
		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A4)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A4)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)

		EXEC sp_rename 'tempReport.Attribute4',   @AttributeName ,  'Column'

		IF @@ERROR = 0
		BEGIN
			SET @SDColumn = 
				CASE
					WHEN @AbsID = 1 THEN 'systemid'
					WHEN @AbsID = 2 THEN 'objectid'
					WHEN @AbsID = 3 THEN 'infrastructureid'
					WHEN @AbsID = 10 THEN 'businessprocessid'  
					WHEN @AbsID = 11 THEN 'stepid'
				END
			
			set @SQL = 'UPDATE tempReport SET [' + @AttributeName + '] = (select attributevalue_value  from attributevalue where sdtable_id = 4 and sd_id = '
				+ @SDColumn + ' and shapetypeattribute_id in 
				(select shapetypeattribute_id from shapetypeattribute where attribute_id =  ' + CAST(@AttributeID as char(5)) 
				+ ' and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ' +  CAST(@AbsID as char(5))  + ')))'

			exec (@sql)
		END
	END

IF @A5 IS NOT NULL 
	BEGIN
		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A5)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A5)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)

		EXEC sp_rename 'tempReport.Attribute5',   @AttributeName ,  'Column'

		IF @@ERROR = 0
		BEGIN
			SET @SDColumn = 
				CASE
					WHEN @AbsID = 1 THEN 'systemid'
					WHEN @AbsID = 2 THEN 'objectid'
					WHEN @AbsID = 3 THEN 'infrastructureid'
					WHEN @AbsID = 10 THEN 'businessprocessid'  
					WHEN @AbsID = 11 THEN 'stepid'
				END
			
			set @SQL = 'UPDATE tempReport SET [' + @AttributeName + '] = (select attributevalue_value  from attributevalue where sdtable_id = 4 and sd_id = '
				+ @SDColumn + ' and shapetypeattribute_id in 
				(select shapetypeattribute_id from shapetypeattribute where attribute_id =  ' + CAST(@AttributeID as char(5)) 
				+ ' and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ' +  CAST(@AbsID as char(5))  + ')))'

			exec (@sql)
		END
	END

IF @A6 IS NOT NULL 
	BEGIN
		SET @AbsID = (select abstraction_id from abstraction where abstraction_id = (select abstraction_id from shapetype where shapetype_id = (select shapetype_id from shapetypeattribute where shapetypeattribute_id = @A6)))
		SET @AbsName = (select abstraction_name from abstraction where abstraction_id = @AbsID)
		SET @AttributeID =  (select shapetypeattribute.attribute_id from shapetypeattribute left join attribute on shapetypeattribute.attribute_id = attribute.attribute_id where shapetypeattribute_id = @A6)
		SET @AttributeName = @AbsName + ' ' + (select attribute_name from attribute where attribute_id = @AttributeID)

		EXEC sp_rename 'tempReport.Attribute6',   @AttributeName ,  'Column'

		IF @@ERROR = 0
		BEGIN
			SET @SDColumn = 
				CASE
					WHEN @AbsID = 1 THEN 'systemid'
					WHEN @AbsID = 2 THEN 'objectid'
					WHEN @AbsID = 3 THEN 'infrastructureid'
					WHEN @AbsID = 10 THEN 'businessprocessid'  
					WHEN @AbsID = 11 THEN 'stepid'
				END
			
			set @SQL = 'UPDATE tempReport SET [' + @AttributeName + '] = (select attributevalue_value  from attributevalue where sdtable_id = 4 and sd_id = '
				+ @SDColumn + ' and shapetypeattribute_id in 
				(select shapetypeattribute_id from shapetypeattribute where attribute_id =  ' + CAST(@AttributeID as char(5)) 
				+ ' and shapetype_id in (select shapetype_id from shapetype where abstraction_id = ' +  CAST(@AbsID as char(5))  + ')))'

			exec (@sql)
		END
	END

SELECT * from tempReport

DROP TABLE tempReport
GO
/****** Object:  StoredProcedure [dbo].[DeleteRelation]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteRelation] (@Table as int, @ID as int, @Abstraction as int, @Function as int, @Contact as varchar(500)) AS


IF (SELECT COUNT(*) FROM Relation WHERE Relation_ID = @ID) > 0
	BEGIN
		DECLARE @ItemAbstractionID int 			
		DECLARE @ItemTable int
		DECLARE @ItemIDBegin int 
		DECLARE @ItemIDEnd int 
		DECLARE @ContainerAbstractionID int 			
		DECLARE @ContainerRelationID int 			
		DECLARE @ContainerTable int
		DECLARE @ContainerIDBegin int
		DECLARE @ContainerIDEnd int 			
	
		SET @ItemAbstractionID =
		CASE 
			WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP')
			WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT')
		END
		SET @ContainerAbstractionID =
		CASE 
			WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'STEP') THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESS')
			WHEN @Abstraction = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'OBJECT') THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEM')
		END
		SET @ItemIDBegin = (SELECT SD_ID_Begin FROM Relation WHERE Relation_ID = @ID)
		SET @ItemIDEnd = (SELECT SD_ID_End FROM Relation WHERE Relation_ID = @ID)
		SET @ItemTable = (SELECT SDTable_ID_Begin FROM Relation WHERE Relation_ID = @ID)
		SET @ContainerIDBegin= (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained = @ItemIDBegin AND SDTable_ID_Contained = @ItemTable AND Abstraction_ID = @ItemAbstractionID) 
		SET @ContainerIDEnd = (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained = @ItemIDEnd AND SDTable_ID_Contained = @ItemTable AND Abstraction_ID = @ItemAbstractionID) 
		SET @ContainerTable = (SELECT SDTable_ID_Container FROM Container WHERE SD_ID_Contained = @ItemIDBegin AND SDTable_ID_Contained = @ItemTable AND Abstraction_ID = @ItemAbstractionID) 
		EXEC SetLog @Table, @ID, @Function, NULL, NULL, @Contact
		DELETE FROM Relation WHERE Relation_ID = @ID
	
		--- IF THIS WAS THE ONLY RELATION LINKING THE CONTAINER RELATION, DELETE CONTAINER RELATION
		--- ONLY KEEP TRACK OF SYSTEM AND BUSINESS PROCESS CONTAINER RELATIONS
		IF @Abstraction <> (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'DEVICE') AND (@ContainerIDBegin <> @ContainerIDEnd)
			BEGIN

				DECLARE @Column_int int
					SELECT DISTINCT
					SD_ID_Begin, @Column_int as "Container_Begin",
					SD_ID_End, @Column_int as "Container_End"
				INTO #Temp2
				FROM Relation 
					WHERE (SD_ID_Begin IN (SELECT SD_ID_Contained FROM Container WHERE SD_ID_Container = @ContainerIDBegin AND Abstraction_ID = @ItemAbstractionID)) OR
						(SD_ID_End IN (SELECT SD_ID_Contained FROM Container WHERE SD_ID_Container = @ContainerIDBegin AND Abstraction_ID = @ItemAbstractionID)) 
	
				UPDATE #Temp2 SET Container_Begin = (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained=SD_ID_Begin AND Abstraction_ID = @ItemAbstractionID)
				UPDATE #Temp2 SET Container_End = (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained=SD_ID_End AND Abstraction_ID = @ItemAbstractionID)
	
				IF (SELECT COUNT(*) FROM #Temp2 WHERE (Container_Begin = @ContainerIDBegin AND Container_End = @ContainerIDEnd) OR (Container_Begin = @ContainerIDEnd AND Container_End = @ContainerIDBegin)) = 0
				BEGIN
					--- IS THERE A CONTAINER RELATION ?
					IF (SELECT COUNT(*) FROM Relation WHERE SD_ID_Begin = @ContainerIDBegin AND SD_ID_End = @ContainerIDEnd AND Abstraction_ID = @ContainerAbstractionID) > 0
						BEGIN
							SET @ContainerRelationID = (SELECT Relation_ID FROM Relation WHERE (SDTable_ID_End = @ContainerTable AND SD_ID_End = @ContainerIDEnd AND SDTable_ID_Begin = @ContainerTable AND SD_ID_Begin = @ContainerIDBegin AND Abstraction_ID = @ContainerAbstractionID)  )
							EXEC SetLog @Table, @ContainerRelationID, @Function, NULL, NULL, @Contact
							DELETE FROM Relation WHERE Relation_ID = @ContainerRelationID
						END
					ELSE IF (SELECT COUNT(*) FROM Relation WHERE SD_ID_Begin = @ContainerIDEnd AND SD_ID_End = @ContainerIDBegin AND Abstraction_ID = @ContainerAbstractionID) > 0
					--- TRY LOOKING IN REVERSE DIRECTION
						BEGIN
							SET @ContainerRelationID = (SELECT Relation_ID FROM Relation WHERE (SDTable_ID_End = @ContainerTable AND SD_ID_End = @ContainerIDBegin AND SDTable_ID_Begin = @ContainerTable AND SD_ID_Begin = @ContainerIDEnd AND Abstraction_ID = @ContainerAbstractionID) )
							EXEC SetLog @Table, @ContainerRelationID, @Function, NULL, NULL, @Contact
							DELETE FROM Relation WHERE Relation_ID = @ContainerRelationID
						END
				END

				DROP TABLE #Temp2
			END
		END
/*
			DECLARE @Column_int int
				SELECT DISTINCT
				SD_ID_Begin, @Column_int as "Container_Begin",
				SD_ID_End, @Column_int as "Container_End"
			INTO #Temp2
			FROM Relation 
				WHERE (SD_ID_Begin IN (SELECT SD_ID_Contained FROM Container WHERE SD_ID_Container = @ContainerIDBegin AND Abstraction_ID = @ItemAbstractionID)) OR
					(SD_ID_End IN (SELECT SD_ID_Contained FROM Container WHERE SD_ID_Container = @ContainerIDBegin AND Abstraction_ID = @ItemAbstractionID)) 

			UPDATE #Temp2 SET Container_Begin = (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained=SD_ID_Begin AND Abstraction_ID = @ItemAbstractionID)
			UPDATE #Temp2 SET Container_End = (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained=SD_ID_End AND Abstraction_ID = @ItemAbstractionID)
		
			IF (SELECT COUNT(*) FROM #Temp2 WHERE (Container_Begin = @ContainerIDBegin AND Container_End = @ContainerIDEnd) OR (Container_Begin = @ContainerIDEnd AND Container_End = @ContainerIDBegin)) = 0
				BEGIN
					SET @ContainerRelationID = (SELECT Relation_ID FROM Relation WHERE (SDTable_ID_End = @ContainerTable AND SD_ID_End = @ContainerIDEnd AND SDTable_ID_Begin = @ContainerTable AND SD_ID_Begin = @ContainerIDBegin AND Abstraction_ID = @ContainerAbstractionID) OR (SDTable_ID_End = @ContainerTable AND SD_ID_End = @ContainerIDEnd AND SDTable_ID_Begin = @ContainerTable AND SD_ID_Begin = @ContainerIDBegin AND Abstraction_ID = @ContainerAbstractionID) )
					IF @ContainerRelationID IS NOT NULL
					BEGIN
						select * from #temp2
						EXEC SetLog @Table, @ContainerRelationID, @Function, NULL, NULL, @Contact
						DELETE FROM Relation WHERE Relation_ID = @ContainerRelationID 
					END
				END
*/
/*
			
			IF (SELECT COUNT(*) FROM #Temp2 WHERE Container_Begin = @ContainerIDBegin AND Container_End = @ContainerIDEnd) = 0
				BEGIN
					-- SINCE SYSTEM/BUSINESS RELATIONS ARE NOT DIRECTION-SENSITIVE, CHECK FOR REVERSE ORDER
					DECLARE @Column_int2 int
						SELECT DISTINCT
						SD_ID_Begin, @Column_int2 as "Container_Begin",
						SD_ID_End, @Column_int2 as "Container_End"
					INTO #Temp3
					FROM Relation 
						WHERE (SD_ID_Begin IN (SELECT SD_ID_Contained FROM Container WHERE SD_ID_Container = @ContainerIDBegin AND Abstraction_ID = @ItemAbstractionID)) OR
							(SD_ID_End IN (SELECT SD_ID_Contained FROM Container WHERE SD_ID_Container = @ContainerIDBegin AND Abstraction_ID = @ItemAbstractionID)) 

					UPDATE #Temp3 SET Container_Begin = (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained=SD_ID_Begin AND Abstraction_ID = @ItemAbstractionID)
					UPDATE #Temp3 SET Container_End = (SELECT SD_ID_Container FROM Container WHERE SD_ID_Contained=SD_ID_End AND Abstraction_ID = @ItemAbstractionID)

					IF (SELECT COUNT(*) FROM #Temp3 WHERE Container_Begin = @ContainerIDBegin AND Container_End = @ContainerIDEnd) = 0
						-- ITEM RELATION WAS THE ONLY RELATION SYSTEM-WISE , DELETE CONTAINER RELATION	
						BEGIN
							IF @ContainerRelationID IS NOT NULL
							BEGIN
								EXEC SetLog @Table, @ContainerRelationID, @Function, NULL, NULL, @Contact
								DELETE FROM Relation WHERE Relation_ID = @ContainerRelationID
							END
						END
				END
*/
GO
/****** Object:  StoredProcedure [dbo].[DeleteItem_Artifact]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteItem_Artifact] (@ArtifactID as int, @Table as int, @ItemID as int, @Function as int,@Contact as varchar(500)) AS
-- DELETES THE ARTIFACT RELATED TO THIS ITEM

--IF (SELECT COUNT(*) FROM Container WHERE SDTable_ID_Container = @Table AND SD_ID_Container = @ItemID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT') ) > 0

BEGIN TRAN

DECLARE @ContainerID int
DECLARE @ContainerTable int

SET @ContainerID = (SELECT Container_ID FROM Container WHERE SDTable_ID_Contained=(SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Artifact') AND SD_ID_Contained=@ArtifactID AND SDTable_ID_Container = @Table AND SD_ID_Container = @ItemID AND Abstraction_ID = (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'ARTIFACT'))
SET @ContainerTable = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Container')
-- DELETE IF Container is found
IF @ContainerID IS NOT NULL
	BEGIN
		-- LOG and DELETE Container
		EXEC SetLog @ContainerTable, @ContainerID, @Function, NULL, NULL, @Contact
		DELETE FROM Container WHERE Container_ID = @ContainerID

	END

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SetItem_Name]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetItem_Name] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Shape SET Shape_Name = @Value WHERE Shape_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetItem_Lifecycle]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetItem_Lifecycle] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

DECLARE @TableLifecycle int

SET @TableLifecycle = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Lifecycle')
UPDATE Shape SET Lifecycle_ID = @Value WHERE Shape_ID = @ID
EXEC SetLog @Table, @ID, @Function, @TableLifecycle, @Value, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetItem_Desc]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetItem_Desc] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

UPDATE Shape SET Shape_Desc = @Value WHERE Shape_ID = @ID
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetItem]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetItem] (@Table as int, @ID as int, @Function as int, @Value as varchar(1000), @Contact as varchar(500)) 
AS

DECLARE @T	 varchar(100)
DECLARE @T_ID varchar(102)
DECLARE @T_Field varchar(1000)
DECLARE @ProcUpdate varchar(2000)

SET @T = (SELECT SDTable_Name FROM SDTable WHERE SDTable_ID = @Table)
SET @T_ID = @T + '_ID '
SET @T_Field = 
	CASE
		WHEN @Function = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_NAME') THEN @T + '_Name'
		WHEN @Function = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_DESCRIPTION') THEN @T + '_Desc'
		WHEN @Function = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_LOCATION') THEN @T + '_Loc'
		WHEN @Function = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_CONTACT') THEN @T + '_Contact'
		WHEN @Function = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_NOTE') THEN @T + '_Note'
		WHEN @Function = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_SET_LIFECYCLE') THEN 'Lifecycle_ID'
	END

SET @ProcUpdate = "UPDATE " + @T + " SET " + @T_Field+ " = '" + CAST(@Value as varchar(1000)) + "' WHERE " + @T_ID + " = " + CAST(@ID as varchar(1000))

EXEC (@ProcUpdate)
EXEC SetLog @Table, @ID, @Function, @Value, NULL, @Contact
GO
/****** Object:  StoredProcedure [dbo].[SetContainer]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetContainer](@Table_Container as int, @ID_Container as int, @Table_Contained as int, @ID_Contained as int, @Abstraction_ID as int, @Function as int, @Contact as varchar(100)) AS

/*
 Insert only if the container does not exist
	insert into Container table	
		- setlog Container_Table, Container_ID, Function_SetContainer, Abstraction_Table, Abstraction_ID
		- setlog Container_Table, Container_ID, Function_SetContainer, Item_Table_Container, Item_ID_Container
		- setlog Container_Table, Container_ID, Function_SetContainer, Item_Table_Contained, Item_ID_Contained
*/

IF (SELECT COUNT(*) FROM Container WHERE SDTable_ID_Container = @Table_Container AND SD_ID_Container = @ID_Container AND SDTable_ID_Contained = @Table_Contained AND SD_ID_Contained = @ID_Contained AND Abstraction_ID= @Abstraction_ID) = 0
	BEGIN
		DECLARE @Table int
		DECLARE @New int
		DECLARE @AbstractionTable int

				
		INSERT INTO Container VALUES (@Table_Container, @ID_Container, @Table_Contained, @ID_Contained, @Abstraction_ID)
		SET @Table = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Container')
		SET @New  = SCOPE_IDENTITY()
		SET @AbstractionTable = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'Abstraction')
		EXEC SetLog @Table, @New, @Function, @AbstractionTable, @Abstraction_ID, @Contact
		EXEC SetLog @Table, @New, @Function, @Table_Container, @ID_Container, @Contact
		EXEC SetLog @Table, @New, @Function, @Table_Contained, @ID_Contained, @Contact

		-- IF THIS IS A SYSTEM OR BUSINESS PROCESS SHAPE, AND AN ARTIFACT CONTAINED : PROPAGATE CONTAINER TO ITS OBJECTS AND STEPS
		IF @Table_Contained = (SELECT SDTable_ID FROM SDTABLE WHERE SDTable_Name = 'Artifact') AND @Table_Container = (SELECT SDTable_ID FROM SDTABLE WHERE SDTable_Name = 'Shape')
			BEGIN
				DECLARE @ContainedShapeType int
				SET @ContainedShapeType = (SELECT ShapeType_ID FROM Shape WHERE Shape_ID = @ID_Container)
				IF  @ContainedShapeType IN (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name IN ('SYSTEM','BUSINESSPROCESS'))
					BEGIN
						-- GET ALL CONTAINED SHAPES INTO A TEMPTABLE FIRST
						DECLARE @ContainedAbstraction int
						SET @ContainedAbstraction =
							CASE
								WHEN @ContainedShapeType = (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'SYSTEM') THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'SYSTEMOBJECT')
								WHEN @ContainedShapeType = (SELECT ShapeType_ID FROM ShapeType WHERE ShapeType_Name = 'BUSINESSPROCESS') THEN (SELECT Abstraction_ID FROM Abstraction WHERE Abstraction_Name = 'BUSINESSSTEP')
							END
						SELECT 
							SDTable_ID_Contained as "SDTable_ID_Container",
							SD_ID_Contained as "SD_ID_Container",
							@Table_Contained as "SDTable_ID_Contained",
							@ID_Contained as "SD_ID_Contained",	
							@Abstraction_ID as "Abstraction_ID"
						INTO #TempTable
						FROM Container WHERE SDTable_ID_Container = @Table_Container AND SD_ID_Container = @ID_Container AND Abstraction_ID = @ContainedAbstraction											
						-- INSERT INTO CONTAINER TABLE

						INSERT INTO Container(SDTable_ID_Container, SD_ID_Container, SDTable_ID_Contained, SD_ID_Contained, Abstraction_ID)
							SELECT  SDTable_ID_Container, SD_ID_Container, SDTable_ID_Contained, SD_ID_Contained, Abstraction_ID FROM #TempTable

						-- CANT FIND A CLEAN WAY TO INSERT THIS INTO THE LOG TABLE SO DONE TRYING FOR NOW


					END

			END 
	END
GO
/****** Object:  StoredProcedure [dbo].[SetConstrainedValue]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetConstrainedValue] (@SDTable_ID as int, @SD_ID as int, @Function as int, @Values as varchar(2000), @Contact as varchar(1000))

AS

DECLARE @CVTable_ID int
DECLARE @CV_ID int
DECLARE @CVFunction int

--IF CONSTRAINED VALUES ALREADY EXIST FOR THIS ENTRY
IF (SELECT COUNT(*) FROM ConstrainedValue WHERE SDTable_ID = @SDTable_ID AND SD_ID = @SD_ID) > 0
	BEGIN
		/*
			 if no longer has values, delete from ConstrainedValue table
		*/
		SET @CVTable_ID = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ConstrainedValue')
		SET @CV_ID = (SELECT ConstrainedValue_ID FROM ConstrainedValue WHERE SDTable_ID = @SDTable_ID AND SD_ID = @SD_ID)
		IF @Values = ''
			BEGIN 
				SET @CVFunction = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_CONSTRAINEDVALUE')
				EXEC DeleteConstrainedValue @CVTable_ID, @CV_ID, @CVFunction, @Contact
			END
		ELSE
		/*
			 if updating values, update ConstrainedValue table
			- setlog CV_Table, CV_ID, Function_SetConstrainedValue, CV_Value		
		*/
			BEGIN
				UPDATE ConstrainedValue SET ConstrainedValue_Values = @Values WHERE SDTable_ID = @SDTable_ID AND SD_ID = @SD_ID
				EXEC SetLog @CVTable_ID, @CV_ID, @Function, @Values, NULL, @Contact
			END
	END
ELSE
	BEGIN
		IF @Values <> ''
		/*
			 if has values for the first time, insert in ConstrainedValue table
			- setlog CV_Table, CV_ID, Function_SetConstrainedValue, CV_Value
			- setlog CV_Table, CV_ID, Function_SetConstrainedValue, Item_Table, Item_ID
		*/
			BEGIN
				INSERT INTO ConstrainedValue (SDTable_ID, SD_ID, ConstrainedValue_Values) VALUES (@SDTable_ID, @SD_ID, @Values)
				SET @CVTable_ID = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ConstrainedValue')
				SET @CV_ID = (SELECT ConstrainedValue_ID FROM ConstrainedValue WHERE SDTable_ID = @SDTable_ID AND SD_ID = @SD_ID)
				EXEC SetLog @CVTable_ID, @CV_ID, @Function, @Values, NULL, @Contact
				EXEC SetLog @CVTable_ID, @CV_ID, @Function, @SDTable_ID, @SD_ID, @Contact
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[SetAttributeValue]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SetAttributeValue](@Table as int, @ID as int, @STA_ID as int, @Value as varchar(1000),  @Function as int, @Contact as 
varchar(100)) AS

-- IF currently not in the ATTRIBUTEVALUE table
	-- IF value is not empty string, insert into table, log into SDLog  
	-- ELSE do nothing
-- IF currently in ATTRIBUTEVALUE table
	-- IF value is empty string, call DeleteAttributeValue
	-- ELSE update into table, log into SDLog

DECLARE @ProcTable int
DECLARE @ProcID int
DECLARE @ProcFunction int

SET @ProcTable  = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'AttributeValue')

IF (SELECT COUNT(*) FROM AttributeValue WHERE SDTable_ID = @Table AND SD_ID = @ID AND ShapeTypeAttribute_ID = @STA_ID ) = 0 
	BEGIN
		IF @Value <> ''
			BEGIN
				DECLARE @STA_TABLE int
				SET @STA_TABLE  = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ShapeTypeAttribute')
				INSERT INTO AttributeValue VALUES (@Table, @ID, @STA_ID, @Value)
				SET @ProcID  = SCOPE_IDENTITY()			
				-- LOG  VALUE
				EXEC SetLog @ProcTable, @ProcID, @Function, @Value, NULL, @Contact
				-- LOG ITEM THAT HAS THIS VALUE
				EXEC SetLog @ProcTable, @ProcID, @Function, @Table, @ID, @Contact
				-- LOG SHAPETYPEATTRIBUTE OF THIS VALUE
				EXEC SetLog @ProcTable, @ProcID, @Function, @STA_Table, @STA_ID, @Contact
			END
	END
ELSE
	BEGIN
		SET @ProcID = (SELECT AttributeValue_ID FROM AttributeValue WHERE SDTable_ID = @Table AND SD_ID = @ID AND ShapeTypeAttribute_ID = @STA_ID)
		IF @Value = ''
			BEGIN
				SET @ProcFunction  = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_ATTRIBUTEVALUE')
				EXEC DeleteAttributeValue @ProcTable, @ProcID, @ProcFunction, @Contact
			END
		ELSE
			BEGIN
				UPDATE AttributeValue SET AttributeValue_Value = @Value WHERE AttributeValue_ID = @ProcID
				EXEC SetLog @ProcTable, @ProcID, @Function, @Value, NULL, @Contact
			END
	END



SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[DeleteShapeTypeAttribute]    Script Date: 08/28/2011 11:59:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteShapeTypeAttribute] (@Table as int, @ID as int, @Function as int, @Name as varchar(1000), @Note as varchar(1000),  @Contact as varchar(500)) AS


IF (SELECT COUNT(*) FROM ShapeTypeAttribute WHERE ShapeTypeAttribute_ID = @ID) > 0
	BEGIN
		-- DELETE ConstrainedValue of ShapeTypeAttribute
		DECLARE @CVTable int
		DECLARE @CVID  int
		DECLARE @CVFunction int
		SET @CVTable = (SELECT SDTable_ID FROM SDTable WHERE SDTable_Name = 'ConstrainedValue')
		SET @CVID = (SELECT ConstrainedValue_ID FROM ConstrainedValue WHERE SDTable_ID = @Table AND SD_ID = @ID )
		SET @CVFunction = (SELECT SDLogFunction_ID FROM SDLogFunction WHERE SDLogFunction_Name = 'LOGFUNCTION_DELETE_CONSTRAINEDVALUE')
		EXEC DeleteConstrainedValue @CVTable, @CVID, @CVFunction, @Contact

		-- DELETE ShapeTypeAttribute
		EXEC SetLog @Table, @ID, @Function, NULL, @Note, @Contact
		DELETE FROM ShapeTypeAttribute WHERE ShapeTypeAttribute_ID = @ID
		
	END
GO
