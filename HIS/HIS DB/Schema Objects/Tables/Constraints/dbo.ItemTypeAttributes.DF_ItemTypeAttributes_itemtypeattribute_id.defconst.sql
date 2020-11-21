ALTER TABLE [dbo].[ItemTypeAttributes]
    ADD CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id] DEFAULT (newid()) FOR [itemtypeattribute_id];

