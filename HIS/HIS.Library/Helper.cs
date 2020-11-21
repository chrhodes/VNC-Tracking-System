using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Text;

namespace HIS.Library
{
    public class Helper
    {

        //private static HIS.Library.HISSchemaECL _HISSchema;
        //public static HIS.Library.HISSchemaECL HISSchema
        //{
        //    get
        //    {
        //        if (null == _HISSchema)
        //        {
        //            _HISSchema = HIS.Library.HISSchemaECL.Get();
        //        }

        //        return _HISSchema;
        //    }
        //    set
        //    {
        //        _HISSchema = value;
        //    }
        //}

        #region Main Function Routines

        static public void ProcessXML(XElement schema)
        {
            // XML elements can be processed in any order until referential rules
            // are added to the database.  For now, try to keep these in a sensible
            // order where the support tables are populated before the content tables.

            ProcessTablesXML(schema);
            ProcessLogFunctionsXML(schema);

            // These tables govern the types of items that can be stored in the HIS,
            // their attributes, and the characteristics of those attributes including
            // attributes whose values are constrained.

            ProcessDataTypesXML(schema);
            ProcessCharacteristicsXML(schema);

            ProcessTypesXML(schema);
            ProcessAttributesXML(schema);
            ProcessTypeAttributesXML(schema);
            ProcessConstrainedValueListsXML(schema);
            ProcessConstrainedValuesXML(schema);

            // These tables store the items and their attributes

            ProcessItemsXML(schema);
            ProcessAttributeValuesXML(schema);
        }

        #endregion

        #region Processing Routines
        
        private static void ProcessAttributesXML(XElement schema)
        {
            XElement attributes = schema.Element("Attributes");
            var T = new HIS.DAL.Sql.AttributeDAL();

            Guid attribute_id;
            string name;

            string who = "ProcessAttributesXML";
            string notes = "";

            foreach (XElement elm in attributes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        attribute_id = GetAGuid(elm.Attribute("attribute_id").Value);
                        name = elm.Attribute("name").Value;

                        T.Insert(attribute_id, name, who, notes);    
                        break;

                    case "Update":
                        attribute_id = GetAGuid(elm.Attribute("attribute_id").Value);
                        name = elm.Attribute("name").Value;

                        //T.Update(attribute_id, name, who, notes);
                        break;

                    case "Delete":
                        attribute_id = GetAGuid(elm.Attribute("attribute_id").Value);

                        //T.Delete(attribute_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;
                }
            }
        }

