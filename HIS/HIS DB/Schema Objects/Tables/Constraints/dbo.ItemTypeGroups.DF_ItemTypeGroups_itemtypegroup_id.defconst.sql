ALTER TABLE [dbo].[ItemTypeGroups]
    ADD CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id] DEFAULT (newid()) FOR [itemtypegroup_id];

