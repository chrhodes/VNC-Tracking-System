USE [ODB]
GO
/****** Object:  Table [dbo].[ConstrainedValues]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
DROP TABLE [dbo].[ConstrainedValues]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ConstrainedValues](
	[constrainedvalue_id] [uniqueidentifier] NOT NULL,
	[constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
	[constrainedvalue_value] [varchar](50) NOT NULL,
	[constrainedvalue_ordinal] [int] NULL,
	[constrainedvalue_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ConstrainedValues] PRIMARY KEY CLUSTERED 
(
	[constrainedvalue_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