        private static void ProcessAttributeValuesXML(XElement schema)
        {
            XElement attributeValues = schema.Element("AttributeValues");
            var T = new HIS.DAL.Sql.AttributeValueDAL();

            Guid attributevalue_id;
            int table_id;
            Guid item_id;
            Guid type_id;
            string value;

            string who = "ProcessAttributeValuesXML";
            string notes = "";

            foreach (XElement elm in attributeValues.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        attributevalue_id = GetAGuid(elm.Attribute("attributevalue_id").Value);
                        table_id = int.Parse(elm.Attribute("table_id").Value);
                        item_id = GetAGuid(elm.Attribute("item_id").Value);
                        type_id = GetAGuid(elm.Attribute("typeattribute_id").Value);
                        value = elm.Attribute("value").Value;

                        T.Insert(attributevalue_id, table_id, item_id, type_id, value, who, notes);   
                        break;

                    case "Update":
                        attributevalue_id = GetAGuid(elm.Attribute("attributevalue_id").Value);
                        table_id = int.Parse(elm.Attribute("table_id").Value);
                        item_id = GetAGuid(elm.Attribute("item_id").Value);
                        type_id = GetAGuid(elm.Attribute("typeattribute_id").Value);
                        value = elm.Attribute("value").Value;

                        T.Insert(attributevalue_id, table_id, item_id, type_id, value, who, notes);
                        break;

                    case "Delete":
                        attributevalue_id = GetAGuid(elm.Attribute("attributevalue_id").Value);

                        //T.Delete(attributevalue_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;
                }
            }
        }

        private static void ProcessConstrainedValueListsXML(XElement schema)
        {
            XElement constrainedValues = schema.Element("ConstrainedValueLists");
            var T = new HIS.DAL.Sql.ConstrainedValueListDAL();

            Guid constrainedvaluelist_id;
            string name;
            string description;
            int nbritems;
            int datatype_id;

            string who = "ProcessConstrainedValueListsXML";
            string notes = "";

            foreach (XElement elm in constrainedValues.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        constrainedvaluelist_id = GetAGuid(elm.Attribute("constrainedvaluelist_id").Value);
                        datatype_id = int.Parse(elm.Attribute("datatype_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;
                        nbritems = int.Parse(elm.Attribute("nbritems").Value);

                        T.Insert(constrainedvaluelist_id,  datatype_id, name, description, nbritems, who, notes);    
                        break;

                    case "Update":
                        constrainedvaluelist_id = GetAGuid(elm.Attribute("constrainedvaluelist_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;
                        nbritems = int.Parse(elm.Attribute("nbritems").Value);
                        datatype_id = int.Parse(elm.Attribute("datatype_id").Value);

                        //T.Update(constrainedvaluelist_id, name, description, nbritems, datatype_id, who, notes);
                        break;

                    case "Delete":
                        constrainedvaluelist_id = GetAGuid(elm.Attribute("constrainedvaluelist_id").Value);

                        //T.Delete(constrainedvaluelist_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;

                }
            }
        }

        private static void ProcessConstrainedValuesXML(XElement schema)
        {
            XElement contrainedValues = schema.Element("ConstrainedValues");
            var T = new HIS.DAL.Sql.ConstrainedValueDAL();

            Guid constrainedvalue_id;
            Guid constrainedvaluelist_id;
            string value;
            int ordinal;
            string description;

            string who = "ProcessConstrainedValuesXML";
            string notes = "";

            foreach (XElement elm in contrainedValues.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        constrainedvalue_id = GetAGuid(elm.Attribute("constrainedvalue_id").Value);
                        constrainedvaluelist_id = GetAGuid(elm.Attribute("constrainedvaluelist_id").Value);
                        value = elm.Attribute("value").Value;
                        description = elm.Attribute("description").Value;
                        ordinal = int.Parse(elm.Attribute("ordinal").Value);

                        T.Insert(constrainedvalue_id, constrainedvaluelist_id, value, description, ordinal, who, notes);
                        break;

                    case "Update":
                        constrainedvalue_id = GetAGuid(elm.Attribute("constrainedvalue_id").Value);
                        constrainedvaluelist_id = GetAGuid(elm.Attribute("constrainedvaluelist_id").Value);
                        value = elm.Attribute("value").Value;
                        description = elm.Attribute("description").Value;
                        ordinal = int.Parse(elm.Attribute("ordinal").Value);

                        //T.Update(constrainedvalue_id, constrainedvaluelist_id, value, ordinal, description, who, notes);
                        break;


                    case "Delete":
                        constrainedvalue_id = GetAGuid(elm.Attribute("constrainedvalue_id").Value);

                        //T.Delete(constrainedvalue_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;

                }
            }
        }

        private static void ProcessDataTypesXML(XElement schema)
        {
            XElement dataTypes = schema.Element("DataTypes");
            var T = new HIS.DAL.Sql.DataTypeDAL();

            int datatype_id;
            string name;
            string description;

            string who = "ProcessDataTypesXML";
            string notes = "";

            foreach (XElement elm in dataTypes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        datatype_id = int.Parse(elm.Attribute("datatype_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;

                        T.Insert(datatype_id, name, description, who, notes);    
                        break;

                    case "Update":
                        datatype_id = int.Parse(elm.Attribute("datatype_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;

                        //T.Update(datatype_id, name, description, who, notes);
                        break;

                    case "Delete":
                        datatype_id = int.Parse(elm.Attribute("datatype_id").Value);

                        //T.Delete(datatype_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;

                }
            }
        }

        private static void ProcessItemsXML(XElement schema)
        {
            XElement items = schema.Element("Items");
            var T = new HIS.DAL.Sql.ItemDAL();

            Guid item_id;
            string name;
            Guid type_id;

            string who = "ProcessItemsXML";
            string notes = "";

            foreach (XElement elm in items.Elements())
            {
                switch (elm.Name.ToString())
                {

                    case "Insert":
                        item_id = GetAGuid(elm.Attribute("item_id").Value);
                        name = elm.Attribute("name").Value;
                        type_id = GetAGuid(elm.Attribute("type_id").Value);

                        T.Insert(item_id, name, type_id, who, notes);  
                        break;

                    case "Update":
                        item_id = GetAGuid(elm.Attribute("item_id").Value);
                        name = elm.Attribute("name").Value;
                        type_id = GetAGuid(elm.Attribute("type_id").Value);

                        //T.Update(item_id, name, type_id, who, notes);
                        break;

                    case "Delete":
                        item_id = GetAGuid(elm.Attribute("item_id").Value);

                        //T.Delete(item_id, who, notes);
                        break;


                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;

                }
            }
        }

        private static void ProcessTypeAttributesXML(XElement schema)
        {
            XElement typeAttributes = schema.Element("TypeAttributes");
            var T = new HIS.DAL.Sql.TypeAttributeDAL();

            Guid typeattribute_id;
            Guid type_id;
            Guid attribute_id;
            int characteristics;
            int datatype_id;
            int version;
            string description;

            string who = "ProcessTypeAttributesXML";
            string notes = "";

            foreach (XElement elm in typeAttributes.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        typeattribute_id = GetAGuid(elm.Attribute("typeattribute_id").Value);
                        type_id = GetAGuid(elm.Attribute("type_id").Value);
                        attribute_id = GetAGuid(elm.Attribute("attribute_id").Value);
                        characteristics = int.Parse(elm.Attribute("characteristics").Value);
                        datatype_id = int.Parse(elm.Attribute("datatype_id").Value);
                        version = int.Parse(elm.Attribute("version").Value);
                        description = elm.Attribute("description").Value;

                        T.Insert(typeattribute_id, type_id, attribute_id, characteristics, datatype_id, version, description, who, notes);
                        break;

                    case "Update":
                        typeattribute_id = GetAGuid(elm.Attribute("type_id").Value);
                        type_id = GetAGuid(elm.Attribute("type_id").Value);
                        attribute_id = GetAGuid(elm.Attribute("attribute_id").Value);
                        characteristics = int.Parse(elm.Attribute("characteristics").Value);
                        datatype_id = int.Parse(elm.Attribute("datatype_id").Value);
                        version = int.Parse(elm.Attribute("version").Value);
                        description = elm.Attribute("description").Value;

                        //T.Update(typeattribute_id, type_id, attribute_id, characteristics, datatype_id, version, description, who, notes);
                        break;

                    case "Delete":
                        type_id = GetAGuid(elm.Attribute("type_id").Value);

                        //T.Delete(type_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;
                }
            }
        }

        private static void ProcessTypesXML(XElement schema)
        {
            XElement types = schema.Element("Types");
            var T = new HIS.DAL.Sql.TypeDAL();

            Guid type_id;
            string name;
            int characteristics;
            int version;
            string description;

            string who = "ProcessTypesXML";
            string notes = "";

            foreach (XElement elm in types.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        type_id = GetAGuid(elm.Attribute("type_id").Value);
                        name = elm.Attribute("name").Value;
                        characteristics = int.Parse(elm.Attribute("characteristics").Value);
                        version = int.Parse(elm.Attribute("version").Value);
                        description = elm.Attribute("description").Value;

                        T.Insert(type_id, name, characteristics, version, description, who, notes);
                        break;

                    case "Update":
                        type_id = GetAGuid(elm.Attribute("type_id").Value);
                        name = elm.Attribute("name").Value;

                        version = int.Parse(elm.Attribute("version").Value);
                        description = elm.Attribute("description").Value;

                        //T.Update(type_id, name, itemtypegroup_id, version, description, who, notes);  
                        break;

                    case "Delete":
                        type_id = GetAGuid(elm.Attribute("type_id").Value);

                        //T.Delete(type_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;

                }
            }
        }

        private static void ProcessLogFunctionsXML(XElement schema)
        {
            XElement logFunctions = schema.Element("LogFunctions");
            var T = new HIS.DAL.Sql.LogFunctionDAL();

            int logfunction_id;
            string name;
            string description;

            string who = "ProcessLogFunctionsXML";
            string notes = "";

            foreach (XElement elm in logFunctions.Elements())
            {
                switch (elm.Name.ToString())
                {
                    case "Insert":
                        logfunction_id = int.Parse(elm.Attribute("logfunction_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;

                        T.Insert(logfunction_id, name, description, who, notes);
                        break;

                    case "Update":
                        logfunction_id = int.Parse(elm.Attribute("logfunction_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;

                        //T.Update(logfunction_id, name, description, who, notes);  
                        break;

                    case "Delete":
                        logfunction_id = int.Parse(elm.Attribute("logfunction_id").Value);

                        //T.Delete(logfunction_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;
                }
            }
        }

        private static void ProcessTablesXML(XElement schema)
        {
            XElement tables = schema.Element("Tables");
            var T = new HIS.DAL.Sql.TableDAL();

            string who = "ProcessTablesXML";
            string notes = "";

            foreach (XElement elm in tables.Elements())
            {
                switch (elm.Name.ToString())
                {

                    case "Insert":
                        int table_id = int.Parse(elm.Attribute("table_id").Value);
                        string name = elm.Attribute("name").Value;
                        int version = int.Parse(elm.Attribute("version").Value);
                        string description = elm.Attribute("description").Value;

                        T.Insert(table_id, name, version, description, who, notes);
                        break;


                    case "DeleteAll":
                        T.DeleteAll(who, notes);
                        break;


                }
            }
        }

        private static void ProcessCharacteristicsXML(XElement schema)
        {
            XElement characteristics = schema.Element("Characteristics");
            var T = new HIS.DAL.Sql.CharacteristicDAL();
            int characteristic_id;
            string name;
            string description;

            string who = "ProcessCharacteristicsXML";
            string notes = "";

            foreach (XElement elm in characteristics.Elements())
            {
                switch (elm.Name.ToString())
                {

                    case "Insert":
                        characteristic_id = int.Parse(elm.Attribute("characteristic_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;

                        T.Insert(characteristic_id, name, description, who, notes); 
                        break;

                    case "Update":
                        characteristic_id = int.Parse(elm.Attribute("characteristic_id").Value);
                        name = elm.Attribute("name").Value;
                        description = elm.Attribute("description").Value;

                        //T.Update(characteristic_id, name, description, who, notes);
                        break;

                    case "Delete":
                        characteristic_id = int.Parse(elm.Attribute("characteristic_id").Value);
                        //T.Delete(characteristic_id, who, notes);
                        break;

                    case "DeleteAll":
                        T.DeleteAll(who, notes);
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