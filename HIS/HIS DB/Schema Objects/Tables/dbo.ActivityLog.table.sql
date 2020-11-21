CREATE TABLE [dbo].[ActivityLog] (
    [activitylog_id] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [logfunction_id] INT              NOT NULL,
    [table_id]       INT              NOT NULL,
    [item_id]        VARCHAR (128)	  NOT NULL,
    [value]          VARCHAR (2048)   NULL,
    [who]            VARCHAR (50)     NOT NULL,
    [when]           DATETIME         NOT NULL,
    [notes]          VARCHAR (1024)   NULL
);

