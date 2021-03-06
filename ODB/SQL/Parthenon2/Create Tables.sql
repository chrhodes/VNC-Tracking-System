USE [ODB]
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActivityLog_activitylog_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ActivityLog]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ActivityLog_activitylog_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ActivityLog] DROP CONSTRAINT [DF_ActivityLog_activitylog_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AccociationRules_associationrule_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssociationRules]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AccociationRules_associationrule_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssociationRules] DROP CONSTRAINT [DF_AccociationRules_associationrule_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Associations_association_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Associations]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Associations_association_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Associations] DROP CONSTRAINT [DF_Associations_association_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_attribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Attributes_attribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] DROP CONSTRAINT [DF_Attributes_attribute_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttributeValues_attribute_value_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AttributeValues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AttributeValues_attribute_value_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttributeValues] DROP CONSTRAINT [DF_AttributeValues_attribute_value_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Items_item_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Items]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Items_item_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Items] DROP CONSTRAINT [DF_Items_item_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeAttributes_itemtypeattribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeAttributes_itemtypeattribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeAttributes] DROP CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeGroups_itemtypegroup_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeGroups_itemtypegroup_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeGroups] DROP CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypes_itemtype_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypes_itemtype_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypes] DROP CONSTRAINT [DF_ItemTypes_itemtype_id]
END


