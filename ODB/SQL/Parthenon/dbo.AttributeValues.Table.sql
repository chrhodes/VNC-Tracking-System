USE [ODB]
GO
/****** Object:  Table [dbo].[AttributeValues]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttributeValues_attribute_value_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AttributeValues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AttributeValues_attribute_value_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttributeValues] DROP CONSTRAINT [DF_AttributeValues_attribute_value_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
DROP TABLE [dbo].[AttributeValues]
GO
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
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttributeValues_attribute_value_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AttributeValues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AttributeValues_attribute_value_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttributeValues] ADD  CONSTRAINT [DF_AttributeValues_attribute_value_id]  DEFAULT (newid()) FOR [attributevalue_id]
END


End
GO
