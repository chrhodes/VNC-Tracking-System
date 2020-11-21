using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Text;

namespace ODB.Schema
{
    public class Helper
    {

        #region Main Function Routines

        static public void ProcessXML(XElement schema)
        {
            // XML elements can be processed in any order until referential rules
            // are added to the database.  For now, try to keep these in a sensible
            // order where the support tables are populated before the content tables.

            ProcessTablesXML(schema);
            ProcessLogFunctionsXML(schema);

            // These tables govern the types of items that can be stored in the ODB,
            // their attributes, and the characteristics of those attributes including
            // attributes whose values are constrained.

            //ProcessDataTypesXML(schema);
            //ProcessUsageAttributesXML(schema);

            //ProcessItemTypeGroupsXML(schema);
            //ProcessItemTypesXML(schema);
            //ProcessAttributesXML(schema);
            //ProcessItemTypeAttributesXML(schema);
            //ProcessConstrainedValueListsXML(schema);
            //ProcessConstrainedValuesXML(schema);

            // These tables goven the types of associations that can exist between
            // items in the ODB.

            //ProcessAssociationTypesXML(schema);
            //ProcessAssociationRulesXML(schema);

            // These tables store the items and their attributes, and any associations

            //ProcessAssociationsXML(schema);
            //ProcessItemsXML(schema);
            //ProcessAttributeValuesXML(schema);
        }

        #endregion

        #region Provisioning Routines

        private static void ProcessAssociationRulesXML(XElement schema)
        {
            XElement associationRules = schema.Element("AssociationRules");
            var T = new ODB.DAL.Sql.AssociationRuleDAL();

            foreach (XElement elm in associationRules.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "Association":
                        Guid id = GetAGuid(elm.Attribute("id").Value);
                        int table_id_begin = int.Parse(elm.Attribute("table_id_begin").Value);
                        int table_id_end = int.Parse(elm.Attribute("table_id_end").Value);
                        Guid item_type_id_begin = GetAGuid(elm.Attribute("item_type_id_begin").Value);
                        Guid item_type_id_end = GetAGuid(elm.Attribute("item_type_id_end").Value);
                        int associationtype_id = int.Parse(elm.Attribute("associationtype_id").Value);

                        T.Insert(table_id_begin, table_id_end, item_type_id_begin, item_type_id_end, associationtype_id);
                        break;
                }
            }
        }

