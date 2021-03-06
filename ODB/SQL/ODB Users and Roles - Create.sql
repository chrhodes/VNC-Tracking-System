USE [master]
GO
/****** Object:  Database [VNC]    Script Date: 12/17/2005 15:04:06 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'VNC')
BEGIN
CREATE DATABASE [VNC] ON  PRIMARY 
( NAME = N'VNC_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL\data\VNC_Data.MDF' , SIZE = 102400KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'VNC_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL\data\VNC_Log.LDF' , SIZE = 51200KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
END

GO
EXEC dbo.sp_dbcmptlevel @dbname=N'VNC', @new_cmptlevel=80
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VNC].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [VNC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VNC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VNC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VNC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VNC] SET ARITHABORT OFF 
GO
ALTER DATABASE [VNC] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VNC] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [VNC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VNC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VNC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VNC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VNC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VNC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VNC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VNC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VNC] SET  ENABLE_BROKER 
GO
ALTER DATABASE [VNC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VNC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VNC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VNC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VNC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VNC] SET  READ_WRITE 
GO
ALTER DATABASE [VNC] SET RECOVERY FULL 
GO
ALTER DATABASE [VNC] SET  MULTI_USER 
GO
ALTER DATABASE [VNC] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [VNC] SET DB_CHAINING OFF 
USE [VNC]
GO

/************************************************************
 R o l e s
 ************************************************************/

/****** Object:  Schema [VNCDBadmin]    Script Date: 12/17/2005 15:04:12 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'VNCDBadmin')
EXEC sys.sp_executesql N'CREATE SCHEMA [VNCDBadmin] AUTHORIZATION [VNCDBadmin]'

GO
/****** Object:  Schema [crhodes]    Script Date: 12/17/2005 15:04:12 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'crhodes')
EXEC sys.sp_executesql N'CREATE SCHEMA [crhodes] AUTHORIZATION [crhodes]'

GO
/**************************************
 T a b l e s
 **************************************/

/****** Object:  Table [dbo].[tbl_abstractions]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_abstractions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_abstractions](
	[abstraction_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_abstractions_oid]  DEFAULT (newid()),
	[name] [varchar](50) NOT NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_abstractions] PRIMARY KEY CLUSTERED 
(
	[abstraction_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO 

/****** Object:  Table [dbo].[tbl_activity_log]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_activity_log]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_activity_log](
	[activity_log_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_activity_log_activity_log_id]  DEFAULT (newid()),
	[table_id] [int] NOT NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[log_function_id] [int] NOT NULL,
	[value] [varchar](2048) NULL,
	[who] [varchar](50) NOT NULL,
	[when] [datetime] NOT NULL,
	[notes] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_activity_log] PRIMARY KEY CLUSTERED 
(
	[activity_log_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_attribute_values]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_attribute_values]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_attribute_values](
	[attribute_value_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_attribute_values_attribute_value_id]  DEFAULT (newid()),
	[table_id] [int] NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[type_attribute_id] [uniqueidentifier] NOT NULL,
	[value] [varchar](2048) NOT NULL,
 CONSTRAINT [PK_tbl_attribute_values] PRIMARY KEY CLUSTERED 
(
	[attribute_value_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_associations]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_associations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_associations](
	[associaton_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_associations_association_id]  DEFAULT (newid()),
	[table_id_begin] [int] NOT NULL,
	[item_id_begin] [uniqueidentifier] NOT NULL,
	[table_id_end] [int] NOT NULL,
	[item_id_end] [uniqueidentifier] NOT NULL,
	[association_type_id] [uniqueidentifier] NOT NULL,
	[abstraction_id] [char](10) NOT NULL,
 CONSTRAINT [PK_tbl_associations] PRIMARY KEY CLUSTERED 
(
	[associaton_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_association_rules]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_association_rules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_association_rules](
	[association_rule_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_type_attributes_association_rule_id]  DEFAULT (newid()),
	[table_id_begin] [int] NOT NULL,
   [table_id_end][int] NOT NULL,
   [type_id_begin][uniqueidentifier] NOT NULL,
   [type_id_end][uniqueidentifier] NOT NULL,
   [association_type_id][int] NOT NULL
 CONSTRAINT [PK_tbl_association_rules] PRIMARY KEY CLUSTERED 
(
	[association_rule_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_association_types]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_association_types]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_association_types](
	[association_type_id] [int]  NOT NULL CONSTRAINT [DF_tbl_association_types_association_type_id],
	[association_type] [varchar](50) NOT NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_association_types] PRIMARY KEY CLUSTERED 
(
	[association_type_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_attributes]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_attributes](
	[attribute_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_attributes_attribute_id]  DEFAULT (newid()),
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_attributes] PRIMARY KEY CLUSTERED 
(
	[attribute_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_data_types]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_data_types]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_data_types](
	[data_type_id] [int] NOT NULL,
	[data_type] [VARCHAR](50) NOT NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_data_types] PRIMARY KEY CLUSTERED 
(
	[data_type_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_type_attributes]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_type_attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_type_attributes](
	[type_attributes_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_type_attributes_id]  DEFAULT (newid()),
	[type_id] [uniqueidentifier] NOT NULL,
	[attribute_id] [uniqueidentifier] NOT NULL,
	[usage_attribute] [int] NULL,
   [version] [int] NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_type_attributes] PRIMARY KEY CLUSTERED 
(
	[type_attributes_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_constrained_values]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_constrained_values]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_constrained_values](
	[oid] [uniqueidentifier] NOT NULL,
	[table_id] [int] NOT NULL,
	[object_oid] [uniqueidentifier] NOT NULL,
	[values] [nvarchar](2048) NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_items]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_items]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_items](
	[item_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_things_item_id]  DEFAULT (newid()),
	[type_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_items] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_log_functions]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_log_functions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_log_functions](
	[log_function_id] [int] NOT NULL,
	[log_function] [varchar](50) NOT NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_log_functions] PRIMARY KEY CLUSTERED 
(
	[log_function_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_tables]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_tables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_tables](
	[table_id] [int] NOT NULL,
	[table_name] [varchar](50) NOT NULL,
	[version] [int] NOT NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_tables] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_types]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_types]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_types](
	[type_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tbl_classes_oid]  DEFAULT (newid()),
	[name] [varchar](50) NOT NULL,
	[abstraction_id] [uniqueidentifier] NULL,
	[version] [int] NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_classes] PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[tbl_usage_attributes]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_usage_attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_usage_attributes](
	[data_type_id] [int] NOT NULL,
	[usage_attribute] [varchar](50) NOT NULL,
	[description] [varchar](1024) NULL,
 CONSTRAINT [PK_tbl_usage_attributes] PRIMARY KEY CLUSTERED 
(
	[data_type_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/**************************************
 S t o r e d     P r o c e d u r e s
 **************************************/

