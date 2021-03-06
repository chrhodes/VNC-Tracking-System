USE [ODB]
GO
/**************************************
 T a b l e s

 ODB Database Schema v1.0
 **************************************/

/****** Object:  Table [dbo].[ActivityLog]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ActivityLog]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ActivityLog](
    [activitylog_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_ActivityLog_activitylog_id]  DEFAULT (newid()),
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
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[AttributeValues]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[AttributeValues]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AttributeValues](
    [attributevalue_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_AttributeValues_attribute_value_id]  DEFAULT (newid()),
    [table_id] [int] NULL,
    [item_id] [uniqueidentifier] NOT NULL,
    [itemtypeattribute_id] [uniqueidentifier] NOT NULL,
    [value] [varchar](2048) NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AttributeValues] PRIMARY KEY CLUSTERED 
(
    [attributevalue_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Associations]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Associations]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Associations](
    [association_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_Associations_association_id]  DEFAULT (newid()),
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
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[AssociationRules]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[AssociationRules]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssociationRules](
    [associationrule_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_AccociationRules_associationrule_id]  DEFAULT (newid()),
    [table_id_begin] [int] NOT NULL,
	[table_id_end][int] NOT NULL,
	[itemtype_id_begin][uniqueidentifier] NOT NULL,
	[itemtype_id_end][uniqueidentifier] NOT NULL,
	[associationtype_id][int] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AssociationRules] PRIMARY KEY CLUSTERED 
(
    [associationrule_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[AssociationTypes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[AssociationTypes]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssociationTypes](
    [associationtype_id] [int]  NOT NULL,
    [associationtype_name] [varchar](50) NOT NULL,
    [associationtype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AssociationTypes] PRIMARY KEY CLUSTERED 
(
    [associationtype_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Attributes]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Attributes]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Attributes](
    [attribute_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_Attributes_attribute_id]  DEFAULT (newid()),
    [attribute_name] [varchar](50) NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
    [attribute_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO


/****** Object:  Table [dbo].[ConstrainedValues]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ConstrainedValues]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
BEGIN
   CREATE TABLE [dbo].[ConstrainedValues](
    [constrainedvalue_id] [uniqueidentifier] NOT NULL,
    [constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
    [constrainedvalue_value] [VARCHAR](50) NOT NULL,
	[constrainedvalue_ordinal] [int] NULL,
	[constrainedvalue_description][VARCHAR](1024),
	[last_changed] [timestamp] NOT NULL,
   CONSTRAINT [PK_ConstrainedValues] PRIMARY KEY CLUSTERED 
(
    [constrainedvalue_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ConstrainedValueLists]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ConstrainedValueLists]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
BEGIN
   CREATE TABLE [dbo].[ConstrainedValueLists](
    [constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
    [constrainedvaluelist_name] [VARCHAR](50) NOT NULL,
	[constrainedvaluelist_description] [VARCHAR](1024) NULL,
	[constrainedvaluelist_nbritems][int] NULL,
	[constrainedvaluelist_datatype_id][int] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
   CONSTRAINT [PK_ConstrainedValueLists] PRIMARY KEY CLUSTERED 
(
    [constrainedvaluelist_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[DataTypes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[DataTypes]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataTypes](
    [datatype_id] [int] NOT NULL,
    [datatype_name] [VARCHAR](50) NOT NULL,
    [datatype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_DataTypes] PRIMARY KEY CLUSTERED 
(
    [datatype_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Items]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Items]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Items](
    [item_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_Items_item_id]  DEFAULT (newid()),
	[item_name][varchar](256) NOT NULL,
    [itemtype_id] [uniqueidentifier] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
    [item_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ItemTypeAttributes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ItemTypeAttributes]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypeAttributes](
    [itemtypeattribute_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id]  DEFAULT (newid()),
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
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO 

/****** Object:  Table [dbo].[ItemTypeGroups]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ItemTypeGroups]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypeGroups](
    [itemtypegroup_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id]  DEFAULT (newid()),
    [itemtypegroup_name] [varchar](50) NOT NULL,
    [itemtypegroup_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ItemTypeGroups] PRIMARY KEY CLUSTERED 
(
    [itemtypegroup_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ItemTypes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ItemTypes]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypes](
    [itemtype_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_ItemTypes_itemtype_id]  DEFAULT (newid()),
    [itemtype_name] [varchar](50) NOT NULL,
    [itemtypegroup_id] [uniqueidentifier] NULL,
    [itemtype_version] [int] NULL,
    [itemtype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
(
    [itemtype_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[LogFunctions]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[LogFunctions]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Tables]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Tables]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[UsageAttributes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[UsageAttributes]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/**************************************
 E n d
 **************************************/

