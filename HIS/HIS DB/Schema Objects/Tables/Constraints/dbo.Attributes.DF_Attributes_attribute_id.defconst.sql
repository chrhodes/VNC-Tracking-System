ALTER TABLE [dbo].[Attributes]
    ADD CONSTRAINT [DF_Attributes_attribute_id] DEFAULT (newid()) FOR [attribute_id];