/* tbl_abstractions */
/* tbl_activity_log */


/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		    Christopher Rhodes
-- Create date:  12/17/2005
-- Description:   Inserts a row into tbl_activity_log
-- =============================================
CREATE PROCEDURE [dbo].[ActivityLog_Insert] 
	@TableId int,
	@ItemId uniqueidentifier,
	@LogFunctionId int,
	@Value varchar(2048),
	@Who varchar(50),
	@Notes varchar(1024)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO
		tbl_activity_log
	VALUES
		(
			newid(),
			@TableId,
			@ItemId,
			@LogFunctionId,
			@Value,
			@Who,
			getDate(),
			@Notes
		)
END

' 
END
GO
/* tbl_associations */
/* tbl_associaton_rules */
/* tbl_association_types */
/* tbl_attributes */
/* tbl_attribute_values */
/* tbl_constrained_values */
/* tbl_items */
/* tbl_log_functions */
/* tbl_tabes */
/* tbl_types */
/* tbl_type_attributes */
/* tbl_usage_attributes */

/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_select_all]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_select_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_select_all    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_select_all]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_attributes_select_all                                   
   
   DESCRIPTION:  Selects a record from table ''tbl_attributes''                                
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:01 PM                 
   ------------------------------------------------------------ */

AS 
    
SELECT 

	[oid],
	[name],
	[data_type_id],
	[version],
	[description]

FROM
 
        [tbl_attributes]

RETURN @@ERROR' 
END
GO

/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_select_by_ID]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_select_by_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_select_by_ID    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_select_by_ID]

/* ------------------------------------------------------------
   PROCEDURE:    up_sel_by_ID_tbl_attributes                                   
   
   DESCRIPTION:  Selects a unique record 
                 from table ''tbl_attributes''
                                                 
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:01 PM                 
   ------------------------------------------------------------ */

@oid uniqueidentifier

AS

SELECT 

	[oid],
	[name],
	[data_type_id],
	[version],
	[description]

FROM
	[tbl_attributes]

WHERE 

	[oid] = @oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_select_by_name]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_select_by_name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_select_by_name    Script Date: 9/22/2004 2:17:49 PM ******/

CREATE  PROCEDURE [dbo].[up_tbl_attributes_select_by_name]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_attributes_select_by_name                                   
   
   DESCRIPTION:  Selects one or more records
                from table ''tbl_attributes''                                
                based on name and optional version.
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:01 PM                 
   ------------------------------------------------------------ */

@name nvarchar(50),
@version int = NULL

AS 

IF @version = NULL
BEGIN
	SELECT 
        	[oid],
		[name],
		[data_type_id],
 		[version],
		[description]
        FROM
		[tbl_attributes]
        WHERE 
    		[name] = @name
END
ELSE
BEGIN
	SELECT 
        	[oid],
		[name],
		[data_type_id],
 		[version],
		[description]
        FROM
		[tbl_attributes]
        WHERE 
		[name] = @name AND [version] = @version
END
           
RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_update]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_update    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_update]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_attributes_update                                   
   
   DESCRIPTION:  Updates a record in table ''tbl_attributes''                                  
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:37 PM                 
   ------------------------------------------------------------ */

@oid		uniqueidentifier,
@name               nvarchar(50),
@data_type_id	int,
@version	int,
@description	nvarchar(256)  = NULL

AS
UPDATE
	[tbl_attributes]

SET 

	[name] = @name,
	[data_type_id] = @data_type_id,
	[version] = @version,
	[description] = @description

