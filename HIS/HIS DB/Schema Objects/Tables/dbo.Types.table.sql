CREATE TABLE [dbo].[Types] (
    [type_id]			UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [name]				VARCHAR (50)     NOT NULL,
	[characteristics]	INT			NULL,
    [version]			INT              NULL,
    [description]		VARCHAR (1024)   NULL,
    [last_changed]		DATETIME         NOT NULL
);

