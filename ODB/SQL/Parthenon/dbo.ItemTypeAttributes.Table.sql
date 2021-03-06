USE [ODB]
GO
/****** Object:  Table [dbo].[ItemTypeAttributes]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeAttributes_itemtypeattribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeAttributes_itemtypeattribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeAttributes] DROP CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypeAttributes]
GO
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
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeAttributes_itemtypeattribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeAttributes_itemtypeattribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeAttributes] ADD  CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id]  DEFAULT (newid()) FOR [itemtypeattribute_id]
END


End
GO