WHERE 

	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_update_New]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_update_New]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_update_New    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_update_New]
(
	@oid uniqueidentifier,
	@name nvarchar(50),
	@version int,
	@data_type int,
	@usage_attribute int,
	@description nvarchar(256),
	@Original_oid uniqueidentifier,
	@Original_name nvarchar(50),
	@Original_version int,
	@IsNull_data_type int,
	@Original_data_type int,
	@IsNull_usage_attribute int,
	@Original_usage_attribute int,
	@IsNull_description nvarchar(256),
	@Original_description nvarchar(256)
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[tbl_attributes] SET [oid] = @oid, [name] = @name, [version] = @version, [data_type] = @data_type, [usage_attribute] = @usage_attribute, [description] = @description WHERE (([oid] = @Original_oid) AND ([name] = @Original_name) AND ([version] = @Original_version) AND ((@IsNull_data_type = 1 AND [data_type] IS NULL) OR ([data_type] = @Original_data_type)) AND ((@IsNull_usage_attribute = 1 AND [usage_attribute] IS NULL) OR ([usage_attribute] = @Original_usage_attribute)) AND ((@IsNull_description = 1 AND [description] IS NULL) OR ([description] = @Original_description)))
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_class_attributes_delete]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_class_attributes_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_class_attributes_delete    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_class_attributes_delete]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_class_attributes_delete                            
   
   DESCRIPTION:  Deletes a record from table ''tbl_class_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:37 PM                 
   ------------------------------------------------------------ */

@oid uniqueidentifier

AS
     
DELETE

FROM

	[tbl_class_attributes]

WHERE 
	[oid] = @oid

	
IF @@ROWCOUNT = 0
	
BEGIN
	RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_class_attributes_insert]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_class_attributes_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_class_attributes_insert    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_class_attributes_insert]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_class_attributes_insert                            
   
   DESCRIPTION:  Inserts a record into table ''tbl_class_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:37 PM                 
   ------------------------------------------------------------ */

@oid			uniqueidentifier = NULL OUTPUT,
@class_oid		uniqueidentifier,
@attribute_oid    	uniqueidentifier,
@usage_attribute  	int = NULL,
@description		nvarchar(256) = NULL

AS

if @oid is NULL SET @oid = newid()

INSERT INTO

	[tbl_class_attributes]

(
	[oid],
	[class_oid],
	[attribute_oid],
	[usage_attribute],
	[description]
)

VALUES

(
	@oid,
	@class_oid,
	@attribute_oid,
	@usage_attribute,
	@description
)

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_class_attributes_select_all]    Script Date: 12/17/2005 15:04:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_class_attributes_select_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_class_attributes_select_all    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_class_attributes_select_all]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_class_attributes_select_all                            
   
   DESCRIPTION:  Selects a record from table ''tbl_class_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:01 PM                 
   ------------------------------------------------------------ */

AS

SELECT 
	[oid],
	[class_oid],
	[attribute_oid],
	[usage_attribute],
	[description]

FROM

	[tbl_class_attributes]

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_class_attributes_select_by_attrID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_class_attributes_select_by_attrID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_class_attributes_select_by_attrID    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_class_attributes_select_by_attrID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_class_attributes_select_by_attrID                            
   
   DESCRIPTION:  Selects a record from table ''tbl_class_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:01 PM                 
   ------------------------------------------------------------ */

@attribute_oid uniqueidentifier

AS

SELECT 
	[oid],	
	[class_oid],
	[attribute_oid],
	[usage_attribute],
	[description]


FROM
	[tbl_class_attributes]

WHERE 

	[attribute_oid] = @attribute_oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_class_attributes_select_by_classID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_class_attributes_select_by_classID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_class_attributes_select_by_classID    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_class_attributes_select_by_classID]

/* ------------------------------------------------------------
   PROCEDURE:    up_sel_by_classID_tbl_class_attributes                            
   
   DESCRIPTION:  Selects a record from table ''tbl_class_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:01 PM                 
   ------------------------------------------------------------ */

@class_oid uniqueidentifier

AS 

SELECT 
	
	[oid],
	[class_oid],
	[attribute_oid],
	[usage_attribute],
	[description]

FROM
	[tbl_class_attributes]

WHERE 

	[class_oid] = @class_oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_class_attributes_update]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_class_attributes_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_class_attributes_update    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_class_attributes_update]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_class_attributes_update                            
   
   DESCRIPTION:  Updates a record in table ''tbl_class_attributes''                           
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:37 PM                 
   ------------------------------------------------------------ */

@oid			uniqueidentifier,
@class_oid		uniqueidentifier,
@attribute_oid		uniqueidentifier,
@usage_attribute	int  = NULL ,
@description		nvarchar(256) = NULL


AS

UPDATE
	[tbl_class_attributes]

SET 
	[class_oid] = @class_oid,
	[attribute_oid] = @attribute_oid,
	[usage_attribute] = @usage_attribute,
	[description] = @description

WHERE 

	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_classes_delete]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_classes_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_classes_delete    Script Date: 9/22/2004 2:17:49 PM ******/

