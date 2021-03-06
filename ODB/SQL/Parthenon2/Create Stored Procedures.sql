USE [ODB]
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypes_itemtype_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypes_itemtype_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypes] DROP CONSTRAINT [DF_ItemTypes_itemtype_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeGroups_itemtypegroup_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeGroups_itemtypegroup_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeGroups] DROP CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeAttributes_itemtypeattribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeAttributes_itemtypeattribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeAttributes] DROP CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Items_item_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Items]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Items_item_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Items] DROP CONSTRAINT [DF_Items_item_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttributeValues_attribute_value_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AttributeValues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AttributeValues_attribute_value_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttributeValues] DROP CONSTRAINT [DF_AttributeValues_attribute_value_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Associations_association_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Associations]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Associations_association_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Associations] DROP CONSTRAINT [DF_Associations_association_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActivityLog_activitylog_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ActivityLog]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ActivityLog_activitylog_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ActivityLog] DROP CONSTRAINT [DF_ActivityLog_activitylog_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_attribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Attributes_attribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] DROP CONSTRAINT [DF_Attributes_attribute_id]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AccociationRules_associationrule_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssociationRules]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AccociationRules_associationrule_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssociationRules] DROP CONSTRAINT [DF_AccociationRules_associationrule_id]
END


