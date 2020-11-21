/********************************************************************************

   Create ODB Stored Procedures

	For Database Schema: v1.0
   
 ********************************************************************************/

USE [ODB]
GO

/********************************************************************************

   A c t i v i t y L o g
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[ActivityLog_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ActivityLog_Select]
AS
    SET NOCOUNT ON;

    SELECT 
        [activitylog_id],
        [table_id],
        [item_id],
        [logfunction_id],
        [value],
        [who],
        [when],
        [notes]
    FROM 
		[ActivityLog]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
    @table_id int, 
    @item_id uniqueidentifier,
    @log_function_id int,
    @value varchar(2048),
    @who varchar(50),
    @notes varchar(1024)
AS
    -- SET NOCOUNT ON added to prevent extra result sets FROM
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO 
		[ActivityLog]
	VALUES 
    (
		newid(), 
		@table_id, 
		@item_id, 
		@log_function_id, 
		@value, 
		@who, 
		getDate(), 
		@notes
	)
' 
END
GO

/* TODO 
Decide if want Update and Delete SPs for Activity Log
*/
/****** Object:  StoredProcedure [dbo].[ActivityLog_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Update]
GO

/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Delete]
GO


/********************************************************************************

   A s s o c i a t i o n R u l e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[AssociationRules_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationRules_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[associationrule_id],
		[table_id_begin],
		[table_id_end],
		[itemtype_id_begin],
		[itemtype_id_end],
		[associationtype_id]
   FROM 
		AssociationRules
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AssociationRules_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationRules_Insert]
(
    @associationrule_id uniqueidentifier,
    @table_id_begin int,
    @itemtype_id_begin uniqueidentifier,
    @table_id_end int,
    @itemtype_id_end uniqueidentifier,
    @associationtype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AssociationRules] 
	(
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id]
	) 
	VALUES 
	(
		@associationrule_id, 
		@table_id_begin, 
		@itemtype_id_begin,
 		@table_id_end, 
		@itemtype_id_end, 
		@associationtype_id
	);

    EXEC ActivityLog_Insert 3, @associationrule_id, 1, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id] 
	FROM 
		AssociationRules 
	WHERE
	(
		associationrule_id = @associationrule_id
	)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AssociationRules_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationRules_Update]
(
    @associationrule_id uniqueidentifier,
    @table_id_begin int,
    @itemtype_id_begin uniqueidentifier,
    @table_id_end int,
    @itemtype_id_end uniqueidentifier,
    @associationtype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[AssociationRules] 
	SET 
		[associationrule_id] = @associationrule_id, 
		[table_id_begin] = @table_id_begin, 
		[itemtype_id_begin] = @itemtype_id_begin, 
		[table_id_end] = @table_id_end, 
		[itemtype_id_end] = @itemtype_id_end, 
		[associationtype_id] = @associationtype_id 
	WHERE 
	(
		([associationrule_id] = @associationrule_id)
		AND (1 = 1 /* TODO: Redo this with TimeStamps */)
	);

	EXEC ActivityLog_Insert 3, @associationrule_id, 2, "more stuff", @who, @note /* ToDo: Update constants for each table */  

    SELECT 
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id] 
	FROM 
		AssociationRules 
	WHERE 
		(associationrule_id = @associationrule_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AssociationRules_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationRules_Delete]
