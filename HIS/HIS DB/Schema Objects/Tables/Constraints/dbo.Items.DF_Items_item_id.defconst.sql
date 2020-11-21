ALTER TABLE [dbo].[Items]
    ADD CONSTRAINT [DF_Items_item_id] DEFAULT (newid()) FOR [item_id];