End
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Delete]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Insert]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Update]
GO
/****** Object:  StoredProcedure [dbo].[Associations_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Update]
GO
/****** Object:  StoredProcedure [dbo].[Associations_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Delete]
GO
/****** Object:  StoredProcedure [dbo].[Associations_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Delete]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Update]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Update]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Delete]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Delete]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Update]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Update]
GO
/****** Object:  StoredProcedure [dbo].[Items_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Delete]
GO
/****** Object:  StoredProcedure [dbo].[Items_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Items_Update]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Update]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Delete]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Delete]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Insert]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Update]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Update]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Delete]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Delete]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Delete]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Insert]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Update]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Update]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Delete]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Delete]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Insert]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Update]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Update]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Delete]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Delete]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Insert]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Select]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Select]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Update]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Update]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Delete]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Delete]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Insert]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Select]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Select]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Update]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Update]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Select]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Select]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_SelectByItemTypeGroupId]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_SelectByItemTypeGroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_SelectByItemTypeGroupId]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Select]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Select]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Select]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Select]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Select]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_SelectByItemTypeId]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_SelectByItemTypeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_SelectByItemTypeId]
GO
/****** Object:  StoredProcedure [dbo].[Items_Select]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Select]
GO
/****** Object:  StoredProcedure [dbo].[Items_SelectByItemName]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_SelectByItemName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_SelectByItemName]
GO
/****** Object:  StoredProcedure [dbo].[Items_SelectByItemTypeId]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_SelectByItemTypeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_SelectByItemTypeId]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Select]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Select]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Delete]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Select]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Update]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Select]
GO
/****** Object:  StoredProcedure [dbo].[Associations_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Select]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Select]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Delete]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Delete]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Select]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Update]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Update]
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Select]    Script Date: 08/20/2011 00:10:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Select]
GO
/****** Object:  Table [dbo].[AssociationRules]    Script Date: 08/20/2011 00:10:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
DROP TABLE [dbo].[AssociationRules]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 08/20/2011 00:10:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
DROP TABLE [dbo].[Attributes]
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 08/20/2011 00:10:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
DROP TABLE [dbo].[ActivityLog]
GO
/****** Object:  Table [dbo].[Associations]    Script Date: 08/20/2011 00:10:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
DROP TABLE [dbo].[Associations]
GO
/****** Object:  Table [dbo].[AssociationTypes]    Script Date: 08/20/2011 00:10:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
DROP TABLE [dbo].[AssociationTypes]
GO
/****** Object:  Table [dbo].[ConstrainedValueLists]    Script Date: 08/20/2011 00:10:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
DROP TABLE [dbo].[ConstrainedValueLists]
GO
/****** Object:  Table [dbo].[AttributeValues]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
DROP TABLE [dbo].[AttributeValues]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
DROP TABLE [dbo].[Items]
GO
/****** Object:  Table [dbo].[ConstrainedValues]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
DROP TABLE [dbo].[ConstrainedValues]
GO
/****** Object:  Table [dbo].[DataTypes]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
DROP TABLE [dbo].[DataTypes]
GO
/****** Object:  Table [dbo].[ItemTypeAttributes]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypeAttributes]
GO
/****** Object:  Table [dbo].[ItemTypeGroups]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypeGroups]
GO
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
DROP TABLE [dbo].[ItemTypes]
GO
/****** Object:  Table [dbo].[UsageAttributes]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes]') AND type in (N'U'))
DROP TABLE [dbo].[UsageAttributes]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 08/20/2011 00:10:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
DROP TABLE [dbo].[Tables]
GO
USE [master]
GO
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyEventProcessingLogin##')
DROP LOGIN [##MS_PolicyEventProcessingLogin##]
GO
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyTsqlExecutionLogin##')
DROP LOGIN [##MS_PolicyTsqlExecutionLogin##]
GO
/****** Object:  Login [NT AUTHORITY\NETWORK SERVICE]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE')
DROP LOGIN [NT AUTHORITY\NETWORK SERVICE]
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
DROP LOGIN [NT AUTHORITY\SYSTEM]
GO
/****** Object:  Login [NT SERVICE\MSSQLSERVER]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\MSSQLSERVER')
DROP LOGIN [NT SERVICE\MSSQLSERVER]
GO
/****** Object:  Login [NT SERVICE\SQLSERVERAGENT]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\SQLSERVERAGENT')
DROP LOGIN [NT SERVICE\SQLSERVERAGENT]
GO
/****** Object:  Login [VNC\Administrator]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Administrator')
DROP LOGIN [VNC\Administrator]
GO
/****** Object:  Login [VNC\Domain Admins]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Domain Admins')
DROP LOGIN [VNC\Domain Admins]
GO
/****** Object:  Login [VNC\PARTHENON$]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\PARTHENON$')
DROP LOGIN [VNC\PARTHENON$]
GO
/****** Object:  Login [VNC\TFSReportReader]    Script Date: 08/20/2011 00:10:34 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\TFSReportReader')
DROP LOGIN [VNC\TFSReportReader]
GO
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 08/20/2011 00:10:34 ******/
/* For security reasons the login is created disabled and with a random password. */
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyEventProcessingLogin##')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=N'»®f]*&åd×¸¨ã°=¹Âç7	á®¦', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] DISABLE
GO
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 08/20/2011 00:10:34 ******/
/* For security reasons the login is created disabled and with a random password. */
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyTsqlExecutionLogin##')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=N'4?ÏV×\50Íä0hº9ÜyýjÎZÅ\z;Y!û9', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] DISABLE
GO
/****** Object:  Login [NT AUTHORITY\NETWORK SERVICE]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE')
CREATE LOGIN [NT AUTHORITY\NETWORK SERVICE] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\MSSQLSERVER]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\MSSQLSERVER')
CREATE LOGIN [NT SERVICE\MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\SQLSERVERAGENT]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\SQLSERVERAGENT')
CREATE LOGIN [NT SERVICE\SQLSERVERAGENT] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\Administrator]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Administrator')
CREATE LOGIN [VNC\Administrator] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\Domain Admins]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\Domain Admins')
CREATE LOGIN [VNC\Domain Admins] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\PARTHENON$]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\PARTHENON$')
CREATE LOGIN [VNC\PARTHENON$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [VNC\TFSReportReader]    Script Date: 08/20/2011 00:10:34 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VNC\TFSReportReader')
CREATE LOGIN [VNC\TFSReportReader] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
USE [ODB]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tables](
	[table_id] [int] NOT NULL,
	[table_name] [varchar](50) NOT NULL,
	[table_version] [int] NOT NULL,
	[table_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[table_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsageAttributes]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UsageAttributes](
	[usageattribute_id] [int] NOT NULL,
	[usageattribute_name] [varchar](50) NOT NULL,
	[usageattribute_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_UsageAttributes] PRIMARY KEY CLUSTERED 
(
	[usageattribute_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypes](
	[itemtype_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[itemtype_name] [varchar](50) NOT NULL,
	[itemtypegroup_id] [uniqueidentifier] NULL,
	[itemtype_version] [int] NULL,
	[itemtype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
(
	[itemtype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemTypeGroups]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypeGroups](
	[itemtypegroup_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[itemtypegroup_name] [varchar](50) NOT NULL,
	[itemtypegroup_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ItemTypeGroups] PRIMARY KEY CLUSTERED 
(
	[itemtypegroup_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemTypeAttributes]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTypeAttributes](
	[itemtypeattribute_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[itemtype_id] [uniqueidentifier] NOT NULL,
	[attribute_id] [uniqueidentifier] NOT NULL,
	[usage_attributes] [int] NULL,
	[datatype_id] [int] NULL,
	[itemtypeattribute_version] [int] NULL,
	[itemtypeattribute_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ItemTypeAttributes] PRIMARY KEY CLUSTERED 
(
	[itemtypeattribute_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DataTypes]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataTypes](
	[datatype_id] [int] NOT NULL,
	[datatype_name] [varchar](50) NOT NULL,
	[datatype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_DataTypes] PRIMARY KEY CLUSTERED 
(
	[datatype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConstrainedValues]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ConstrainedValues](
	[constrainedvalue_id] [uniqueidentifier] NOT NULL,
	[constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
	[constrainedvalue_value] [varchar](50) NOT NULL,
	[constrainedvalue_ordinal] [int] NULL,
	[constrainedvalue_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ConstrainedValues] PRIMARY KEY CLUSTERED 
(
	[constrainedvalue_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Items]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Items](
	[item_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[item_name] [varchar](256) NOT NULL,
	[itemtype_id] [uniqueidentifier] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AttributeValues]    Script Date: 08/20/2011 00:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AttributeValues](
	[attributevalue_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id] [int] NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[itemtypeattribute_id] [uniqueidentifier] NOT NULL,
	[value] [varchar](2048) NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AttributeValues] PRIMARY KEY CLUSTERED 
(
	[attributevalue_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConstrainedValueLists]    Script Date: 08/20/2011 00:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ConstrainedValueLists](
	[constrainedvaluelist_id] [uniqueidentifier] NOT NULL,
	[constrainedvaluelist_name] [varchar](50) NOT NULL,
	[constrainedvaluelist_description] [varchar](1024) NULL,
	[constrainedvaluelist_nbritems] [int] NULL,
	[constrainedvaluelist_datatype_id] [int] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_ConstrainedValueLists] PRIMARY KEY CLUSTERED 
(
	[constrainedvaluelist_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssociationTypes]    Script Date: 08/20/2011 00:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssociationTypes](
	[associationtype_id] [int] NOT NULL,
	[associationtype_name] [varchar](50) NOT NULL,
	[associationtype_description] [varchar](1024) NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AssociationTypes] PRIMARY KEY CLUSTERED 
(
	[associationtype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Associations]    Script Date: 08/20/2011 00:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Associations](
	[association_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id_begin] [int] NOT NULL,
	[item_id_begin] [uniqueidentifier] NOT NULL,
	[table_id_end] [int] NOT NULL,
	[item_id_end] [uniqueidentifier] NOT NULL,
	[associationrule_id] [uniqueidentifier] NOT NULL,
	[itemtypegroup_id] [uniqueidentifier] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Associations] PRIMARY KEY CLUSTERED 
(
	[association_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 08/20/2011 00:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ActivityLog](
	[activitylog_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id] [int] NOT NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[logfunction_id] [int] NOT NULL,
	[value] [varchar](2048) NULL,
	[who] [varchar](50) NOT NULL,
	[when] [datetime] NOT NULL,
	[notes] [varchar](1024) NULL,
 CONSTRAINT [PK_ActivityLog] PRIMARY KEY CLUSTERED 
(
	[activitylog_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 08/20/2011 00:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Attributes](
	[attribute_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[attribute_name] [varchar](50) NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[attribute_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssociationRules]    Script Date: 08/20/2011 00:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssociationRules](
	[associationrule_id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[table_id_begin] [int] NOT NULL,
	[table_id_end] [int] NOT NULL,
	[itemtype_id_begin] [uniqueidentifier] NOT NULL,
	[itemtype_id_end] [uniqueidentifier] NOT NULL,
	[associationtype_id] [int] NOT NULL,
	[last_changed] [timestamp] NOT NULL,
 CONSTRAINT [PK_AssociationRules] PRIMARY KEY CLUSTERED 
(
	[associationrule_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ActivityLog_Select]
AS
    SET NOCOUNT ON;

    SELECT 
        [activitylog_id],
        [table_id],
        [item_id],
        [logfunction_id],
        [value],
        [who],
        [when],
        [notes]
    FROM 
		[ActivityLog]
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ActivityLog_Insert] 
    @table_id int, 
    @item_id uniqueidentifier,
    @log_function_id int,
    @value varchar(2048),
    @who varchar(50),
    @notes varchar(1024)
AS
    -- SET NOCOUNT ON added to prevent extra result sets FROM
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO 
		[ActivityLog]
	VALUES 
    (
		newid(), 
		@table_id, 
		@item_id, 
		@log_function_id, 
		@value, 
		@who, 
		getDate(), 
		@notes
	)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationTypes_Update]
(
    @associationtype_id int,
    @associationtype_name varchar(50),
    @associationtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[AssociationTypes] 
	SET 
		[associationtype_id] = @associationtype_id, 
		[associationtype_name] = @associationtype_name, 
		[associationtype_description] = @associationtype_description 
	WHERE 
	(
		([associationtype_id] = @associationtype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--  EXEC ActivityLog_Insert 5, @associationtype_id, 2, @associationtype_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[associationtype_id], 
		[associationtype_name], 
		[associationtype_description] 
	FROM 
		AssociationTypes
	WHERE 
		(associationtype_id = @associationtype_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationTypes_Select]
AS
    SET NOCOUNT ON;

	SELECT
		associationtype_id, 
		associationtype_name, 
		associationtype_description
   FROM
		AssociationTypes
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationTypes_Insert]
(
    @associationtype_id int,
    @associationtype_name varchar(50),
    @associationtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AssociationTypes] 
	(
		[associationtype_id], 
		[associationtype_name], 
		[associationtype_description]
	)
	VALUES
	(	
		@associationtype_id, 
		@associationtype_name, 
		@associationtype_description);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 5, @associationtype_id, 1, @associationtype_name, @who, @note /* ToDo: Update constants for each table */  

    SELECT
		associationtype_id, 
		associationtype_name, 
		associationtype_description 
	FROM 
		AssociationTypes
	WHERE 
		(associationtype_id = @associationtype_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationTypes_Delete]
