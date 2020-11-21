CREATE TABLE [dbo].[AttributeValues] (
    [attributevalue_id]		UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [table_id]				INT              NULL,
    [item_id]				UNIQUEIDENTIFIER NOT NULL,
    [typeattribute_id]		UNIQUEIDENTIFIER NOT NULL,
    [value]					VARCHAR (2048)   NOT NULL,
    [last_changed]			DATETIME         NOT NULL
);