CREATE PROCEDURE [dbo].[up_tbl_classes_delete]

@oid uniqueidentifier

AS
     
DELETE

FROM
 
	[tbl_classes]

WHERE 

	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_classes_insert]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_classes_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_classes_insert    Script Date: 9/22/2004 2:17:49 PM ******/

CREATE PROCEDURE [dbo].[up_tbl_classes_insert]

@oid           uniqueidentifier = NULL OUTPUT,
@name          nvarchar(50),
@version       int,
@parent_oid     uniqueidentifier = NULL,
@description   nvarchar(256) = NULL

AS
     
if @oid is NULL SET @oid = newid()

INSERT

INTO
     
	[tbl_classes]

(
	[oid],
        [name],
	[version],
        [parent_oid],
	[description]
)

VALUES

(
	@oid,
        @name,
	@version,
        @parent_oid,
	@description
)

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_classes_select_all]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_classes_select_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_classes_select_all    Script Date: 9/22/2004 2:17:49 PM ******/

CREATE PROCEDURE [dbo].[up_tbl_classes_select_all]

AS
     
SELECT 

	[oid],
	[name],
	[version],
	[parent_oid],
	[description]

FROM

        [tbl_classes]

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_classes_select_by_ID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_classes_select_by_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_classes_select_by_ID    Script Date: 9/22/2004 2:17:49 PM ******/

CREATE PROCEDURE [dbo].[up_tbl_classes_select_by_ID]

@oid uniqueidentifier

AS
     
SELECT 

	[oid],
	[name],
	[version],
	[parent_oid],
	[description]

FROM
 
        [tbl_classes]

WHERE 

	[oid] = @oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_classes_select_by_name]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_classes_select_by_name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_classes_select_by_name    Script Date: 9/22/2004 2:17:49 PM ******/

CREATE PROCEDURE [dbo].[up_tbl_classes_select_by_name]

@name nvarchar(50)

AS
     
SELECT 

	[oid],
	[name],
	[version],
	[parent_oid],
	[description]
   
FROM

        [tbl_classes]

WHERE 

	[name] = @name

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_classes_select_by_parentID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_classes_select_by_parentID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_classes_select_by_parentID    Script Date: 9/22/2004 2:17:50 PM ******/

CREATE PROCEDURE [dbo].[up_tbl_classes_select_by_parentID]

@parent_oid uniqueidentifier

AS
     
SELECT 

	[oid],
	[name],
	[version],
	[parent_oid],
	[description]

FROM
 
        [tbl_classes]

WHERE 

	[parent_oid] = @parent_oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_classes_update]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_classes_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_classes_update    Script Date: 9/22/2004 2:17:50 PM ******/

CREATE PROCEDURE [dbo].[up_tbl_classes_update]

@oid           uniqueidentifier,
@name          nvarchar(50),
@version       int,
@parent_oid     uniqueidentifier = NULL,
@description   nvarchar(256)  = NULL

AS 
    
UPDATE
     
	[tbl_classes]

SET 

	[name]         = @name,
	[version]      = @version,
	[parent_oid]    = @parent_oid,
	[description]  = @description

WHERE 

	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END


	RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes2_delete]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes2_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes2_delete    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes2_delete]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes2_delete
   
   DESCRIPTION:  Deletes a record from table ''tbl_thing_attributes2''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:37 PM                 
   ------------------------------------------------------------ */

@oid                         uniqueidentifier

AS

DELETE

FROM
	[tbl_thing_attributes2]
WHERE 
	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END
RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes2_insert]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes2_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes2_insert    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes2_insert]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes2_insert                            
   
   DESCRIPTION:  Inserts a record into table ''tbl_thing_attributes2''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:38 PM                 
   ------------------------------------------------------------ */

@oid			uniqueidentifier = NULL OUTPUT,
@thing_oid		uniqueidentifier,
@class_attribute_oid	uniqueidentifier,
@value			nvarchar(256) = NULL,
@data_type_id		int

AS

IF @oid IS NULL SET @oid = newid()

INSERT

INTO

	[tbl_thing_attributes2]

(
	[oid],
       	[thing_oid],
	[class_attribute_oid],
	[value],
	[data_type_id]
)

VALUES

(
        @oid,
	@thing_oid,
	@class_attribute_oid,
	@value,
	@data_type_id
)

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes2_select_all]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes2_select_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes2_select_all    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes2_select_all]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes2_select_all                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes2''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

AS

SELECT 

	[oid],		 
	[thing_oid],
	[class_attribute_oid],
	[value],
	[data_type_id]

FROM
 
	[tbl_thing_attributes2]

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes2_select_by_attrID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes2_select_by_attrID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes2_select_by_attrID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes2_select_by_attrID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes2_select_by_attrID                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes2''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@class_attribute_oid                    uniqueidentifier

AS

SELECT 

	[oid] 
	[thing_oid],
	[class_attribute_oid],
	[value],
	[data_type_id]

FROM
 
	[tbl_thing_attributes2]

WHERE 

	[class_attribute_oid] = @class_attribute_oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes2_select_by_ID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes2_select_by_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes2_select_by_ID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes2_select_by_ID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes2_select_by_ID                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes2''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@oid                    uniqueidentifier

