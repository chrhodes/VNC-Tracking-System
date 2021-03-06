USE [ODB]
GO
/****** Object:  Table [dbo].[ConstrainedValueLists]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
DROP TABLE [dbo].[ConstrainedValueLists]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ConstrainedValueLists](
	[constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
	[constrainedvaluelist_name] [varchar](50) NOT NULL,
	[constrainedvaluelist_description] [varchar](1024) NULL,
	[constrainedvaluelist_nbritems] [int] NULL,
	[constrainedvaluelist_datatype_id] [int] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ConstrainedValueLists] PRIMARY KEY CLUSTERED 
(
	[constrainedvaluelist_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