(
    @associationtype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[AssociationTypes] 
	WHERE 
	(
		([associationtype_id] = @associationtype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 5, @associationtype_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationRules_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[associationrule_id],
		[table_id_begin],
		[table_id_end],
		[itemtype_id_begin],
		[itemtype_id_end],
		[associationtype_id]
   FROM 
		AssociationRules
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Associations_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Associations_Select]
AS
    SET NOCOUNT ON;

    SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin],
		[table_id_end],
		[item_id_end],
		[associationrule_id],
		[itemtypegroup_id]	
	FROM
		Associations
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Attributes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[attribute_id],
		[attribute_name]
	FROM 
		Attributes
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[DataTypes_Update]
(
    @datatype_id int,
    @datatype_name varchar(50),
    @datatype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)

)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[DataTypes] 
	SET 
		[datatype_id] = @datatype_id, 
		[datatype_name] = @datatype_name, 
		[datatype_description] = @datatype_description 
	WHERE 
	(
		([datatype_id] = @datatype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--  EXEC ActivityLog_Insert 10, @datatype_id, 2, @datatype_name, @who, @note /* ToDo: Update constants for each table */  

   SELECT 
      [datatype_id], 
      [datatype_name], 
      [datatype_description] 
   FROM 
      DataTypes 
   WHERE 
   (
		[datatype_id] = @datatype_id
	)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[DataTypes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[datatype_id], 
		[datatype_name], 
		[datatype_description]
	FROM 
		[DataTypes]
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[DataTypes_Insert]
(
    @datatype_id int,
    @datatype_name varchar(50),
    @datatype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)

)
AS
    SET NOCOUNT OFF;

	INSERT INTO [DataTypes] 
	(
		[datatype_id], 
		[datatype_name], 
		[datatype_description]
	) 
	VALUES 
	(
		@datatype_id, 
		@datatype_name, 
		@datatype_description
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 10, @datatype_id, 1, @datatype_name, @who, @note /* ToDo: Update constants for each table */  

    SELECT 
		[datatype_id], 
		[datatype_name], 
		[datatype_description]
	FROM 
		[DataTypes] 
	WHERE 
		([datatype_id] = @datatype_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[DataTypes_Delete]
(
    @datatype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[DataTypes] 
	WHERE 
	(
		([datatype_id] = @datatype_id) 
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--  EXEC ActivityLog_Insert 10, @datatype_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AttributeValues_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[attributevalue_id], 
		[table_id], 
		[item_id],
		[itemtypeattribute_id],
		[value]
	FROM 
		[AttributeValues]
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValueLists_Select]
AS
    SET NOCOUNT ON;

	SELECT
		[constrainedvaluelist_id],
		[constrainedvaluelist_name],
		[constrainedvaluelist_description],
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	FROM
		[ConstrainedValueLists]
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Items_SelectByItemTypeId]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_SelectByItemTypeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Items_SelectByItemTypeId]
(
    @itemtype_id uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
   FROM 
		Items 
   where 
		itemtype_id = @itemtype_id
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Items_SelectByItemName]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_SelectByItemName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Items_SelectByItemName]
(
    @item_name varchar(256)
)
AS
    SET NOCOUNT ON;

	SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
   FROM 
		[Items] 
   where 
		item_name = @item_name
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Items_Select]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Items_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
	FROM 
		[Items]
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_SelectByItemTypeId]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_SelectByItemTypeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeAttributes_SelectByItemTypeId]
(
    @ItemTypeId uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT 
		itemtypeattribute_id, 
		itemtype_id, 
		attribute_id, 
		usage_attributes, 
		datatype_id, 
		itemtypeattribute_version, 
		itemtypeattribute_description
   FROM 
		ItemTypeAttributes 
   where 
		itemtype_id = @ItemTypeId
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Select]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	FROM 
		ItemTypeAttributes
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Select]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValues_Select]
AS
    SET NOCOUNT ON;

	SELECT
		[constrainedvalue_id],
		[constrainedvaluelist_id],
		[constrainedvalue_value],
		[constrainedvalue_ordinal],
		[constrainedvalue_description]
	FROM
		ConstrainedValues
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Select]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeGroups_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[itemtypegroup_id], 
		[itemtypegroup_name], 
		[itemtypegroup_description]
	FROM 
		ItemTypeGroups
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_SelectByItemTypeGroupId]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_SelectByItemTypeGroupId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypes_SelectByItemTypeGroupId]
(
    @ItemTypeGroupId uniqueidentifier
)
AS
    SET NOCOUNT ON;

	SELECT 
		itemtype_id, 
		itemtype_name, 
		itemtypegroup_id, 
		itemtype_version, 
		itemtype_description
   FROM 
		ItemTypes 
   where 
		itemtypegroup_id = @ItemTypeGroupId
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Select]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description]
   FROM
		ItemTypes
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Tables_Update]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Tables_Update]
(
    @table_id int,
    @table_name varchar(50),
    @table_version int,
    @table_description varchar(1024),
	@last_changed timestamp
)
AS
    SET NOCOUNT OFF;

	UPDATE
		[dbo].[Tables] 
	SET
		[table_id] = @table_id, 
		[table_name] = @table_name, 
		[table_version] = @table_version, 
		[table_description] = @table_description 
	WHERE 
	(
		([table_id] = @table_id)
		AND ([last_changed] = @last_changed)
	);
    
	SELECT
		table_id, 
		table_name, 
		table_version, 
		table_description,
		last_changed
	FROM 
		Tables 
	WHERE
		(table_id = @table_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Tables_Select]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Tables_Select]
