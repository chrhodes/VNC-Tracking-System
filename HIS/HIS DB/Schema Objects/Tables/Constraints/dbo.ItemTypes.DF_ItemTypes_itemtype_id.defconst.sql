ALTER TABLE [dbo].[ItemTypes]
    ADD CONSTRAINT [DF_ItemTypes_itemtype_id] DEFAULT (newid()) FOR [itemtype_id];

