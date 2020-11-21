ALTER TABLE [dbo].[AssociationRules]
    ADD CONSTRAINT [DF_AccociationRules_associationrule_id] DEFAULT (newid()) FOR [associationrule_id];