AS

SELECT 

	[oid] 
	[thing_oid],
	[class_attribute_oid],
	[value],
	[data_type_id]

FROM
 
	[tbl_thing_attributes2]

WHERE 

	[oid] = @oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes2_select_by_thingID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes2_select_by_thingID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes2_select_by_thingID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes2_select_by_thingID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes2_select_by_thingID                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes2''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@thing_oid                    uniqueidentifier

AS 

SELECT 

	[oid] 
	[thing_oid],
	[class_attribute_oid],
	[value],
	[data_type_id]

FROM
 
	[tbl_thing_attributes2]

WHERE 

	[thing_oid] = @thing_oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes2_update]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes2_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes2_update    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes2_update]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes2_update                            
   
   DESCRIPTION:  Updates a record in table ''tbl_thing_attributes2''                           
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:38 PM                 
   ------------------------------------------------------------ */

@oid			uniqueidentifier,
@thing_oid		uniqueidentifier,
@class_attribute_oid	uniqueidentifier,
@value			nvarchar(256)  = NULL,
@data_type_id		int = NULL

AS 
    
UPDATE
     
	[tbl_thing_attributes2]

SET 

	[thing_oid] = @thing_oid,
	[class_attribute_oid] = @class_attribute_oid,
	[value] = @value,
	[data_type_id] = @data_type_id

WHERE 

	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes_insert]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes_insert    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes_insert]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes_insert                            
   
   DESCRIPTION:  Inserts a record into table ''tbl_thing_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:38 PM                 
   ------------------------------------------------------------ */

@oid			uniqueidentifier = NULL OUTPUT,
@thing_oid		uniqueidentifier,
@class_attribute_oid	uniqueidentifier,
@value_number		INTEGER = NULL,
@value_string		nvarchar(256) = NULL,
@value_date		smalldatetime = NULL,
@value_money		money = NULL,
@value_oid		uniqueidentifier = NULL,
@value_image		image = NULL

AS

IF @oid IS NULL SET @oid = newid()

INSERT

INTO

	[tbl_thing_attributes]

(
	[oid],
       	[thing_oid],
	[class_attribute_oid],
	[value_number],
	[value_string],
	[value_date],
       	[value_money],
	[value_oid],
	[value_image]
)

VALUES

(
	@oid,
	@thing_oid,
	@class_attribute_oid,
	@value_number,
	@value_string,
	@value_date,
	@value_money,
	@value_oid,
	@value_image
)

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes_select_all]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes_select_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes_select_all    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes_select_all]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes_select_all                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

AS

SELECT 

	[oid],		 
	[thing_oid],
	[class_attribute_oid],
	[value_number],
	[value_string],
	[value_date],
	[value_money],
	[value_oid],
	[value_image]

FROM
 
	[tbl_thing_attributes]

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes_select_by_ID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes_select_by_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes_select_by_ID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes_select_by_ID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes_select_by_ID                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@oid                    uniqueidentifier

AS

SELECT 

	[oid] 
	[thing_oid],
	[class_attribute_oid],
	[value_number],
	[value_string],
	[value_date],
	[value_money],
	[value_oid],
	[value_image]

FROM
 
	[tbl_thing_attributes]

WHERE 

	[oid] = @oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes_select_by_attrID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes_select_by_attrID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes_select_by_attrID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes_select_by_attrID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes_select_by_attrID                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@class_attribute_oid                    uniqueidentifier

AS

SELECT 

	[oid] 
	[thing_oid],
	[class_attribute_oid],
	[value_number],
	[value_string],
	[value_date],
	[value_money],
	[value_oid],
	[value_image]

FROM
 
	[tbl_thing_attributes]

WHERE 

	[class_attribute_oid] = @class_attribute_oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes_select_by_thingID]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes_select_by_thingID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes_select_by_thingID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes_select_by_thingID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes_select_by_thingID                            
   
   DESCRIPTION:  Selects a record from table ''tbl_thing_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@thing_oid                    uniqueidentifier

AS 

SELECT 

	[oid] 
	[thing_oid],
	[class_attribute_oid],
	[value_number],
	[value_string],
	[value_date],
	[value_money],
	[value_oid],
	[value_image]

FROM
 
	[tbl_thing_attributes]

WHERE 

	[thing_oid] = @thing_oid

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes_update]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes_update    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes_update]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes_update                            
   
   DESCRIPTION:  Updates a record in table ''tbl_thing_attributes''                           
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:38 PM                 
   ------------------------------------------------------------ */

@oid			uniqueidentifier,
@thing_oid		uniqueidentifier,
@class_attribute_oid	uniqueidentifier,
@value_number              bigint = NULL,
@value_string		nvarchar(256)  = NULL,
@value_date		smalldatetime  = NULL,
@value_money		money = NULL,
@value_oid		uniqueidentifier  = NULL,
@value_image		image  = NULL

AS 
    
UPDATE
     
	[tbl_thing_attributes]

SET 

	[thing_oid] = @thing_oid,
	[class_attribute_oid] = @class_attribute_oid,
	[value_number] = @value_number,
	[value_string] = @value_string,
	[value_date] = @value_date,
	[value_money] = @value_money,
	[value_oid] = @value_oid,
	[value_image] = @value_image

