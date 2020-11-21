ALTER TABLE [dbo].[AttributeValues]
    ADD CONSTRAINT [DF_AttributeValues_attribute_value_id] DEFAULT (newid()) FOR [attributevalue_id];

