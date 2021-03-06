USE [ODB]
GO
/****** Object:  Table [dbo].[AssociationRules]    Script Date: 08/19/2011 23:57:19 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AccociationRules_associationrule_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssociationRules]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AccociationRules_associationrule_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssociationRules] DROP CONSTRAINT [DF_AccociationRules_associationrule_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
DROP TABLE [dbo].[AssociationRules]
GO
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
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AccociationRules_associationrule_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssociationRules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AccociationRules_associationrule_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssociationRules] ADD  CONSTRAINT [DF_AccociationRules_associationrule_id]  DEFAULT (newid()) FOR [associationrule_id]
END


End
GO
