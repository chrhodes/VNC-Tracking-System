ALTER TABLE [dbo].[Associations]
    ADD CONSTRAINT [DF_Associations_association_id] DEFAULT (newid()) FOR [association_id];

