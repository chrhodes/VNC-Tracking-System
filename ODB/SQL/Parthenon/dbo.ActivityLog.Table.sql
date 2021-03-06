USE [ODB]
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 08/19/2011 23:57:18 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActivityLog_activitylog_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ActivityLog]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ActivityLog_activitylog_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ActivityLog] DROP CONSTRAINT [DF_ActivityLog_activitylog_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
DROP TABLE [dbo].[ActivityLog]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ActivityLog](
	[activitylog_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id] [int] NOT NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[logfunction_id] [int] NOT NULL,
	[value] [varchar](2048) NULL,
	[who] [varchar](50) NOT NULL,
	[when] [datetime] NOT NULL,
	[notes] [varchar](1024) NULL,
 CONSTRAINT [PK_ActivityLog] PRIMARY KEY CLUSTERED 
(
	[activitylog_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActivityLog_activitylog_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ActivityLog]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ActivityLog_activitylog_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ActivityLog] ADD  CONSTRAINT [DF_ActivityLog_activitylog_id]  DEFAULT (newid()) FOR [activitylog_id]
END


End
GO