(
    @associationrule_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[AssociationRules] 
	WHERE 
	(
		([associationrule_id] = @associationrule_id)
		AND (1 = 1 /* TODO: Redo this with TimeStamps */)
	)

   EXEC ActivityLog_Insert 3, @associationrule_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
'
END
GO

/********************************************************************************

   A s s o c i a t i o n s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[Associations_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Associations_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Associations_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Associations_Select]
AS
    SET NOCOUNT ON;

    SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin],
		[table_id_end],
		[item_id_end],
		[associationrule_id],
		[itemtypegroup_id]	
	FROM
		Associations
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Associations_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Associations_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Associations_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Associations_Insert]
(
	@association_id uniqueidentifier,
	@table_id_begin int,
	@item_id_begin uniqueidentifier,
	@table_id_end int,
	@item_id_end uniqueidentifier,
	@associationrule_id uniqueidentifier,
	@itemtypegroup_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Associations] 
	(
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	)
	VALUES
	(
		@association_id,
		@table_id_begin, 
		@item_id_begin,
		@table_id_end, 
		@item_id_end,
		@associationrule_id, 
		@itemtypegroup_id
	);

	EXEC ActivityLog_Insert 4, @association_id, 1, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
    
	SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	FROM 
		Associations 
	WHERE 
		(association_id = @association_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Associations_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Associations_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Associations_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Associations_Update]
(
	@association_id uniqueidentifier,
    @table_id_begin int,
	@item_id_begin uniqueidentifier,
	@table_id_end int,
	@item_id_end uniqueidentifier,
	@associationrule_id uniqueidentifier,
	@itemtypegroup_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[Associations] 
	SET 
		[table_id_begin]     = @table_id_begin,
		[item_id_begin]      = @item_id_begin, 
		[table_id_end]       = @table_id_end, 
		[item_id_end]        = @item_id_end, 
		[associationrule_id] = @associationrule_id, 
		[itemtypegroup_id]   = @itemtypegroup_id
	WHERE 
	(
		([association_id] = @association_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

    EXEC ActivityLog_Insert 4, @association_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
   
	SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	FROM 
		Associations 
	WHERE 
		(association_id = @association_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Associations_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Associations_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Associations_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Associations_Delete]
(
    @association_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)

)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[Associations] 
	WHERE 
	(
		[association_id] = @association_id
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)
   
	EXEC ActivityLog_Insert 4, @association_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
'
END
GO

/********************************************************************************

   A s s o c i a t i o n T y p e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[AssociationsTypes_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AssociationTypes_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AssociationTypes_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationTypes_Select]
AS
    SET NOCOUNT ON;

	SELECT
		associationtype_id, 
		associationtype_name, 
		associationtype_description
   FROM
		AssociationTypes
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AssociationTypes_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AssociationTypes_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AssociationTypes_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationTypes_Insert]
(
    @associationtype_id int,
    @associationtype_name varchar(50),
    @associationtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AssociationTypes] 
	(
		[associationtype_id], 
		[associationtype_name], 
		[associationtype_description]
	)
	VALUES
	(	
		@associationtype_id, 
		@associationtype_name, 
		@associationtype_description);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 5, @associationtype_id, 1, @associationtype_name, @who, @note /* ToDo: Update constants for each table */  

    SELECT
		associationtype_id, 
		associationtype_name, 
		associationtype_description 
	FROM 
		AssociationTypes
	WHERE 
		(associationtype_id = @associationtype_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AssociationTypes_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AssociationTypes_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AssociationTypes_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationTypes_Update]
(
    @associationtype_id int,
    @associationtype_name varchar(50),
    @associationtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[AssociationTypes] 
	SET 
		[associationtype_id] = @associationtype_id, 
		[associationtype_name] = @associationtype_name, 
		[associationtype_description] = @associationtype_description 
	WHERE 
	(
		([associationtype_id] = @associationtype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--  EXEC ActivityLog_Insert 5, @associationtype_id, 2, @associationtype_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[associationtype_id], 
		[associationtype_name], 
		[associationtype_description] 
	FROM 
		AssociationTypes
	WHERE 
		(associationtype_id = @associationtype_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AssociationTypes_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AssociationTypes_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AssociationTypes_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AssociationTypes_Delete]
(
    @associationtype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[AssociationTypes] 
	WHERE 
	(
		([associationtype_id] = @associationtype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 5, @associationtype_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
'
END
GO

/********************************************************************************

   A t t r i b u t e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[Attributes_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Attributes_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Attributes_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Attributes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[attribute_id],
		[attribute_name]
	FROM 
		Attributes
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Attributes_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Attributes_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Attributes_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Attributes_Insert]
(
    @attribute_id uniqueidentifier,
    @attribute_name varchar(50),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Attributes] 
	(
		[attribute_id], 
		[attribute_name]
	) 
	VALUES 
	(
		@attribute_id, 
		@attribute_name
	);

	EXEC ActivityLog_Insert 6, @attribute_id, 1, @attribute_name, @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[attribute_id], 
		[attribute_name] 
	FROM 
		Attributes 
	WHERE 
		(attribute_id = @attribute_id)
' 
END
/****** Object:  StoredProcedure [dbo].[Attributes_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Attributes_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Attributes_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Attributes_Update]
(
    @attribute_id uniqueidentifier,
    @attribute_name varchar(50),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[Attributes] 
	SET 
		[attribute_id] = @attribute_id, 
		[attribute_name] = @attribute_name 
	WHERE 
	(
		([attribute_id] = @attribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 6, @attribute_id, 2, @attribute_name, @who, @note /* ToDo: Update constants for each table */  

    SELECT 
		[attribute_id], 
		[attribute_name] 
	FROM 
		Attributes 
	WHERE 
		(attribute_id = @attribute_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Attributes_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Attributes_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Attributes_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Attributes_Delete]
(
    @attribute_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[Attributes] 
	WHERE 
	(
		([attribute_id] = attribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 6, @attribute_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO

/********************************************************************************

   A t t r i b u t e V a l u e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[AttributeValues_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AttributeValues_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AttributeValues_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AttributeValues_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[attributevalue_id], 
		[table_id], 
		[item_id],
		[itemtypeattribute_id],
		[value]
	FROM 
		[AttributeValues]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AttributeValues_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AttributeValues_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AttributeValues_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AttributeValues_Insert]
(
    @attributevalue_id uniqueidentifier,
    @table_id int,
	@item_id uniqueidentifier,
	@itemtypeattribute_id uniqueidentifier,
	@value varchar(2048),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AttributeValues] 
	(
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	) 
	VALUES 
	(
		@attributevalue_id, 
		@table_id,
		@item_id,
		@itemtypeattribute_id,
		@value
	);

   EXEC ActivityLog_Insert 12, @attributevalue_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	FROM 
		AttributeValues 
	WHERE 
		([attributevalue_id] = @attributevalue_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[AttributeValues_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AttributeValues_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AttributeValues_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
	@itemtypeattribute_id uniqueidentifier,
	@value varchar(2048),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[AttributeValues] 
	SET 
		[table_id] = @table_id, 
		[item_id] = @item_id, 
		[itemtypeattribute_id] = @itemtypeattribute_id,
		[value] = @value
	WHERE 
	(
		([attributevalue_id] = @attributevalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 12, @attributevalue_id, 2, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	FROM 
		AttributeValues 
	WHERE 
		([attributevalue_id] = @attributevalue_id)
' 
END                  
GO

/****** Object:  StoredProcedure [dbo].[AttributeValues_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AttributeValues_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[AttributeValues_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[AttributeValues_Delete]
(
    @attributevalue_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[AttributeValues] 
	WHERE 
	(
		([attributevalue_id] = @attributevalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 12, @attributevalue_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO

/********************************************************************************

   C o n s t r a i n e d V a l u e L i s t s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValueLists_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ConstrainedValueLists_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValueLists_Select
AS
    SET NOCOUNT ON;

	SELECT
		[constrainedvaluelist_id],
		[constrainedvaluelist_name],
		[constrainedvaluelist_description],
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	FROM
		[ConstrainedValueLists]
'
END
GO

/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValueLists_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.ConstrainedValueLists_Insert
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValueLists_Insert
(
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvaluelist_name varchar(50),
    @constrainedvaluelist_description varchar(1024),
    @constrainedvaluelist_nbritems int,
	@constrainedvaluelist_datatype_id int,
	@who varchar(50),      
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;
	INSERT INTO [ConstrainedValueLists] 
   (	
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	)
	VALUES 
	(
		@constrainedvaluelist_id, 
		@constrainedvaluelist_name, 
		@constrainedvaluelist_description, 
		@constrainedvaluelist_nbritems,
		@constrainedvaluelist_datatype_id
	 );

	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 1, constrainedvaluelist_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	FROM 
		[ConstrainedValueLists] 
	WHERE 
		(constrainedvaluelist_id = @constrainedvaluelist_id)
'
END
GO

/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValueLists_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.ConstrainedValueLists_Update
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValueLists_Update
(
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvaluelist_name varchar(50),
    @constrainedvaluelist_description varchar(1024),
    @constrainedvaluelist_nbritems int,
	@constrainedvaluelist_datatype_id int,
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ConstrainedValueLists] 
	SET 
		[constrainedvaluelist_id] = @constrainedvaluelist_id, 
		[constrainedvaluelist_name] = @constrainedvaluelist_name, 
		[constrainedvaluelist_description] = @constrainedvaluelist_description, 
		[constrainedvaluelist_nbritems] = @constrainedvaluelist_nbritems,
		[constrainedvaluelist_datatype_id] = @constrainedvaluelist_datatype_id
	WHERE 
	(
		([constrainedvaluelist_id] = @constrainedvaluelist_id) 
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);
    
	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	FROM 
		[ConstrainedValueLists] 
	WHERE 
		(constrainedvaluelist_id = @constrainedvaluelist_id)
'
END
GO

/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValueLists_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.ConstrainedValueLists_Delete
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValueLists_Delete
(
    @constrainedvaluelist_id uniqueidentifier,
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ConstrainedValueLists] 
	WHERE 
	(
		([constrainedvaluelist_id] = @constrainedvaluelist_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */ 
	)

	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
'
END
GO

/********************************************************************************

   C o n s t r a i n e d V a l u e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValues_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.ConstrainedValues_Select
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValues_Select
AS
    SET NOCOUNT ON;

	SELECT
		[constrainedvalue_id],
		[constrainedvaluelist_id],
		[constrainedvalue_value],
		[constrainedvalue_ordinal],
		[constrainedvalue_description]
	FROM
		ConstrainedValues
'
END
GO

/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValues_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.ConstrainedValues_Insert
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValues_Insert
(
	@constrainedvalue_id uniqueidentifier,
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvalue_value varchar(50),
    @constrainedvalue_ordinal int,
    @constrainedvalue_description varchar(1024),
	@who varchar(50),      
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;
	INSERT INTO [ConstrainedValues] 
	(	
		[constrainedvalue_id],
		[constrainedvaluelist_id], 
		[constrainedvalue_value], 
		[constrainedvalue_ordinal], 
		[constrainedvalue_description]
	)
	VALUES 
	(
		@constrainedvalue_id,
		@constrainedvaluelist_id, 
		@constrainedvalue_value, 
		@constrainedvalue_ordinal, 
		@constrainedvalue_description
	);

	EXEC ActivityLog_Insert 9, @constrainedvalue_id, 1, @constrainedvalue_value, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvalue_id],
		[constrainedvaluelist_id], 
		[constrainedvalue_value], 
		[constrainedvalue_ordinal], 
		[constrainedvalue_description]
	FROM 
		ConstrainedValues 
	WHERE 
		(constrainedvalue_id = @constrainedvalue_id)
'
END
GO

/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValues_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.ConstrainedValues_Update
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValues_Update
(
	@constrainedvalue_id uniqueidentifier,
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvalue_value varchar(50),
    @constrainedvalue_ordinal int,
    @constrainedvalue_description varchar(1024),
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ConstrainedValues] 
	SET 
		[constrainedvaluelist_id]      = @constrainedvaluelist_id, 
		[constrainedvalue_value]       = @constrainedvalue_value, 
		[constrainedvalue_ordinal]     = @constrainedvalue_ordinal, 
		[constrainedvalue_description] = @constrainedvalue_description 
	WHERE 
	(
		([constrainedvalue_id] = @constrainedvalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */ 
	);
    
	EXEC ActivityLog_Insert 9, @constrainedvalue_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvalue_id],
		[constrainedvaluelist_id], 
		[constrainedvalue_value], 
		[constrainedvalue_ordinal], 
		[constrainedvalue_description]
	FROM 
		ConstrainedValues 
	WHERE 
		(constrainedvalue_id = @constrainedvalue_id)
'
END
GO

/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ConstrainedValues_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.ConstrainedValues_Delete
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.ConstrainedValues_Delete
(
    @constrainedvalue_id uniqueidentifier,
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ConstrainedValues] 
	WHERE 
	(
		([constrainedvalue_id] = @constrainedvalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 9, @constrainedvalue_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
'
END
GO

/********************************************************************************

   D a t a T y p e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[DataTypes_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'DataTypes_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[DataTypes_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[DataTypes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[datatype_id], 
		[datatype_name], 
		[datatype_description]
	FROM 
		[DataTypes]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[DataTypes_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'DataTypes_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[DataTypes_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[DataTypes_Insert]
(
    @datatype_id int,
    @datatype_name varchar(50),
    @datatype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)

)
AS
    SET NOCOUNT OFF;

	INSERT INTO [DataTypes] 
	(
		[datatype_id], 
		[datatype_name], 
		[datatype_description]
	) 
	VALUES 
	(
		@datatype_id, 
		@datatype_name, 
		@datatype_description
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 10, @datatype_id, 1, @datatype_name, @who, @note /* ToDo: Update constants for each table */  

    SELECT 
		[datatype_id], 
		[datatype_name], 
		[datatype_description]
	FROM 
		[DataTypes] 
	WHERE 
		([datatype_id] = @datatype_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[DataTypes_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'DataTypes_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[DataTypes_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[DataTypes_Update]
(
    @datatype_id int,
    @datatype_name varchar(50),
    @datatype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)

)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[DataTypes] 
	SET 
		[datatype_id] = @datatype_id, 
		[datatype_name] = @datatype_name, 
		[datatype_description] = @datatype_description 
	WHERE 
	(
		([datatype_id] = @datatype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--  EXEC ActivityLog_Insert 10, @datatype_id, 2, @datatype_name, @who, @note /* ToDo: Update constants for each table */  

   SELECT 
      [datatype_id], 
      [datatype_name], 
      [datatype_description] 
   FROM 
      DataTypes 
   WHERE 
   (
		[datatype_id] = @datatype_id
	)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[DataTypes_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'DataTypes_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[DataTypes_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[DataTypes_Delete]
(
    @datatype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[DataTypes] 
	WHERE 
	(
		([datatype_id] = @datatype_id) 
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--  EXEC ActivityLog_Insert 10, @datatype_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO

/********************************************************************************

   I t e m s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[Items_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Items_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Items_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Items_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
	FROM 
		[Items]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Items_SelectByItemName]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Items_SelectByItemName' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Items_SelectByItemName]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_SelectByItemName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Items_SelectByItemName]
(
    @item_name varchar(256)
)
AS
    SET NOCOUNT ON;

	SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
   FROM 
		[Items] 
   where 
		item_name = @item_name
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Items_SelectByItemTypeId]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Items_SelectByItemTypeId' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Items_SelectByItemTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_SelectByItemTypeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Items_SelectByItemTypeId]
(
    @itemtype_id uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
   FROM 
		Items 
   where 
		itemtype_id = @itemtype_id
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Items_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Items_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Items_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Items_Insert]
(
    @item_id uniqueidentifier,
    @item_name varchar(256),
	@itemtype_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Items] 
	(
		[item_id], 
		[item_name], 
		[itemtype_id]
	) 
	VALUES 
	(
		@item_id, 
		@item_name,
		@itemtype_id
	);

   EXEC ActivityLog_Insert 12, @item_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
	FROM 
		Items 
	WHERE 
		(item_id = @item_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[Items_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Items_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Items_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Items_Update]
(
    @item_id uniqueidentifier,
    @item_name varchar(256),
	@itemtype_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[Items] 
	SET 
		[item_id] = @item_id, 
		[item_name] = @item_name, 
		[itemtype_id] = @itemtype_id
	WHERE 
	(
		([item_id] = @item_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 12, @item_id, 2, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
	FROM 
		Items 
	WHERE 
		(item_id = @item_id)
' 
END                  
GO

/****** Object:  StoredProcedure [dbo].[Items_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'Items_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[Items_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[Items_Delete]
(
    @item_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[Items] 
	WHERE 
	(
		([item_id] = @item_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 12, @item_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO

/********************************************************************************

   I t e m T y p e A t t r i b u t e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeAttributes_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeAttributes_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	FROM 
		ItemTypeAttributes
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_SelectByItemTypeId]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeAttributes_SelectByItemTypeId' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeAttributes_SelectByItemTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_SelectByItemTypeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeAttributes_SelectByItemTypeId]
(
    @ItemTypeId uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT 
		itemtypeattribute_id, 
		itemtype_id, 
		attribute_id, 
		usage_attributes, 
		datatype_id, 
		itemtypeattribute_version, 
		itemtypeattribute_description
   FROM 
		ItemTypeAttributes 
   where 
		itemtype_id = @ItemTypeId
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeAttributes_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeAttributes_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Insert]
(
    @itemtypeattribute_id uniqueidentifier,
    @itemtype_id uniqueidentifier,
    @attribute_id uniqueidentifier,
    @usage_attributes int,
    @datatype_id int,
    @itemtypeattribute_version int,
    @itemtypeattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypeAttributes] 
	(
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	) 
	VALUES 
	(
		@itemtypeattribute_id, 
		@itemtype_id, 
		@attribute_id, 
		@usage_attributes, 
		@datatype_id, 
		@itemtypeattribute_version, 
		@itemtypeattribute_description
	);

   EXEC ActivityLog_Insert 12, @itemtypeattribute_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	FROM 
		ItemTypeAttributes 
	WHERE 
		(itemtypeattribute_id = @itemtypeattribute_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeAttributes_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeAttributes_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Update]
(
    @itemtypeattribute_id uniqueidentifier,
    @itemtype_id uniqueidentifier,
    @attribute_id uniqueidentifier,
    @usage_attributes int,
    @datatype_id int,
    @itemtypeattribute_version int,
    @itemtypeattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ItemTypeAttributes] 
	SET 
		[itemtypeattribute_id] = @itemtypeattribute_id, 
		[itemtype_id] = @itemtype_id, 
		[attribute_id] = @attribute_id, 
		[usage_attributes] = @usage_attributes, 
		[datatype_id] = @datatype_id, 
		[itemtypeattribute_version] = @itemtypeattribute_version, 
		[itemtypeattribute_description] = @itemtypeattribute_description 
	WHERE 
	(
		([itemtypeattribute_id] = @itemtypeattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 12, @itemtypeattribute_id, 2, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description] 
	FROM 
		ItemTypeAttributes 
	WHERE 
		(itemtypeattribute_id = @itemtypeattribute_id)
' 
END                  
GO

/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeAttributes_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeAttributes_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Delete]
(
    @itemtypeattribute_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ItemTypeAttributes] 
	WHERE 
	(
		([itemtypeattribute_id] = @itemtypeattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 12, @itemtypeattribute_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO

/********************************************************************************

   I t e m T y p e G r o u p s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Select]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeGroups_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeGroups_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeGroups_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[itemtypegroup_id], 
		[itemtypegroup_name], 
		[itemtypegroup_description]
	FROM 
		ItemTypeGroups
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Insert]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeGroups_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeGroups_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeGroups_Insert]
(
    @itemtypegroup_id uniqueidentifier,
    @itemtypegroup_name varchar(50),
    @itemtypegroup_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypeGroups] 
    (
		[itemtypegroup_id], 
        [itemtypegroup_name], 
        [itemtypegroup_description]
    ) 
	VALUES 
    (
        @itemtypegroup_id, 
        @itemtypegroup_name, 
        @itemtypegroup_description
    );

    EXEC ActivityLog_Insert 13, @itemtypegroup_id, 1, @itemtypegroup_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtypegroup_id], 
        [itemtypegroup_name], 
        [itemtypegroup_description]
	FROM 
		ItemTypeGroups 
	WHERE 
      (	itemtypegroup_id = @itemtypegroup_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Update]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeGroups_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeGroups_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeGroups_Update]
(
    @itemtypegroup_id uniqueidentifier,
    @itemtypegroup_name varchar(50),
    @itemtypegroup_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
      [	ItemTypeGroups] 
	SET 
		[itemtypegroup_id]          = @itemtypegroup_id, 
		[itemtypegroup_name]        = @itemtypegroup_name, 
		[itemtypegroup_description] = @itemtypegroup_description 
	WHERE 
    (
        ([itemtypegroup_id] = @itemtypegroup_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
    );

    EXEC ActivityLog_Insert 13, @itemtypegroup_id, 2, @itemtypegroup_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtypegroup_id], 
		[itemtypegroup_name], 
		[itemtypegroup_description] 
	FROM 
		ItemTypeGroups 
	WHERE 
		(itemtypegroup_id = @itemtypegroup_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypeGroups_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypeGroups_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypeGroups_Delete]
(
    @itemtypegroup_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ItemTypeGroups] 
	WHERE 
    (
		([itemtypegroup_id] = @itemtypegroup_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

   EXEC ActivityLog_Insert 13, @itemtypegroup_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
'
END
GO

/********************************************************************************

   I t e m T y p e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[ItemTypes_Select]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypes_Select' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypes_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description]
   FROM
		ItemTypes
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypes_SelectByItemTypeGroupId]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypes_SelectByItemTypeGroupId' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypes_SelectByItemTypeGroupId]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_SelectByItemTypeGroupId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypes_SelectByItemTypeGroupId]
(
    @ItemTypeGroupId uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT 
		itemtype_id, 
		itemtype_name, 
		itemtypegroup_id, 
		itemtype_version, 
		itemtype_description
   FROM 
		ItemTypes 
   where 
		itemtypegroup_id = @ItemTypeGroupId
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypes_Insert]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypes_Insert' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypes_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypes_Insert]
(
    @itemtype_id uniqueidentifier,
    @itemtype_name varchar(50),
    @itemtypegroup_id uniqueidentifier,
    @itemtype_version int,
    @itemtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypes] 
	(
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description]
	) 
	VALUES 
	(
		@itemtype_id, 
		@itemtype_name, 
		@itemtypegroup_id, 
		@itemtype_version, 
		@itemtype_description);

	EXEC ActivityLog_Insert 14, @itemtype_id, 1, @itemtype_name, @who, @note /* ToDo: Update constants for each table */

	SELECT 
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description] 
	FROM 
		ItemTypes 
	WHERE 
		(itemtype_id = @itemtype_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypes_Update]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypes_Update' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypes_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypes_Update]
(
    @itemtype_id uniqueidentifier,
    @itemtype_name varchar(50),
    @itemtypegroup_id uniqueidentifier,
    @itemtype_version int,
    @itemtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ItemTypes] 
	SET 
		[itemtype_id] = @itemtype_id, 
		[itemtype_name] = @itemtype_name, 
		[itemtypegroup_id] = @itemtypegroup_id, 
		[itemtype_version] = @itemtype_version, 
		[itemtype_description] = @itemtype_description 
	WHERE 
    (
        ([itemtype_id] = @itemtype_id) 
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 14, @itemtype_id, 2, @itemtype_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description] 
	FROM 
		ItemTypes 
	WHERE 
		(itemtype_id = @itemtype_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ItemTypes_Delete]    Script Date: 01/06/2006 11:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ItemTypes_Delete' AND user_name(uid) = 'dbo')
    DROP PROCEDURE [dbo].[ItemTypes_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[ItemTypes_Delete]
(
    @itemtype_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ItemTypes] 
	WHERE 
    (
		([itemtype_id] = @itemtype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
    ) 

	EXEC ActivityLog_Insert 14, @itemtype_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
'
END
GO

/********************************************************************************

   T a b l e s
   
 ********************************************************************************/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.Tables_Select
AS
    SET NOCOUNT ON;

	SELECT
		table_id, 
		table_name, 
		table_version, 
		table_description,
		last_changed
	FROM
		dbo.Tables
'
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.Tables_Insert
(
    @table_id int,
    @table_name varchar(50),
    @table_version int,
    @table_description varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO
		[dbo].[Tables]
	(
		[table_id], 
		[table_name], 
		[table_version], 
		[table_description]
	)
	VALUES
	(
		@table_id, 
		@table_name, 
		@table_version, 
		@table_description
	);
    
	SELECT
		table_id, 
		table_name, 
		table_version, 
		table_description,
		last_changed
	FROM 
		Tables 
	WHERE
		(table_id = @table_id)
'
END
GO

/****** Object:  StoredProcedure [dbo].[Tables_Update]    Script Date: 01/06/2006 11:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.Tables_Update
(
    @table_id int,
    @table_name varchar(50),
    @table_version int,
    @table_description varchar(1024),
	@last_changed timestamp
)
AS
    SET NOCOUNT OFF;

	UPDATE
		[dbo].[Tables] 
	SET
		[table_id] = @table_id, 
		[table_name] = @table_name, 
		[table_version] = @table_version, 
		[table_description] = @table_description 
	WHERE 
	(
		([table_id] = @table_id)
		AND ([last_changed] = @last_changed)
	);
    
	SELECT
		table_id, 
		table_name, 
		table_version, 
		table_description,
		last_changed
	FROM 
		Tables 
	WHERE
		(table_id = @table_id)
'
END
GO

/****** Object:  StoredProcedure [dbo].[Tables_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE dbo.Tables_Delete
(
    @table_id int,
	@last_changed timestamp
)
AS
    SET NOCOUNT OFF;

	DELETE FROM
		[dbo].[Tables]
	WHERE
		(
			([table_id] = @table_id)
			 AND ([last_changed] = @last_changed)
		)
' 
END
GO

/********************************************************************************

   U s a g e A t t r i b u t e s
   
 ********************************************************************************/

/****** Object:  StoredProcedure [dbo].[UsageAttributes_Select]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Select]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[UsageAttributes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		usageattribute_id, 
		usageattribute_name, 
		usageattribute_description
   FROM
		[UsageAttributes]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[UsageAttributes_Insert]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Insert]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[UsageAttributes_Insert]
(
    @usageattribute_id int,
    @usageattribute_name varchar(50),
    @usageattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [UsageAttributes] 
	(
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description]
	) 
	VALUES 
	(
		@usageattribute_id, 
		@usageattribute_name, 
		@usageattribute_description
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 16, @usageattribute_id, 1, @usageattribute_name, @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description] 
	FROM 
		[UsageAttributes] 
	WHERE 
		(usageattribute_id = @usageattribute_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[UsageAttributes_Update]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Update]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[UsageAttributes_Update]
(
    @usageattribute_id int,
    @usageattribute_name varchar(50),
    @usageattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[UsageAttributes] 
	SET 
		[usageattribute_id] = @usageattribute_id, 
		[usageattribute_name] = @usageattribute_name, 
		[usageattribute_description] = @usageattribute_description 
	WHERE 
	(
		([usageattribute_id] = @usageattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 16, @usageattribute_id, 2, @usageattribute_name, @who, @note /* ToDo: Update constants for each table */  	
	
	SELECT 
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description] 
	FROM 
		[UsageAttributes] 
	WHERE 
		(usageattribute_id = @usageattribute_id)
' 
END
GO

/****** Object:  StoredProcedure [dbo].[UsageAttributes_Delete]    Script Date: 01/06/2006 11:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Delete]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
CREATE PROCEDURE [dbo].[UsageAttributes_Delete]
(
    @usageattribute_id int,

    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

    DELETE FROM 
		[UsageAttributes] 
	WHERE 
	(
		([usageattribute_id] = @usageattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 16, @usageattribute_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO

/********************************************************************************

	E n d    o f    F i l e
   
 ********************************************************************************/