CREATE TABLE [dbo].[ConstrainedValues] (
    [constrainedvalue_id]			UNIQUEIDENTIFIER NOT NULL,
    [constrainedvaluelist_id]		UNIQUEIDENTIFIER NOT NULL,
    [value]							VARCHAR (50)     NOT NULL,
    [description]					VARCHAR (1024)   NULL,
    [ordinal]						INT              NULL,
    [last_changed]					DATETIME         NOT NULL
);