        private static void ProcessAssociationsXML(XElement schema)
        {
            XElement associations = schema.Element("Associations");
            var T = new ODB.DAL.Sql.AssociationDAL();

            foreach (XElement elm in associations.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "Association":
                        int table_id_begin = int.Parse(elm.Attribute("table_id_begin").Value);
                        Guid item_id_begin = GetAGuid(elm.Attribute("item_id_begin").Value);
                        int table_id_end = int.Parse(elm.Attribute("table_id_end").Value);
                        Guid item_id_end = GetAGuid(elm.Attribute("item_id_end").Value);
                        Guid associationrule_id = GetAGuid(elm.Attribute("associationrule_id").Value);
                        Guid itemtypegroup_id = GetAGuid(elm.Attribute("itemtypegroup_id").Value);

                        T.Insert(table_id_begin, item_id_begin, table_id_end, item_id_end, associationrule_id, itemtypegroup_id);
                        break;
                }
            }
        }

        private static void ProcessAssociationTypesXML(XElement schema)
        {
            XElement associationTypes = schema.Element("AssociationTypes");
            var T = new ODB.DAL.Sql.AssociationTypeDAL();

            foreach (XElement elm in associationTypes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "AssociationType":
                        string associationtype_name = elm.Attribute("name").Value;
                        string associationtype_description = elm.Attribute("description").Value;

                        T.Insert(associationtype_name, associationtype_description);
                        break;
                }
            }
        }

        private static void ProcessAttributesXML(XElement schema)
        {
            XElement attributes = schema.Element("Attributes");
            var T = new ODB.DAL.Sql.AttributeDAL();

            foreach (XElement elm in attributes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "Attribute":
                        string attribute_name = elm.Attribute("name").Value;

                        T.Insert(attribute_name);    
                        break;
                }
            }
        }

        private static void ProcessAttributeValuesXML(XElement schema)
        {
            XElement attributeValues = schema.Element("AttributeValues");
             var T = new ODB.DAL.Sql.AttributeValueDAL();

            foreach (XElement elm in attributeValues.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "AttributeValue":
                        int table_id = int.Parse(elm.Attribute("table_id").Value);
                        Guid item_id = GetAGuid(elm.Attribute("item_id").Value);
                        Guid itemtypeattribute_id = GetAGuid(elm.Attribute("itemtypeattribute_id").Value);
                        string value = String.Empty;

                        T.Insert(table_id, item_id, itemtypeattribute_id, value);   
                        break;
                }
            }
        }

        private static void ProcessConstrainedValueListsXML(XElement schema)
        {
            XElement constrainedValues = schema.Element("ConstrainedValueLists");
            var T = new ODB.DAL.Sql.ConstrainedValueListDAL();

            foreach (XElement elm in constrainedValues.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "ConstrainedValueList":
                        string constrainedvaluelist_name = elm.Attribute("name").Value;
                        string constrainedvaluelist_description = elm.Attribute("description").Value;
                        int constrainedvaluelist_nbritems = int.Parse(elm.Attribute("nbritems").Value);
                        int constrainedvaluelist_datatype_id = int.Parse(elm.Attribute("datatype_id").Value);

                        T.Insert(constrainedvaluelist_name, constrainedvaluelist_description, constrainedvaluelist_nbritems, constrainedvaluelist_datatype_id);    
                        break;
                }
            }
        }

        private static void ProcessConstrainedValuesXML(XElement schema)
        {
            XElement contrainedValues = schema.Element("ConstrainedValues");
            var T = new ODB.DAL.Sql.ConstrainedValueDAL();

            foreach (XElement elm in contrainedValues.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "ConstrainedValue":
                        Guid constrainedvaluelist_id = GetAGuid(elm.Attribute("id").Value);
                        string constrainedvalue_value = elm.Attribute("value").Value;
                        int constrainedvalue_ordinal = int.Parse(elm.Attribute("ordinal").Value);
                        string constrainedvalue_description = elm.Attribute("description").Value;

                        T.Insert(constrainedvaluelist_id, constrainedvalue_value, constrainedvalue_ordinal, constrainedvalue_description);
                        break;
                }
            }
        }

        private static void ProcessDataTypesXML(XElement schema)
        {
            XElement dataTypes = schema.Element("DataTypes");
            var T = new ODB.DAL.Sql.DataTypeDAL();

            foreach (XElement elm in dataTypes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "DataType":
                        string datatype_name = elm.Attribute("name").Value;
                        string datatype_description = elm.Attribute("description").Value;

                        T.Insert(datatype_name, datatype_description);    
                        break;
                }
            }
        }

        private static void ProcessItemsXML(XElement schema)
        {
            XElement items = schema.Element("Items");
            var T = new ODB.DAL.Sql.ItemDAL();

            foreach (XElement elm in items.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "Item":
                        string item_name = elm.Attribute("name").Value;
                        Guid itemtype_id = GetAGuid(elm.Attribute("itemtype_id").Value);

                        T.Insert(item_name, itemtype_id);  
                        break;
                }
            }
        }

        private static void ProcessItemTypeAttributesXML(XElement schema)
        {
            XElement itemTypeAttributes = schema.Element("ItemTypeAttributes");
            var T = new ODB.DAL.Sql.ItemTypeAttributeDAL();

            foreach (XElement elm in itemTypeAttributes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "ItemTypeAttribute":
                        Guid itemtype_id = GetAGuid(elm.Attribute("itemtype_id").Value);
                        Guid attribute_id = GetAGuid(elm.Attribute("attribute_id").Value);
                        int usage_attributes = int.Parse(elm.Attribute("usage_attributes").Value);
                        int datatype_id = int.Parse(elm.Attribute("datatype_id").Value);
                        int itemtypeattribute_version = int.Parse(elm.Attribute("version").Value);
                        string itemtypeattribute_description = elm.Attribute("description").Value;

                        T.Insert(itemtype_id, attribute_id, usage_attributes, datatype_id, itemtypeattribute_version, itemtypeattribute_description);   
                        break;
                }
            }
        }


        private static void ProcessItemTypeGroupsXML(XElement schema)
        {
            XElement itemTypeGroups = schema.Element("ItemTypeGroups");
            var T = new ODB.DAL.Sql.ItemTypeGroupDAL();

            foreach (XElement elm in itemTypeGroups.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "ItemTypeGroup":
                        // TODO(crhodes): Decide how to handle XML errors
                        Guid itemtypegroup_id = GetAGuid(elm.Attribute("id").Value);

                        string itemtypegroup_name = elm.Attribute("name").Value;
                        string itemtypegroup_description = elm.Attribute("description").Value;

                        T.Insert(itemtypegroup_name, itemtypegroup_description);  
                        break;
                }
            }
        }

        private static void ProcessItemTypesXML(XElement schema)
        {
            XElement itemTypes = schema.Element("ItemTypes");

            foreach (XElement elm in itemTypes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":

                        break;

                    case "ItemType":
                        var T = new ODB.DAL.Sql.ItemTypeDAL();

                        string itemtype_name = elm.Attribute("name").Value;
                        // TODO(crhodes): See how this handles group=""
                        Guid itemtypegroup_id = Guid.Parse(elm.Attribute("itemtypegroup_id").Value);
                        
                        int itemtype_version = int.Parse(elm.Attribute("version").Value);
                        string itemtype_description = elm.Attribute("description").Value;

                        T.Insert(itemtype_name, itemtypegroup_id, itemtype_version, itemtype_description);  
                        break;
                }
            }
        }

        private static void ProcessLogFunctionsXML(XElement schema)
        {
            XElement logFunctions = schema.Element("LogFunctions");
            var T = new ODB.DAL.Sql.LogFunctionDAL();

            foreach (XElement elm in logFunctions.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "LogFunction":
                        string logfunction_name = elm.Attribute("logfunction_name").Value;
                        string logfunction_description = elm.Attribute("logfunction_description").Value;
                        string who = "ProcessTablesXML";
                        string notes = "";
                        T.Insert(logfunction_name, logfunction_description, who, notes);  
                        break;
                }
            }
        }

        private static void ProcessTablesXML(XElement schema)
        {
            XElement tables = schema.Element("Tables");
            var T = new ODB.DAL.Sql.TableDAL();
            
            foreach (XElement elm in tables.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "Table":
                        int table_id = int.Parse(elm.Attribute("id").Value);
                        string table_name = elm.Attribute("name").Value;
                        int table_version = int.Parse(elm.Attribute("version").Value);
                        string table_description = elm.Attribute("description").Value;
                        string who = "ProcessTablesXML";
                        string notes = "";

                        T.Insert(table_id, table_name, table_version, table_description, who, notes);
                        break;
                }
            }
        }

        private static void ProcessUsageAttributesXML(XElement schema)
        {
            XElement usageAttributes = schema.Element("UsageAttributes");
            var T = new ODB.DAL.Sql.UsageAttributeDAL();

            foreach (XElement elm in usageAttributes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "DeleteAll":
                        T.DeleteAll();
                        break;

                    case "UsageAttribute":
                        string usageattribute_name = elm.Attribute("name").Value;
                        string usageattribute_description = elm.Attribute("description").Value;

                        T.Insert(usageattribute_name, usageattribute_description); 
                        break;
                }
            }
        }

        #endregion

        #region Helpers

        private static Guid GetAGuid(string value)
        {
            if (value == "NewGuid")
            {
                return Guid.NewGuid();
            }
            else
            {
                return Guid.Parse(value);
            }
        }

        #endregion

    }
}
