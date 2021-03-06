USE [ODB]
GO
/****** Object:  Table [dbo].[ItemTypeGroups]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeGroups_itemtypegroup_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeGroups_itemtypegroup_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeGroups] DROP CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypeGroups]
GO
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
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeGroups_itemtypegroup_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeGroups_itemtypegroup_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeGroups] ADD  CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id]  DEFAULT (newid()) FOR [itemtypegroup_id]
END


End
GO