AS
    SET NOCOUNT ON;

	SELECT
		table_id, 
		table_name, 
		table_version, 
		table_description,
		last_changed
	FROM
		dbo.Tables
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Tables_Insert]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Tables_Insert]
(
    @table_id int,
    @table_name varchar(50),
    @table_version int,
    @table_description varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO
		[dbo].[Tables]
	(
		[table_id], 
		[table_name], 
		[table_version], 
		[table_description]
	)
	VALUES
	(
		@table_id, 
		@table_name, 
		@table_version, 
		@table_description
	);
    
	SELECT
		table_id, 
		table_name, 
		table_version, 
		table_description,
		last_changed
	FROM 
		Tables 
	WHERE
		(table_id = @table_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Tables_Delete]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Tables_Delete]
(
    @table_id int,
	@last_changed timestamp
)
AS
    SET NOCOUNT OFF;

	DELETE FROM
		[dbo].[Tables]
	WHERE
		(
			([table_id] = @table_id)
			 AND ([last_changed] = @last_changed)
		)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Update]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[UsageAttributes_Update]
(
    @usageattribute_id int,
    @usageattribute_name varchar(50),
    @usageattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[UsageAttributes] 
	SET 
		[usageattribute_id] = @usageattribute_id, 
		[usageattribute_name] = @usageattribute_name, 
		[usageattribute_description] = @usageattribute_description 
	WHERE 
	(
		([usageattribute_id] = @usageattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 16, @usageattribute_id, 2, @usageattribute_name, @who, @note /* ToDo: Update constants for each table */  	
	
	SELECT 
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description] 
	FROM 
		[UsageAttributes] 
	WHERE 
		(usageattribute_id = @usageattribute_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Select]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[UsageAttributes_Select]
AS
    SET NOCOUNT ON;

	SELECT 
		usageattribute_id, 
		usageattribute_name, 
		usageattribute_description
   FROM
		[UsageAttributes]
' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Insert]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[UsageAttributes_Insert]
(
    @usageattribute_id int,
    @usageattribute_name varchar(50),
    @usageattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [UsageAttributes] 
	(
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description]
	) 
	VALUES 
	(
		@usageattribute_id, 
		@usageattribute_name, 
		@usageattribute_description
	);

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 16, @usageattribute_id, 1, @usageattribute_name, @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[usageattribute_id], 
		[usageattribute_name], 
		[usageattribute_description] 
	FROM 
		[UsageAttributes] 
	WHERE 
		(usageattribute_id = @usageattribute_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Delete]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[UsageAttributes_Delete]
(
    @usageattribute_id int,

    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

    DELETE FROM 
		[UsageAttributes] 
	WHERE 
	(
		([usageattribute_id] = @usageattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

--  Do not log this as ActivityLog_Insert expects uniqueidentifier not int for second parameter.
--	Could always decide to have a separate schema log for the datatables that have int id columns.

--	EXEC ActivityLog_Insert 16, @usageattribute_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Update]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypes_Update]
(
    @itemtype_id uniqueidentifier,
    @itemtype_name varchar(50),
    @itemtypegroup_id uniqueidentifier,
    @itemtype_version int,
    @itemtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ItemTypes] 
	SET 
		[itemtype_id] = @itemtype_id, 
		[itemtype_name] = @itemtype_name, 
		[itemtypegroup_id] = @itemtypegroup_id, 
		[itemtype_version] = @itemtype_version, 
		[itemtype_description] = @itemtype_description 
	WHERE 
    (
        ([itemtype_id] = @itemtype_id) 
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 14, @itemtype_id, 2, @itemtype_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description] 
	FROM 
		ItemTypes 
	WHERE 
		(itemtype_id = @itemtype_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Insert]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypes_Insert]
(
    @itemtype_id uniqueidentifier,
    @itemtype_name varchar(50),
    @itemtypegroup_id uniqueidentifier,
    @itemtype_version int,
    @itemtype_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypes] 
	(
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description]
	) 
	VALUES 
	(
		@itemtype_id, 
		@itemtype_name, 
		@itemtypegroup_id, 
		@itemtype_version, 
		@itemtype_description);

	EXEC ActivityLog_Insert 14, @itemtype_id, 1, @itemtype_name, @who, @note /* ToDo: Update constants for each table */

	SELECT 
		[itemtype_id], 
		[itemtype_name], 
		[itemtypegroup_id], 
		[itemtype_version], 
		[itemtype_description] 
	FROM 
		ItemTypes 
	WHERE 
		(itemtype_id = @itemtype_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Delete]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypes_Delete]
