USE [ODB]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_attribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Attributes_attribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] DROP CONSTRAINT [DF_Attributes_attribute_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
DROP TABLE [dbo].[Attributes]
GO
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
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_attribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Attributes_attribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_attribute_id]  DEFAULT (newid()) FOR [attribute_id]
END


End
GO
