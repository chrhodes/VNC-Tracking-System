CREATE TABLE [dbo].[TypeAttributes] (
    [typeattribute_id]      UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [type_id]               UNIQUEIDENTIFIER NOT NULL,
    [attribute_id]			UNIQUEIDENTIFIER NOT NULL,
    [characteristics]       INT              NULL,
    [datatype_id]           INT              NULL,
    [version]				INT              NULL,
    [description]			VARCHAR (1024)   NULL,
    [last_changed]          DATETIME         NOT NULL
);

