USE [ODB]
GO
/*
 ActivityLog
 */
/****** Object:  StoredProcedure [dbo].[ActivityLog_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Select]
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Update]
GO
/****** Object:  StoredProcedure [dbo].[ActivityLog_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ActivityLog_Delete]
GO

/*
 AssociationRules
 */
/****** Object:  StoredProcedure [dbo].[AssociationRules_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Select]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Insert]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Update]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationRules_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationRules_Delete]
GO

/*
 Associations
 */

/****** Object:  StoredProcedure [dbo].[Associations_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Select]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Insert]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Update]
GO
/****** Object:  StoredProcedure [dbo].[AssociationRules_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Associations_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Associations_Delete]
GO

/*
 AssociationTypes
 */
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Select]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Update]
GO
/****** Object:  StoredProcedure [dbo].[AssociationTypes_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationTypes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AssociationTypes_Delete]
GO

/*
 Attributes
 */
/****** Object:  StoredProcedure [dbo].[Attributes_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Select]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Update]
GO
/****** Object:  StoredProcedure [dbo].[Attributes_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Attributes_Delete]
GO

/*
 AttributeValues
 */
/****** Object:  StoredProcedure [dbo].[AttributeValues_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Select]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Insert]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Update]
GO
/****** Object:  StoredProcedure [dbo].[AttributeValues_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeValues_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AttributeValues_Delete]
GO

/*
 ConstrainedValueLists
 */
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Select]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Update]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValueLists_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValueLists_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValueLists_Delete]
GO

/*
 ConstrainedValues
 */
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Select]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Update]
GO
/****** Object:  StoredProcedure [dbo].[ConstrainedValues_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConstrainedValues_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ConstrainedValues_Delete]
GO

/*
 DataTypes
 */
/****** Object:  StoredProcedure [dbo].[DataTypes_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Select]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Update]
GO
/****** Object:  StoredProcedure [dbo].[DataTypes_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DataTypes_Delete]
GO

/*
 Items
 */
/****** Object:  StoredProcedure [dbo].[Items_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Select]
GO
/****** Object:  StoredProcedure [dbo].[Items_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Items_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Update]
GO
/****** Object:  StoredProcedure [dbo].[Items_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Items_Delete]
GO

/*
 ItemTypeAttributes
 */
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Select]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Update]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_Delete]
GO

/*
 ItemTypeGroups
 */
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Select]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Update]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeGroups_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeGroups_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeGroups_Delete]
GO

/*
 ItemTypes
 */
/****** Object:  StoredProcedure [dbo].[ItemTypes_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Select]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Update]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_Delete]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypes_SelectByItemTypeGroupId]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypes_SelectByItemTypeGroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypes_SelectByItemTypeGroupId]
GO
/****** Object:  StoredProcedure [dbo].[ItemTypeAttributes_SelectByItemTypeId]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTypeAttributes_SelectByItemTypeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ItemTypeAttributes_SelectByItemTypeId]
GO

/*
 LogFunctions
 */
/****** Object:  StoredProcedure [dbo].[LogFunctions_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LogFunctions_Select]
GO
/****** Object:  StoredProcedure [dbo].[LogFunctions_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LogFunctions_Insert]
GO
/****** Object:  StoredProcedure [dbo].[LogFunctions_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LogFunctions_Update]
GO
/****** Object:  StoredProcedure [dbo].[LogFunctions_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogFunctions_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LogFunctions_Delete]
GO

/*
 Tables
 */
/****** Object:  StoredProcedure [dbo].[Tables_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Select]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Update]
GO
/****** Object:  StoredProcedure [dbo].[Tables_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Tables_Delete]
GO

/*
 UsageAttributes
 */
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Select]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Select]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Insert]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Insert]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Update]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Update]
GO
/****** Object:  StoredProcedure [dbo].[UsageAttributes_Delete]    Script Date: 01/06/2006 11:07:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsageAttributes_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UsageAttributes_Delete]
GO

/*
 End File
 */