WHERE 

	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_delete]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_delete    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_delete]

/*-------------------------------------------------------------
 Stored Procedure	: up_tbl_attributes_delete                                   
 Creatation Date	: 2004.09.22
 Copyright		:
 Written by		: Christopher Rhodes
 Purpose		: Deletes a record from table ''tbl_attributes'' 
 Business Rule		:

 Input Parameters	:
 Output Parameters	:
 Return Status		: 0 if no Errors
			  1 if errors
 Usage			:
 Local Variables	:
 Called By		:
 Calls			:
 Data Modifications	;
 Change Log		:
------------------------------------------------------------ */

@oid uniqueidentifier

AS 
    
DELETE 
FROM 
	[tbl_attributes]
WHERE
	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR
' 
END
GO

/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_delete_New]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_delete_New]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_delete_New    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_delete_New]
(
	@Original_oid uniqueidentifier,
	@Original_name nvarchar(50),
	@Original_version int,
	@IsNull_data_type int,
	@Original_data_type int,
	@IsNull_usage_attribute int,
	@Original_usage_attribute int,
	@IsNull_description nvarchar(256),
	@Original_description nvarchar(256)
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[tbl_attributes] WHERE (([oid] = @Original_oid) AND ([name] = @Original_name) AND ([version] = @Original_version) AND ((@IsNull_data_type = 1 AND [data_type] IS NULL) OR ([data_type] = @Original_data_type)) AND ((@IsNull_usage_attribute = 1 AND [usage_attribute] IS NULL) OR ([usage_attribute] = @Original_usage_attribute)) AND ((@IsNull_description = 1 AND [description] IS NULL) OR ([description] = @Original_description)))
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_insert]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_insert    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_insert]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_attributes_insert                                   
   
   DESCRIPTION:  Inserts a record into table ''tbl_attributes''                                
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:37 PM                 
   ------------------------------------------------------------ */

@oid                uniqueidentifier = NULL OUTPUT,
@name               nvarchar(50),
@data_type_id          int,
@version            int,
@description        nvarchar(256) = NULL

AS 
   
IF @oid IS NULL SET @oid = newid()
   
INSERT INTO [tbl_attributes]
(
	[oid],
	[name],
	[data_type_id],
	[version],
	[description]
)
VALUES
(
	@oid,
	@name,
	@data_type_id,
	@version,
	@description
)

RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_attributes_insert_New]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_attributes_insert_New]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_attributes_insert_New    Script Date: 9/22/2004 2:17:49 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_attributes_insert_New]
(
	@oid uniqueidentifier,
	@name nvarchar(50),
	@version int,
	@data_type int,
	@usage_attribute int,
	@description nvarchar(256)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[tbl_attributes] ([oid], [name], [version], [data_type], [usage_attribute], [description]) VALUES (@oid, @name, @version, @data_type, @usage_attribute, @description)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_thing_attributes_delete]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_thing_attributes_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_thing_attributes_delete    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_thing_attributes_delete]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_thing_attributes_delete                            
   
   DESCRIPTION:  Deletes a record from table ''tbl_thing_attributes''                         
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:37 PM                 
   ------------------------------------------------------------ */

@oid                         uniqueidentifier

AS

DELETE

FROM
	[tbl_thing_attributes]
WHERE 
	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END
RETURN @@ERROR' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_abstractions_ins]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_abstractions_ins]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* --------------------------------------------------------------------------------
   PROCEDURE:    up_tbl_abstractions_ins

   Description:  Inserts a record into table ''tbl_abstractions''

   AUTHOR:       Christopher Rhodes 8/28/2005 5:25:25 PM
   -------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[up_tbl_abstractions_ins]
(
@oid uniqueidentifier = null output,
@name nvarchar(50),
@description nvarchar(1024) = null
)
As
BEGIN
	DECLARE @Err Int

IF @oid IS NULL
	 SET @oid = NEWID()

Set @Err = @@Error

IF @Err <> 0
    RETURN @Err

	INSERT
	INTO [tbl_abstractions]
	(
[oid],
[name],
[description]
	)
	VALUES
	(
@oid,
@name,
@description
	)

	Set @Err = @@Error

	RETURN @Err
End
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_abstractions_sel]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_abstractions_sel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* --------------------------------------------------------------------------------
   PROCEDURE:    up_tbl_abstractions_sel

   Description:  Selects record(s) from table ''up_tbl_abstractions_sel''

   AUTHOR:       Christopher Rhodes 8/28/2005 5:25:25 PM
   -------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[up_tbl_abstractions_sel]
(
@oid uniqueidentifier
)
As
BEGIN
	DECLARE @Err Int

	Select
[oid],
[name],
[description]
	FROM [tbl_abstractions]
	WHERE
([oid] = @oid OR @oid IS NULL)

	Set @Err = @@Error

	RETURN @Err
