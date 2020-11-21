ALTER TABLE [dbo].[ActivityLog]
    ADD CONSTRAINT [DF_ActivityLog_activitylog_id] DEFAULT (newid()) FOR [activitylog_id];