(
    @itemtype_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ItemTypes] 
	WHERE 
    (
		([itemtype_id] = @itemtype_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
    ) 

	EXEC ActivityLog_Insert 14, @itemtype_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Update]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeGroups_Update]
(
    @itemtypegroup_id uniqueidentifier,
    @itemtypegroup_name varchar(50),
    @itemtypegroup_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
      [	ItemTypeGroups] 
	SET 
		[itemtypegroup_id]          = @itemtypegroup_id, 
		[itemtypegroup_name]        = @itemtypegroup_name, 
		[itemtypegroup_description] = @itemtypegroup_description 
	WHERE 
    (
        ([itemtypegroup_id] = @itemtypegroup_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
    );

    EXEC ActivityLog_Insert 13, @itemtypegroup_id, 2, @itemtypegroup_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtypegroup_id], 
		[itemtypegroup_name], 
		[itemtypegroup_description] 
	FROM 
		ItemTypeGroups 
	WHERE 
		(itemtypegroup_id = @itemtypegroup_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Insert]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeGroups_Insert]
(
    @itemtypegroup_id uniqueidentifier,
    @itemtypegroup_name varchar(50),
    @itemtypegroup_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypeGroups] 
    (
		[itemtypegroup_id], 
        [itemtypegroup_name], 
        [itemtypegroup_description]
    ) 
	VALUES 
    (
        @itemtypegroup_id, 
        @itemtypegroup_name, 
        @itemtypegroup_description
    );

    EXEC ActivityLog_Insert 13, @itemtypegroup_id, 1, @itemtypegroup_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtypegroup_id], 
        [itemtypegroup_name], 
        [itemtypegroup_description]
	FROM 
		ItemTypeGroups 
	WHERE 
      (	itemtypegroup_id = @itemtypegroup_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Delete]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeGroups_Delete]