End
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_abstractions_sel_to_params]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_abstractions_sel_to_params]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* --------------------------------------------------------------------------------
   PROCEDURE:    up_tbl_abstractions_sel_to_params

   Description:  Selects a record from table ''up_tbl_abstractions_sel_to_params''
   				 And puts values into parameters

   AUTHOR:       Christopher Rhodes 8/28/2005 5:25:25 PM
   -------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[up_tbl_abstractions_sel_to_params]
(
@oid uniqueidentifier,
@name nvarchar(50) output,
@description nvarchar(1024) output
)
As
BEGIN
	DECLARE @Err Int

	Select
@oid = [oid],
@name = [name],
@description = [description]
	FROM [tbl_abstractions]
	WHERE
[oid] = @oid

	Set @Err = @@Error

	RETURN @Err
End
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_abstractions_sel_all]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_abstractions_sel_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* --------------------------------------------------------------------------------
   PROCEDURE:    up_tbl_abstractions_sel_all

   Description:  Selects all records from the table ''up_tbl_abstractions_sel_all''

   AUTHOR:       Christopher Rhodes 8/28/2005 5:25:25 PM
   -------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[up_tbl_abstractions_sel_all]
As
BEGIN
	DECLARE @Err Int

	Select
[oid],
[name],
[description]
	FROM [tbl_abstractions]

	Set @Err = @@Error

	RETURN @Err
End
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_abstractions_upd]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_abstractions_upd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* --------------------------------------------------------------------------------
   PROCEDURE:    up_tbl_abstractions_upd

   Description:  Updates a record In table ''up_tbl_abstractions_upd''

   AUTHOR:       Christopher Rhodes 8/28/2005 5:25:25 PM
   -------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[up_tbl_abstractions_upd]
(
@oid uniqueidentifier,
@name nvarchar(50),
@description nvarchar(1024)
)
As
BEGIN
	DECLARE @Err Int

	UPDATE [tbl_abstractions]
	Set
[oid] = @oid,
[name] = @name,
[description] = @description
	WHERE
[oid] = @oid

	Set @Err = @@Error

	RETURN @Err
End
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_abstractions_del]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_abstractions_del]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* --------------------------------------------------------------------------------
   PROCEDURE:    up_tbl_abstractions_del

   Description:  Deletes a record from table ''up_tbl_abstractions_del''

   AUTHOR:       Christopher Rhodes 8/28/2005 5:25:25 PM
   -------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[up_tbl_abstractions_del]
(
@oid uniqueidentifier
)
As
BEGIN
	DECLARE @Err Int

	DELETE
	FROM [tbl_abstractions]
	WHERE
[oid] = @oid

	Set @Err = @@Error

	RETURN @Err
End
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Attribute_Insert]    Script Date: 12/17/2005 15:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attribute_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Christopher Rhodes
-- Create date: 12/17/2005
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Attribute_Insert] 
	@attribute_id	uniqueidentifier = NULL OUTPUT,
	@name           varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF @attribute_id IS NULL SET @attribute_id = newid()
   
INSERT INTO [tbl_attributes]
(
	[attribute_id],
	[name]
)
VALUES
(
	@attribute_id,
	@name
)

RETURN @@ERROR

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_things_delete]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_things_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_things_delete    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_things_delete]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_things_delete                                      
   
   DESCRIPTION:  Deletes a record from table ''tbl_things''                                   
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:38 PM                 
   ------------------------------------------------------------ */

@oid                               uniqueidentifier

AS

DELETE

FROM

	[tbl_things]

WHERE 

	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR

' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_things_insert]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_things_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_things_insert    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_things_insert]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_things_insert                                      
   
   DESCRIPTION:  Inserts a record into table ''tbl_things''                                   
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:38 PM                 
   ------------------------------------------------------------ */

@oid		uniqueidentifier = NULL OUTPUT,
@class_oid	uniqueidentifier,
@parent_oid	uniqueidentifier = NULL

AS
     
if @oid is NULL SET @oid = newid()

INSERT

INTO

	[tbl_things]

(
	[oid],
	[class_oid],
	[parent_oid]
)
VALUES

(
	@oid,
	@class_oid,
	@parent_oid
)

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_things_select_all]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_things_select_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_things_select_all    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_things_select_all]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_things_select_all                                      
   
   DESCRIPTION:  Selects a record from table ''tbl_things''                                   
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

AS

SELECT 

	[oid],
	[class_oid],
	[parent_oid]
   
FROM
	[tbl_things]

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_things_select_by_ID]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_things_select_by_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_things_select_by_ID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_things_select_by_ID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_things_select_by_ID                                      
   
   DESCRIPTION:  Selects a record from table ''tbl_things''                                   
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@oid		uniqueidentifier

AS 

SELECT 
		 
	[oid],
	[class_oid],
	[parent_oid]

FROM
	[tbl_things]

WHERE 

	[oid] = @oid

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_things_select_by_classID]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_things_select_by_classID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_things_select_by_classID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_things_select_by_classID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_things_select_by_classID                                      
   
   DESCRIPTION:  Selects a record from table ''tbl_things''                                   
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@class_oid  uniqueidentifier

AS

SELECT 

	 [oid],
	 [class_oid],
	 [parent_oid]

FROM

	[tbl_things]

