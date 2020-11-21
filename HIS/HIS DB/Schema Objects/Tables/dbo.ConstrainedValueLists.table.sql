CREATE TABLE [dbo].[ConstrainedValueLists] (
    [constrainedvaluelist_id]       UNIQUEIDENTIFIER NOT NULL,
    [datatype_id]					INT              NOT NULL,
    [name]							VARCHAR (50)     NOT NULL,
    [description]					VARCHAR (1024)   NULL,
    [nbritems]						INT              NULL,
    [last_changed]                  DATETIME         NOT NULL
);

