/**************************************
 D r o p    T a b l e s

 ODB Database Schema: v0.9
 **************************************/
USE [ODB]

/* ToDo: Change this to just delete all user tables */

/****** Object:  Table [dbo].[ActivityLog]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ActivityLog]
END
GO

/****** Object:  Table [dbo].[Artifacts]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Artifacts]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Artifacts]
END
GO

/****** Object:  Table [dbo].[Associations]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Associations]
END
GO

/****** Object:  Table [dbo].[AssociationRules]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[AssociationRules]
END
GO

/****** Object:  Table [dbo].[AssociationTypes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[AssociationTypes]
END
GO

/****** Object:  Table [dbo].[Attributes]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Attributes]
END
GO

/****** Object:  Table [dbo].[AttributeValues]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[AttributeValues]
END
GO

/****** Object:  Table [dbo].[ConstrainedValueLists]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ConstrainedValueLists]
END
GO

/****** Object:  Table [dbo].[ConstrainedValues]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ConstrainedValues]
END
GO

/****** Object:  Table [dbo].[DataTypes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[DataTypes]
END
GO

/****** Object:  Table [dbo].[ItemTypeAttributes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ItemTypeAttributes]
END
GO

/****** Object:  Table [dbo].[ItemTypeGroups]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ItemTypeGroups]
END
GO 


/****** Object:  Table [dbo].[Items]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Items]
END
GO

/****** Object:  Table [dbo].[LogFunctions]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[LogFunctions]
END
GO

/****** Object:  Table [dbo].[Tables]    Script Date: 12/17/2005 15:04:14 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Tables]
END
GO

/****** Object:  Table [dbo].[ItemTypes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ItemTypes]
END
GO

/****** Object:  Table [dbo].[UsageAttributes]    Script Date: 12/17/2005 15:04:13 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[UsageAttributes]
END
GO