End
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 08/20/2011 00:08:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
DROP TABLE [dbo].[ActivityLog]
GO
/****** Object:  Table [dbo].[AssociationRules]    Script Date: 08/20/2011 00:08:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
DROP TABLE [dbo].[AssociationRules]
GO
/****** Object:  Table [dbo].[Associations]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
DROP TABLE [dbo].[Associations]
GO
/****** Object:  Table [dbo].[AssociationTypes]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
DROP TABLE [dbo].[AssociationTypes]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
DROP TABLE [dbo].[Attributes]
GO
/****** Object:  Table [dbo].[AttributeValues]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
DROP TABLE [dbo].[AttributeValues]
GO
/****** Object:  Table [dbo].[ConstrainedValueLists]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
DROP TABLE [dbo].[ConstrainedValueLists]
GO
/****** Object:  Table [dbo].[ConstrainedValues]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
DROP TABLE [dbo].[ConstrainedValues]
GO
/****** Object:  Table [dbo].[DataTypes]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
DROP TABLE [dbo].[DataTypes]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
DROP TABLE [dbo].[Items]
GO
/****** Object:  Table [dbo].[ItemTypeAttributes]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypeAttributes]
GO
/****** Object:  Table [dbo].[ItemTypeGroups]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypeGroups]
GO
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypes]
GO
/****** Object:  Table [dbo].[LogFunctions]    Script Date: 08/20/2011 00:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions]') AND type in (N'U'))
DROP TABLE [dbo].[LogFunctions]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
DROP TABLE [dbo].[Tables]
GO
/****** Object:  Table [dbo].[UsageAttributes]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes]') AND type in (N'U'))
DROP TABLE [dbo].[UsageAttributes]
GO
USE [master]
GO
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyEventProcessingLogin##')
DROP LOGIN [##MS_PolicyEventProcessingLogin##]
GO
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyTsqlExecutionLogin##')
DROP LOGIN [##MS_PolicyTsqlExecutionLogin##]
GO
/****** Object:  Login [NT AUTHORITY\NETWORK SERVICE]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE')
DROP LOGIN [NT AUTHORITY\NETWORK SERVICE]
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
DROP LOGIN [NT AUTHORITY\SYSTEM]
GO
/****** Object:  Login [NT SERVICE\MSSQLSERVER]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\MSSQLSERVER')
DROP LOGIN [NT SERVICE\MSSQLSERVER]
GO
/****** Object:  Login [NT SERVICE\SQLSERVERAGENT]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\SQLSERVERAGENT')
DROP LOGIN [NT SERVICE\SQLSERVERAGENT]
GO
/****** Object:  Login [VNC\Administrator]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Administrator')
DROP LOGIN [VNC\Administrator]
GO
/****** Object:  Login [VNC\Domain Admins]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Domain Admins')
DROP LOGIN [VNC\Domain Admins]
GO
/****** Object:  Login [VNC\PARTHENON$]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\PARTHENON$')
DROP LOGIN [VNC\PARTHENON$]
GO
/****** Object:  Login [VNC\TFSReportReader]    Script Date: 08/20/2011 00:08:41 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\TFSReportReader')
DROP LOGIN [VNC\TFSReportReader]
GO
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 08/20/2011 00:08:41 ******/
/* For security reasons the login is created disabled and with a random password. */
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyEventProcessingLogin##')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=N'{ü äÜ¢rNýCÙ?|ÉFZFÕ÷·ç"Ö<~', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] DISABLE
GO
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 08/20/2011 00:08:41 ******/
/* For security reasons the login is created disabled and with a random password. */
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyTsqlExecutionLogin##')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=N'ÑN!''IN\QÚµUZi°û0ù©|Èö-nù¤', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] DISABLE
GO
/****** Object:  Login [NT AUTHORITY\NETWORK SERVICE]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE')
CREATE LOGIN [NT AUTHORITY\NETWORK SERVICE] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\MSSQLSERVER]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\MSSQLSERVER')
CREATE LOGIN [NT SERVICE\MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\SQLSERVERAGENT]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\SQLSERVERAGENT')
CREATE LOGIN [NT SERVICE\SQLSERVERAGENT] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\Administrator]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Administrator')
CREATE LOGIN [VNC\Administrator] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\Domain Admins]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Domain Admins')
CREATE LOGIN [VNC\Domain Admins] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\PARTHENON$]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\PARTHENON$')
CREATE LOGIN [VNC\PARTHENON$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\TFSReportReader]    Script Date: 08/20/2011 00:08:41 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\TFSReportReader')
CREATE LOGIN [VNC\TFSReportReader] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
USE [ODB]
GO
/****** Object:  Table [dbo].[UsageAttributes]    Script Date: 08/20/2011 00:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UsageAttributes](
	[usageattribute_id] [int] NOT NULL,
	[usageattribute_name] [varchar](50) NOT NULL,
	[usageattribute_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_UsageAttributes] PRIMARY KEY CLUSTERED 
(
	[usageattribute_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 08/20/2011 00:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tables](
	[table_id] [int] NOT NULL,
	[table_name] [varchar](50) NOT NULL,
	[table_version] [int] NOT NULL,
	[table_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[table_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogFunctions]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogFunctions](
	[logfunction_id] [int] NOT NULL,
	[logfunction_name] [varchar](50) NOT NULL,
	[logfunction_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_LogFunctions] PRIMARY KEY CLUSTERED 
(
	[logfunction_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypes](
	[itemtype_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[itemtype_name] [varchar](50) NOT NULL,
	[itemtypegroup_id] [uniqueidentifier] NULL,
	[itemtype_version] [int] NULL,
	[itemtype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
(
	[itemtype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemTypeGroups]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypeGroups](
	[itemtypegroup_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[itemtypegroup_name] [varchar](50) NOT NULL,
	[itemtypegroup_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ItemTypeGroups] PRIMARY KEY CLUSTERED 
(
	[itemtypegroup_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemTypeAttributes]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypeAttributes](
	[itemtypeattribute_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[itemtype_id] [uniqueidentifier] NOT NULL,
	[attribute_id] [uniqueidentifier] NOT NULL,
	[usage_attributes] [int] NULL,
	[datatype_id] [int] NULL,
	[itemtypeattribute_version] [int] NULL,
	[itemtypeattribute_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ItemTypeAttributes] PRIMARY KEY CLUSTERED 
(
	[itemtypeattribute_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Items]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Items](
	[item_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[item_name] [varchar](256) NOT NULL,
	[itemtype_id] [uniqueidentifier] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DataTypes]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataTypes](
	[datatype_id] [int] NOT NULL,
	[datatype_name] [varchar](50) NOT NULL,
	[datatype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_DataTypes] PRIMARY KEY CLUSTERED 
(
	[datatype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConstrainedValues]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ConstrainedValues](
	[constrainedvalue_id] [uniqueidentifier] NOT NULL,
	[constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
	[constrainedvalue_value] [varchar](50) NOT NULL,
	[constrainedvalue_ordinal] [int] NULL,
	[constrainedvalue_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ConstrainedValues] PRIMARY KEY CLUSTERED 
(
	[constrainedvalue_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConstrainedValueLists]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ConstrainedValueLists](
	[constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
	[constrainedvaluelist_name] [varchar](50) NOT NULL,
	[constrainedvaluelist_description] [varchar](1024) NULL,
	[constrainedvaluelist_nbritems] [int] NULL,
	[constrainedvaluelist_datatype_id] [int] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ConstrainedValueLists] PRIMARY KEY CLUSTERED 
(
	[constrainedvaluelist_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AttributeValues]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AttributeValues](
	[attributevalue_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id] [int] NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[itemtypeattribute_id] [uniqueidentifier] NOT NULL,
	[value] [varchar](2048) NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AttributeValues] PRIMARY KEY CLUSTERED 
(
	[attributevalue_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Attributes](
	[attribute_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[attribute_name] [varchar](50) NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[attribute_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssociationTypes]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssociationTypes](
	[associationtype_id] [int] NOT NULL,
	[associationtype_name] [varchar](50) NOT NULL,
	[associationtype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AssociationTypes] PRIMARY KEY CLUSTERED 
(
	[associationtype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Associations]    Script Date: 08/20/2011 00:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Associations](
	[association_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id_begin] [int] NOT NULL,
	[item_id_begin] [uniqueidentifier] NOT NULL,
	[table_id_end] [int] NOT NULL,
	[item_id_end] [uniqueidentifier] NOT NULL,
	[associationrule_id] [uniqueidentifier] NOT NULL,
	[itemtypegroup_id] [uniqueidentifier] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Associations] PRIMARY KEY CLUSTERED 
(
	[association_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AssociationRules]    Script Date: 08/20/2011 00:08:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssociationRules](
	[associationrule_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id_begin] [int] NOT NULL,
	[table_id_end] [int] NOT NULL,
	[itemtype_id_begin] [uniqueidentifier] NOT NULL,
	[itemtype_id_end] [uniqueidentifier] NOT NULL,
	[associationtype_id] [int] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AssociationRules] PRIMARY KEY CLUSTERED 
(
	[associationrule_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 08/20/2011 00:08:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ActivityLog](
	[activitylog_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id] [int] NOT NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[logfunction_id] [int] NOT NULL,
	[value] [varchar](2048) NULL,
	[who] [varchar](50) NOT NULL,
	[when] [datetime] NOT NULL,
	[notes] [varchar](1024) NULL,
 CONSTRAINT [PK_ActivityLog] PRIMARY KEY CLUSTERED 
(
	[activitylog_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF_ActivityLog_activitylog_id]    Script Date: 08/20/2011 00:08:39 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActivityLog_activitylog_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ActivityLog]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ActivityLog_activitylog_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ActivityLog] ADD  CONSTRAINT [DF_ActivityLog_activitylog_id]  DEFAULT (newid()) FOR [activitylog_id]
END


End
GO
/****** Object:  Default [DF_AccociationRules_associationrule_id]    Script Date: 08/20/2011 00:08:39 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AccociationRules_associationrule_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssociationRules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AccociationRules_associationrule_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssociationRules] ADD  CONSTRAINT [DF_AccociationRules_associationrule_id]  DEFAULT (newid()) FOR [associationrule_id]
END


End
GO
/****** Object:  Default [DF_Associations_association_id]    Script Date: 08/20/2011 00:08:40 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Associations_association_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Associations]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Associations_association_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Associations] ADD  CONSTRAINT [DF_Associations_association_id]  DEFAULT (newid()) FOR [association_id]
END


End
GO
/****** Object:  Default [DF_Attributes_attribute_id]    Script Date: 08/20/2011 00:08:40 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_attribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Attributes_attribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_attribute_id]  DEFAULT (newid()) FOR [attribute_id]
END


End
GO
/****** Object:  Default [DF_AttributeValues_attribute_value_id]    Script Date: 08/20/2011 00:08:40 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttributeValues_attribute_value_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AttributeValues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AttributeValues_attribute_value_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttributeValues] ADD  CONSTRAINT [DF_AttributeValues_attribute_value_id]  DEFAULT (newid()) FOR [attributevalue_id]
END


End
GO
/****** Object:  Default [DF_Items_item_id]    Script Date: 08/20/2011 00:08:40 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Items_item_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Items]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Items_item_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_item_id]  DEFAULT (newid()) FOR [item_id]
END


End
GO
/****** Object:  Default [DF_ItemTypeAttributes_itemtypeattribute_id]    Script Date: 08/20/2011 00:08:40 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeAttributes_itemtypeattribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeAttributes_itemtypeattribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeAttributes] ADD  CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id]  DEFAULT (newid()) FOR [itemtypeattribute_id]
END


End
GO
/****** Object:  Default [DF_ItemTypeGroups_itemtypegroup_id]    Script Date: 08/20/2011 00:08:40 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeGroups_itemtypegroup_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeGroups_itemtypegroup_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeGroups] ADD  CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id]  DEFAULT (newid()) FOR [itemtypegroup_id]
END


End
GO
/****** Object:  Default [DF_ItemTypes_itemtype_id]    Script Date: 08/20/2011 00:08:40 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypes_itemtype_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypes_itemtype_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypes] ADD  CONSTRAINT [DF_ItemTypes_itemtype_id]  DEFAULT (newid()) FOR [itemtype_id]
END


End
GO
