USE [ODB]
GO
/****** Object:  Table [dbo].[LogFunctions]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions]') AND type in (N'U'))
DROP TABLE [dbo].[LogFunctions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogFunctions](
	[logfunction_id] [int] NOT NULL,
	[logfunction_name] [varchar](50) NOT NULL,
	[logfunction_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_LogFunctions] PRIMARY KEY CLUSTERED 
(
	[logfunction_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
