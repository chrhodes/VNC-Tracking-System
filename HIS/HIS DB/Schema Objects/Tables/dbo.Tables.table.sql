CREATE TABLE [dbo].[Tables] (
    [table_id]      INT            NOT NULL,
    [name]			VARCHAR (50)   NOT NULL,
    [version]		INT            NOT NULL,
    [description]	VARCHAR (1024) NULL,
    [last_changed]  DATETIME       NOT NULL
);

