CREATE TABLE [dbo].[Items] (
    [item_id]		UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [type_id]		UNIQUEIDENTIFIER NOT NULL,
    [name]			VARCHAR (256)    NOT NULL,
    [last_changed]	DATETIME         NOT NULL
);

