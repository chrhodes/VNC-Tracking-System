USE [ODB]
GO
/****** Object:  Table [dbo].[DataTypes]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
DROP TABLE [dbo].[DataTypes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataTypes](
	[datatype_id] [int] NOT NULL,
	[datatype_name] [varchar](50) NOT NULL,
	[datatype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_DataTypes] PRIMARY KEY CLUSTERED 
(
	[datatype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
