CREATE TABLE [dbo].[Attributes] (
    [attribute_id]	UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [name]			VARCHAR (50)     NOT NULL,
    [last_changed]  DATETIME         NOT NULL
);