WHERE 

	[class_oid] = @class_oid

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_things_select_by_parentID]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_things_select_by_parentID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_things_select_by_parentID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_things_select_by_parentID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_things_select_by_parentID                                      
   
   DESCRIPTION:  Selects a record from table ''tbl_things''                                   
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:57:02 PM                 
   ------------------------------------------------------------ */

@parent_oid  uniqueidentifier

AS
     
SELECT 

	 [oid],
	 [class_oid],
	 [parent_oid]

FROM
 
	[tbl_things]

WHERE 

	[parent_oid] = @parent_oid

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_things_update]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_things_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_things_update    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_things_update]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_things_update                                      
   
   DESCRIPTION:  Updates a record in table ''tbl_things''                                     
   
   AUTHOR:       Christopher Rhodes 6/1/2001 3:56:38 PM                 
   ------------------------------------------------------------ */

@oid                               uniqueidentifier,
@class_oid                         uniqueidentifier,
@parent_oid                        uniqueidentifier  = NULL

AS 

UPDATE
	[tbl_things]
SET 
	[class_oid] = @class_oid,
	[parent_oid] = @parent_oid
WHERE 
	[oid] = @oid

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_empty_classes_and_things]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_empty_classes_and_things]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE  PROCEDURE [dbo].[up_empty_classes_and_things] AS
delete tbl_attributes
delete tbl_class_attributes
delete tbl_classes
delete tbl_thing_attributes
delete tbl_thing_attributes2
delete tbl_things
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_tables_delete]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_tables_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_tables_delete    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_tables_delete]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_tables_delete                                      
   
   DESCRIPTION:  Deletes a record from table ''tbl_tables''                                   
   
   AUTHOR:       Christopher Rhodes 6/2/2001 10:27:20 AM                
   ------------------------------------------------------------ */

@id integer

AS

DELETE

FROM

	[tbl_tables]

WHERE 

	[id] = @id

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END

RETURN @@ERROR


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_tables_insert]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_tables_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_tables_insert    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_tables_insert]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_tables_insert                                      
   
   DESCRIPTION:  Inserts a record into table ''tbl_tables''                                   
   
   AUTHOR:       Christopher Rhodes 6/2/2001 10:27:20 AM                
   ------------------------------------------------------------ */

@id            int,
@table_name    nvarchar(50),
@version       int,
@description   nchar(256) = NULL

AS

INSERT INTO
	[tbl_tables]

(
	[id],
	[table_name],
	[version],
	[description]
)

VALUES
(
	@id,
	@table_name,
	@version,
	@description
)

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_tables_select_all]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_tables_select_all]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_tables_select_all    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_tables_select_all]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_tables_select_all                                      
   
   DESCRIPTION:  Selects a record from table ''tbl_tables''                                   
   
   AUTHOR:       Christopher Rhodes 6/2/2001 10:27:20 AM                
   ------------------------------------------------------------ */

AS SELECT 

	 [id],
	 [table_name],
	 [version],
	 [description]

FROM
	[tbl_tables]

RETURN @@ERROR


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_tables_select_by_ID]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_tables_select_by_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_tables_select_by_ID    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_tables_select_by_ID]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_tables_select_by_ID                                      
   
   DESCRIPTION:  Selects a record from table ''tbl_tables''                                   
   
   AUTHOR:       Christopher Rhodes 6/2/2001 10:27:20 AM                
   ------------------------------------------------------------ */

@id int

AS

SELECT 
	[id],
	[table_name],
	[version],
	[description]

FROM
	[tbl_tables]

WHERE 
	[id] = @id

RETURN @@ERROR
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_tables_select_by_name]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_tables_select_by_name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_tables_select_by_name    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_tables_select_by_name]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_tables_select_by_name                                      
   
   DESCRIPTION:  Selects a record from table ''tbl_tables''                                   
   
   AUTHOR:       Christopher Rhodes 6/2/2001 10:27:20 AM                
   ------------------------------------------------------------ */

@table_name nvarchar(50)

AS

SELECT 

	[id],
	[table_name],
	[version],
	[description]

FROM
	[tbl_tables]

WHERE 

	[table_name] = @table_name

RETURN @@ERROR


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_tbl_tables_update]    Script Date: 12/17/2005 15:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_tbl_tables_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  Stored Procedure dbo.up_tbl_tables_update    Script Date: 9/22/2004 2:17:50 PM ******/
CREATE PROCEDURE [dbo].[up_tbl_tables_update]

/* ------------------------------------------------------------
   PROCEDURE:    up_tbl_tables_update                                      
   
   DESCRIPTION:  Updates a record in table ''tbl_tables''                                     
   
   AUTHOR:       Christopher Rhodes 6/2/2001 10:27:20 AM                
   ------------------------------------------------------------ */

@id            int,
@table_name    nvarchar(50),
@version       int,
@description   nchar(256)  = NULL

AS 

UPDATE
	[tbl_tables]

SET 

	[table_name] = @table_name,
	[version] = @version,
	[description] = @description

WHERE 

	[id] = @id

IF @@ROWCOUNT = 0
BEGIN
	 RAISERROR (''No Rows affected'', 16, 1)
END
RETURN @@ERROR


' 
END
