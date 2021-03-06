USE [ODB]
GO
/****** Object:  Table [dbo].[Associations]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Associations_association_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Associations]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Associations_association_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Associations] DROP CONSTRAINT [DF_Associations_association_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
DROP TABLE [dbo].[Associations]
GO
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
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Associations_association_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Associations]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Associations_association_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Associations] ADD  CONSTRAINT [DF_Associations_association_id]  DEFAULT (newid()) FOR [association_id]
END


End
GO
