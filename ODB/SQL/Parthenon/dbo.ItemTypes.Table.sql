USE [ODB]
GO
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypes_itemtype_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypes_itemtype_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypes] DROP CONSTRAINT [DF_ItemTypes_itemtype_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypes]
GO
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
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypes_itemtype_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypes_itemtype_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypes] ADD  CONSTRAINT [DF_ItemTypes_itemtype_id]  DEFAULT (newid()) FOR [itemtype_id]
END


End
GO
