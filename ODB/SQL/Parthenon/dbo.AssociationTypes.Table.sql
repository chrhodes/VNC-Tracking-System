USE [ODB]
GO
/****** Object:  Table [dbo].[AssociationTypes]    Script Date: 08/19/2011 23:57:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
DROP TABLE [dbo].[AssociationTypes]
GO
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