(
    @itemtypegroup_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ItemTypeGroups] 
	WHERE 
    (
		([itemtypegroup_id] = @itemtypegroup_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

   EXEC ActivityLog_Insert 13, @itemtypegroup_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValues_Insert]
(
	@constrainedvalue_id uniqueidentifier,
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvalue_value varchar(50),
    @constrainedvalue_ordinal int,
    @constrainedvalue_description varchar(1024),
	@who varchar(50),      
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;
	INSERT INTO [ConstrainedValues] 
	(	
		[constrainedvalue_id],
		[constrainedvaluelist_id], 
		[constrainedvalue_value], 
		[constrainedvalue_ordinal], 
		[constrainedvalue_description]
	)
	VALUES 
	(
		@constrainedvalue_id,
		@constrainedvaluelist_id, 
		@constrainedvalue_value, 
		@constrainedvalue_ordinal, 
		@constrainedvalue_description
	);

	EXEC ActivityLog_Insert 9, @constrainedvalue_id, 1, @constrainedvalue_value, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvalue_id],
		[constrainedvaluelist_id], 
		[constrainedvalue_value], 
		[constrainedvalue_ordinal], 
		[constrainedvalue_description]
	FROM 
		ConstrainedValues 
	WHERE 
		(constrainedvalue_id = @constrainedvalue_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValues_Delete]
(
    @constrainedvalue_id uniqueidentifier,
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ConstrainedValues] 
	WHERE 
	(
		([constrainedvalue_id] = @constrainedvalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 9, @constrainedvalue_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Update]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Update]
(
    @itemtypeattribute_id uniqueidentifier,
    @itemtype_id uniqueidentifier,
    @attribute_id uniqueidentifier,
    @usage_attributes int,
    @datatype_id int,
    @itemtypeattribute_version int,
    @itemtypeattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ItemTypeAttributes] 
	SET 
		[itemtypeattribute_id] = @itemtypeattribute_id, 
		[itemtype_id] = @itemtype_id, 
		[attribute_id] = @attribute_id, 
		[usage_attributes] = @usage_attributes, 
		[datatype_id] = @datatype_id, 
		[itemtypeattribute_version] = @itemtypeattribute_version, 
		[itemtypeattribute_description] = @itemtypeattribute_description 
	WHERE 
	(
		([itemtypeattribute_id] = @itemtypeattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 12, @itemtypeattribute_id, 2, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description] 
	FROM 
		ItemTypeAttributes 
	WHERE 
		(itemtypeattribute_id = @itemtypeattribute_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Insert]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Insert]
(
    @itemtypeattribute_id uniqueidentifier,
    @itemtype_id uniqueidentifier,
    @attribute_id uniqueidentifier,
    @usage_attributes int,
    @datatype_id int,
    @itemtypeattribute_version int,
    @itemtypeattribute_description varchar(1024),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [ItemTypeAttributes] 
	(
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	) 
	VALUES 
	(
		@itemtypeattribute_id, 
		@itemtype_id, 
		@attribute_id, 
		@usage_attributes, 
		@datatype_id, 
		@itemtypeattribute_version, 
		@itemtypeattribute_description
	);

   EXEC ActivityLog_Insert 12, @itemtypeattribute_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[itemtypeattribute_id], 
		[itemtype_id], 
		[attribute_id], 
		[usage_attributes], 
		[datatype_id], 
		[itemtypeattribute_version], 
		[itemtypeattribute_description]
	FROM 
		ItemTypeAttributes 
	WHERE 
		(itemtypeattribute_id = @itemtypeattribute_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Delete]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ItemTypeAttributes_Delete]
(
    @itemtypeattribute_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ItemTypeAttributes] 
	WHERE 
	(
		([itemtypeattribute_id] = @itemtypeattribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 12, @itemtypeattribute_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Items_Update]    Script Date: 08/20/2011 00:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Items_Update]
(
    @item_id uniqueidentifier,
    @item_name varchar(256),
	@itemtype_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[Items] 
	SET 
		[item_id] = @item_id, 
		[item_name] = @item_name, 
		[itemtype_id] = @itemtype_id
	WHERE 
	(
		([item_id] = @item_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 12, @item_id, 2, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
	FROM 
		Items 
	WHERE 
		(item_id = @item_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Items_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Items_Insert]
(
    @item_id uniqueidentifier,
    @item_name varchar(256),
	@itemtype_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Items] 
	(
		[item_id], 
		[item_name], 
		[itemtype_id]
	) 
	VALUES 
	(
		@item_id, 
		@item_name,
		@itemtype_id
	);

   EXEC ActivityLog_Insert 12, @item_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[item_id], 
		[item_name], 
		[itemtype_id]
	FROM 
		Items 
	WHERE 
		(item_id = @item_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Items_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Items_Delete]
(
    @item_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[Items] 
	WHERE 
	(
		([item_id] = @item_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 12, @item_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValues_Update]
(
	@constrainedvalue_id uniqueidentifier,
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvalue_value varchar(50),
    @constrainedvalue_ordinal int,
    @constrainedvalue_description varchar(1024),
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ConstrainedValues] 
	SET 
		[constrainedvaluelist_id]      = @constrainedvaluelist_id, 
		[constrainedvalue_value]       = @constrainedvalue_value, 
		[constrainedvalue_ordinal]     = @constrainedvalue_ordinal, 
		[constrainedvalue_description] = @constrainedvalue_description 
	WHERE 
	(
		([constrainedvalue_id] = @constrainedvalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */ 
	);
    
	EXEC ActivityLog_Insert 9, @constrainedvalue_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvalue_id],
		[constrainedvaluelist_id], 
		[constrainedvalue_value], 
		[constrainedvalue_ordinal], 
		[constrainedvalue_description]
	FROM 
		ConstrainedValues 
	WHERE 
		(constrainedvalue_id = @constrainedvalue_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValueLists_Update]
(
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvaluelist_name varchar(50),
    @constrainedvaluelist_description varchar(1024),
    @constrainedvaluelist_nbritems int,
	@constrainedvaluelist_datatype_id int,
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[ConstrainedValueLists] 
	SET 
		[constrainedvaluelist_id] = @constrainedvaluelist_id, 
		[constrainedvaluelist_name] = @constrainedvaluelist_name, 
		[constrainedvaluelist_description] = @constrainedvaluelist_description, 
		[constrainedvaluelist_nbritems] = @constrainedvaluelist_nbritems,
		[constrainedvaluelist_datatype_id] = @constrainedvaluelist_datatype_id
	WHERE 
	(
		([constrainedvaluelist_id] = @constrainedvaluelist_id) 
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);
    
	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	FROM 
		[ConstrainedValueLists] 
	WHERE 
		(constrainedvaluelist_id = @constrainedvaluelist_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValueLists_Insert]
(
    @constrainedvaluelist_id uniqueidentifier,
    @constrainedvaluelist_name varchar(50),
    @constrainedvaluelist_description varchar(1024),
    @constrainedvaluelist_nbritems int,
	@constrainedvaluelist_datatype_id int,
	@who varchar(50),      
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;
	INSERT INTO [ConstrainedValueLists] 
   (	
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	)
	VALUES 
	(
		@constrainedvaluelist_id, 
		@constrainedvaluelist_name, 
		@constrainedvaluelist_description, 
		@constrainedvaluelist_nbritems,
		@constrainedvaluelist_datatype_id
	 );

	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 1, constrainedvaluelist_name, @who, @note /* ToDo: Update constants for each table */  

	SELECT 
		[constrainedvaluelist_id], 
		[constrainedvaluelist_name], 
		[constrainedvaluelist_description], 
		[constrainedvaluelist_nbritems],
		[constrainedvaluelist_datatype_id]
	FROM 
		[ConstrainedValueLists] 
	WHERE 
		(constrainedvaluelist_id = @constrainedvaluelist_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[ConstrainedValueLists_Delete]
(
    @constrainedvaluelist_id uniqueidentifier,
	@who varchar(50),
	@note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[ConstrainedValueLists] 
	WHERE 
	(
		([constrainedvaluelist_id] = @constrainedvaluelist_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */ 
	)

	EXEC ActivityLog_Insert 8, @constrainedvaluelist_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AttributeValues_Insert]
(
    @attributevalue_id uniqueidentifier,
    @table_id int,
	@item_id uniqueidentifier,
	@itemtypeattribute_id uniqueidentifier,
	@value varchar(2048),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AttributeValues] 
	(
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	) 
	VALUES 
	(
		@attributevalue_id, 
		@table_id,
		@item_id,
		@itemtypeattribute_id,
		@value
	);

   EXEC ActivityLog_Insert 12, @attributevalue_id, 1, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	FROM 
		AttributeValues 
	WHERE 
		([attributevalue_id] = @attributevalue_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AttributeValues_Delete]
(
    @attributevalue_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[AttributeValues] 
	WHERE 
	(
		([attributevalue_id] = @attributevalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 12, @attributevalue_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AttributeValues_Update]
(
    @attributevalue_id uniqueidentifier,
    @table_id int,
	@item_id uniqueidentifier,
	@itemtypeattribute_id uniqueidentifier,
	@value varchar(2048),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[AttributeValues] 
	SET 
		[table_id] = @table_id, 
		[item_id] = @item_id, 
		[itemtypeattribute_id] = @itemtypeattribute_id,
		[value] = @value
	WHERE 
	(
		([attributevalue_id] = @attributevalue_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 12, @attributevalue_id, 2, "<Value Goes Here>", @who, @note /* ToDo: Update constants for each table */  

   SELECT 
		[attributevalue_id], 
		[table_id],
		[item_id],
		[itemtypeattribute_id],
		[value]
	FROM 
		AttributeValues 
	WHERE 
		([attributevalue_id] = @attributevalue_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Attributes_Update]
(
    @attribute_id uniqueidentifier,
    @attribute_name varchar(50),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[Attributes] 
	SET 
		[attribute_id] = @attribute_id, 
		[attribute_name] = @attribute_name 
	WHERE 
	(
		([attribute_id] = @attribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

	EXEC ActivityLog_Insert 6, @attribute_id, 2, @attribute_name, @who, @note /* ToDo: Update constants for each table */  

    SELECT 
		[attribute_id], 
		[attribute_name] 
	FROM 
		Attributes 
	WHERE 
		(attribute_id = @attribute_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Attributes_Insert]
(
    @attribute_id uniqueidentifier,
    @attribute_name varchar(50),
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Attributes] 
	(
		[attribute_id], 
		[attribute_name]
	) 
	VALUES 
	(
		@attribute_id, 
		@attribute_name
	);

	EXEC ActivityLog_Insert 6, @attribute_id, 1, @attribute_name, @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[attribute_id], 
		[attribute_name] 
	FROM 
		Attributes 
	WHERE 
		(attribute_id = @attribute_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Attributes_Delete]
(
    @attribute_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[Attributes] 
	WHERE 
	(
		([attribute_id] = attribute_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)

	EXEC ActivityLog_Insert 6, @attribute_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Associations_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Associations_Insert]
(
	@association_id uniqueidentifier,
	@table_id_begin int,
	@item_id_begin uniqueidentifier,
	@table_id_end int,
	@item_id_end uniqueidentifier,
	@associationrule_id uniqueidentifier,
	@itemtypegroup_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [Associations] 
	(
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	)
	VALUES
	(
		@association_id,
		@table_id_begin, 
		@item_id_begin,
		@table_id_end, 
		@item_id_end,
		@associationrule_id, 
		@itemtypegroup_id
	);

	EXEC ActivityLog_Insert 4, @association_id, 1, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
    
	SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	FROM 
		Associations 
	WHERE 
		(association_id = @association_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Associations_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Associations_Delete]
(
    @association_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)

)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[Associations] 
	WHERE 
	(
		[association_id] = @association_id
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	)
   
	EXEC ActivityLog_Insert 4, @association_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Associations_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[Associations_Update]
(
	@association_id uniqueidentifier,
    @table_id_begin int,
	@item_id_begin uniqueidentifier,
	@table_id_end int,
	@item_id_end uniqueidentifier,
	@associationrule_id uniqueidentifier,
	@itemtypegroup_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[Associations] 
	SET 
		[table_id_begin]     = @table_id_begin,
		[item_id_begin]      = @item_id_begin, 
		[table_id_end]       = @table_id_end, 
		[item_id_end]        = @item_id_end, 
		[associationrule_id] = @associationrule_id, 
		[itemtypegroup_id]   = @itemtypegroup_id
	WHERE 
	(
		([association_id] = @association_id)
		AND (1 = 1) /* TODO: Redo this with TimeStamps */
	);

    EXEC ActivityLog_Insert 4, @association_id, 2, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
   
	SELECT
		[association_id],
		[table_id_begin],
		[item_id_begin], 
		[table_id_end], 
		[item_id_end], 
		[associationrule_id], 
		[itemtypegroup_id]
	FROM 
		Associations 
	WHERE 
		(association_id = @association_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Update]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationRules_Update]
(
    @associationrule_id uniqueidentifier,
    @table_id_begin int,
    @itemtype_id_begin uniqueidentifier,
    @table_id_end int,
    @itemtype_id_end uniqueidentifier,
    @associationtype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	UPDATE 
		[AssociationRules] 
	SET 
		[associationrule_id] = @associationrule_id, 
		[table_id_begin] = @table_id_begin, 
		[itemtype_id_begin] = @itemtype_id_begin, 
		[table_id_end] = @table_id_end, 
		[itemtype_id_end] = @itemtype_id_end, 
		[associationtype_id] = @associationtype_id 
	WHERE 
	(
		([associationrule_id] = @associationrule_id)
		AND (1 = 1 /* TODO: Redo this with TimeStamps */)
	);

	EXEC ActivityLog_Insert 3, @associationrule_id, 2, "more stuff", @who, @note /* ToDo: Update constants for each table */  

    SELECT 
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id] 
	FROM 
		AssociationRules 
	WHERE 
		(associationrule_id = @associationrule_id)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Insert]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationRules_Insert]
(
    @associationrule_id uniqueidentifier,
    @table_id_begin int,
    @itemtype_id_begin uniqueidentifier,
    @table_id_end int,
    @itemtype_id_end uniqueidentifier,
    @associationtype_id int,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	INSERT INTO [AssociationRules] 
	(
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id]
	) 
	VALUES 
	(
		@associationrule_id, 
		@table_id_begin, 
		@itemtype_id_begin,
 		@table_id_end, 
		@itemtype_id_end, 
		@associationtype_id
	);

    EXEC ActivityLog_Insert 3, @associationrule_id, 1, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
   
	SELECT 
		[associationrule_id], 
		[table_id_begin], 
		[itemtype_id_begin],
 		[table_id_end], 
		[itemtype_id_end], 
		[associationtype_id] 
	FROM 
		AssociationRules 
	WHERE
	(
		associationrule_id = @associationrule_id
	)
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Delete]    Script Date: 08/20/2011 00:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Stored Procedure:    <name>
-- Created on:          <date>
-- Author:              <name>
-- Purpose:             <Explain why the SP exists>
-- Business Rule:
-- Input Parameters: 
-- Output Parameters:
-- Return Status:
-- Tasks:
-- Usage:
-- Called by:
-- Calls:
-- Notes:
-- Data Modifications;
-- Change History:
    
-- =============================================
CREATE PROCEDURE [dbo].[AssociationRules_Delete]
(
    @associationrule_id uniqueidentifier,
    @who varchar(50),
    @note varchar(1024)
)
AS
    SET NOCOUNT OFF;

	DELETE FROM 
		[AssociationRules] 
	WHERE 
	(
		([associationrule_id] = @associationrule_id)
		AND (1 = 1 /* TODO: Redo this with TimeStamps */)
	)

   EXEC ActivityLog_Insert 3, @associationrule_id, 3, "Value Needed", @who, @note /* ToDo: Update constants for each table */  
' 
END
GO
/****** Object:  Default [DF_ItemTypes_itemtype_id]    Script Date: 08/20/2011 00:10:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypes_itemtype_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypes_itemtype_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypes] ADD  CONSTRAINT [DF_ItemTypes_itemtype_id]  DEFAULT (newid()) FOR [itemtype_id]
END


End
GO
/****** Object:  Default [DF_ItemTypeGroups_itemtypegroup_id]    Script Date: 08/20/2011 00:10:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeGroups_itemtypegroup_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeGroups_itemtypegroup_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeGroups] ADD  CONSTRAINT [DF_ItemTypeGroups_itemtypegroup_id]  DEFAULT (newid()) FOR [itemtypegroup_id]
END


End
GO
/****** Object:  Default [DF_ItemTypeAttributes_itemtypeattribute_id]    Script Date: 08/20/2011 00:10:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ItemTypeAttributes_itemtypeattribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ItemTypeAttributes_itemtypeattribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemTypeAttributes] ADD  CONSTRAINT [DF_ItemTypeAttributes_itemtypeattribute_id]  DEFAULT (newid()) FOR [itemtypeattribute_id]
END


End
GO
/****** Object:  Default [DF_Items_item_id]    Script Date: 08/20/2011 00:10:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Items_item_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Items]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Items_item_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_item_id]  DEFAULT (newid()) FOR [item_id]
END


End
GO
/****** Object:  Default [DF_AttributeValues_attribute_value_id]    Script Date: 08/20/2011 00:10:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttributeValues_attribute_value_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AttributeValues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AttributeValues_attribute_value_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttributeValues] ADD  CONSTRAINT [DF_AttributeValues_attribute_value_id]  DEFAULT (newid()) FOR [attributevalue_id]
END


End
GO
/****** Object:  Default [DF_Associations_association_id]    Script Date: 08/20/2011 00:10:37 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Associations_association_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Associations]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Associations_association_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Associations] ADD  CONSTRAINT [DF_Associations_association_id]  DEFAULT (newid()) FOR [association_id]
END


End
GO
/****** Object:  Default [DF_ActivityLog_activitylog_id]    Script Date: 08/20/2011 00:10:37 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActivityLog_activitylog_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[ActivityLog]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ActivityLog_activitylog_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ActivityLog] ADD  CONSTRAINT [DF_ActivityLog_activitylog_id]  DEFAULT (newid()) FOR [activitylog_id]
END


End
GO
/****** Object:  Default [DF_Attributes_attribute_id]    Script Date: 08/20/2011 00:10:37 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_attribute_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Attributes_attribute_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_attribute_id]  DEFAULT (newid()) FOR [attribute_id]
END


End
GO
/****** Object:  Default [DF_AccociationRules_associationrule_id]    Script Date: 08/20/2011 00:10:37 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AccociationRules_associationrule_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssociationRules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AccociationRules_associationrule_id]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssociationRules] ADD  CONSTRAINT [DF_AccociationRules_associationrule_id]  DEFAULT (newid()) FOR [associationrule_id]
END


End
GO
