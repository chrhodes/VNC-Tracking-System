using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Xml;

using PacificLife.Life;

namespace ODB
{
    
    public class ODBHelper
    {
        internal static ODBClassesDataContext odbContext = new ODBClassesDataContext();

        public class Schema
        {

            public void ProcessXML(XmlDocument doc)
            {
                // XML elements can be processed in any order until referential rules
                // are added to the database.  For now, try to keep these in a sensible
                // order where the support tables are populated before the content tables.

                ProcessTablesXML(doc);
                ProcessLogFunctionsXML(doc);

                // These tables govern the types of items that can be stored in the ODB,
                // their attributes, and the characteristics of those attributes including
                // attributes whose values are constrained.

                ProcessDataTypesXML(doc);
                ProcessUsageAttributesXML(doc);

                ProcessItemTypeGroupsXML(doc);
                ProcessItemTypesXML(doc);
                ProcessAttributesXML(doc);
                ProcessItemTypeAttributesXML(doc);
                ProcessConstrainedValueListsXML(doc);
                ProcessConstrainedValuesXML(doc);

                // These tables goven the types of associations that can exist between
                // items in the ODB.

                ProcessAssociationTypesXML(doc);
                ProcessAssociationRulesXML(doc);

                // These tables store the items and their attributes, and any associations

                ProcessAssociationsXML(doc);
                ProcessItemsXML(doc);
                ProcessAttributeValuesXML(doc);
            }

            public void ProcessAssociationRulesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//AssociationRules");

                    if (element == null) return;

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "AssociationRule":
                                string id = node.Attributes.GetNamedItem("id").Value;

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                int tablebegin = int.Parse(node.Attributes.GetNamedItem("tablebegin").Value);
                                Guid itembegin = new Guid(node.Attributes.GetNamedItem("itembegin").Value);
                                int tableend = int.Parse(node.Attributes.GetNamedItem("tablebegin").Value);
                                Guid itemend = new Guid(node.Attributes.GetNamedItem("itemend").Value);
                                int associationtype = int.Parse(node.Attributes.GetNamedItem("associationtype").Value);

                                //ODBHelper.odbContext.AssociationRules_Insert(gid, tablebegin, itembegin, tableend, itemend, associationtype, "crhodes", "");

                                //using (var ctx = ContextManager<ProjectTracker.DalLinq.PTrackerDataContext>.GetManager(ProjectTracker.DalLinq.Database.PTracker))
                                //{
                                //    System.Data.Linq.Binary lastChanged = null;
                                //    ctx.DataContext.addAssignment(projectId, resourceId, assigned, role, ref lastChanged);
                                //    return lastChanged.ToArray();
                                //}

                                using (var ctx = ContextManager<ODBClassesDataContext>.GetManager("ODB"))
                                {
                                    System.Data.Linq.Binary lastChanged = null;
                                    ctx.DataContext.AssociationRules_Insert(gid, tablebegin, itembegin, tableend, itemend, associationtype, "crhodes", "");
                                    //return lastChanged.ToArray();
                                }

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.AssociationRules
                                           select r;

                                foreach (AssociationRule row in rows)
                                {
                                    odbContext.AssociationRules.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessAssociationsXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//Associations");

                    if (element == null) return;

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "Association":
                                string id = node.Attributes.GetNamedItem("id").Value;

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                int tablebegin = int.Parse(node.Attributes.GetNamedItem("tablebegin").Value);
                                Guid itembegin = new Guid(node.Attributes.GetNamedItem("itembegin").Value);
                                int tableend = int.Parse(node.Attributes.GetNamedItem("tablebegin").Value);
                                Guid itemend = new Guid(node.Attributes.GetNamedItem("itemend").Value);
                                Guid associationrule = new Guid(node.Attributes.GetNamedItem("associationrule").Value);
                                Guid itemtypegroup = new Guid(node.Attributes.GetNamedItem("itemtypegroup").Value);

                                ODBHelper.odbContext.Associations_Insert(gid, tablebegin, itembegin, tableend, itemend, associationrule, itemtypegroup, "crhodes", "");

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.Associations
                                           select r;

                                foreach (Association row in rows)
                                {
                                    odbContext.Associations.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();
                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessAssociationTypesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//AssociationTypes");

                    if (element == null) return;

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "AssociationType":
                                int id = int.Parse(node.Attributes.GetNamedItem("id").Value);
                                string name = node.Attributes.GetNamedItem("name").Value;
                                string description = node.Attributes.GetNamedItem("description").Value;

                                odbContext.AssociationTypes_Insert(id, name, description, "crhodes", "");

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.AssociationTypes
                                           select r;

                                foreach (AssociationType row in rows)
                                {
                                    odbContext.AssociationTypes.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                PLLog.Info(string.Format("Unsupported element: {0}", node.Name), "ODB");
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessAttributesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//Attributes");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "Attribute":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                string name = node.Attributes.GetNamedItem("name").Value;

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                ODBHelper.odbContext.Attributes_Insert(gid, name, "crhodes", "");
                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.Attributes
                                           select r;

                                foreach (ODB.Attribute row in rows)
                                {
                                    odbContext.Attributes.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessAttributeValuesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//AttributeValues");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "AttributeValue":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                int table = int.Parse(node.Attributes.GetNamedItem("table").Value);
                                Guid item = new Guid(node.Attributes.GetNamedItem("item").Value);
                                Guid itemtypeattribute = new Guid(node.Attributes.GetNamedItem("itemtypeattribute").Value);
                                string value = node.Attributes.GetNamedItem("value").Value;

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                ODBHelper.odbContext.AttributeValues_Insert(gid, table, item, itemtypeattribute,  value, "crhodes", "");
                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.AttributeValues
                                           select r;

                                foreach (AttributeValue row in rows)
                                {
                                    odbContext.AttributeValues.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessConstrainedValueListsXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//ConstrainedValueLists");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "ConstrainedValueList":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                string name = node.Attributes.GetNamedItem("name").Value;
                                string description = node.Attributes.GetNamedItem("description").Value;
                                int numberitems = int.Parse(node.Attributes.GetNamedItem("numberitems").Value);
                                int datatype = int.Parse(node.Attributes.GetNamedItem("datatype").Value);

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                // This returns exception: 		Message	"Invalid object name 'constrainedvaluelists'."
                                // Turns out Stored Procedure was calling table constrainedvaluelists.  Table name
                                // is ConstrainedValueLists.  Seems like tables can be case sensitive.
                                ODBHelper.odbContext.ConstrainedValueLists_Insert(gid, name, description, numberitems, datatype, "crhodes", "");

                                //ConstrainedValueList cvl = new ConstrainedValueList();

                                //cvl.constrainedvaluelist_id = gid;
                                //cvl.constrainedvaluelist_name = name;
                                //cvl.constrainedvaluelist_description = description;
                                //cvl.constrainedvaluelist_nbritems = numberitems;
                                //cvl.constrainedvaluelist_datatype_id = datatype;
                                //odbContext.ConstrainedValueLists.InsertOnSubmit(cvl);
                                //odbContext.SubmitChanges();

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.ConstrainedValueLists
                                           select r;

                                foreach (ConstrainedValueList row in rows)
                                {
                                    odbContext.ConstrainedValueLists.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessConstrainedValuesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//ConstrainedValues");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "ConstrainedValue":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                Guid cvlid = new Guid(node.Attributes.GetNamedItem("cvlid").Value);
                                string value = node.Attributes.GetNamedItem("value").Value;
                                int ordinal = int.Parse(node.Attributes.GetNamedItem("ordinal").Value);
                                string description = node.Attributes.GetNamedItem("description").Value;


                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                ODBHelper.odbContext.ConstrainedValues_Insert(gid, cvlid, value, ordinal, description, "crhodes", "");

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.ConstrainedValues
                                           select r;

                                foreach (ConstrainedValue row in rows)
                                {
                                    odbContext.ConstrainedValues.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessDataTypesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//DataTypes");

                    if (element == null) return;

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "DataType":
                                int id = int.Parse(node.Attributes.GetNamedItem("id").Value);
                                string name = node.Attributes.GetNamedItem("name").Value;
                                string description = node.Attributes.GetNamedItem("description").Value;

                                // For some reason this fails with exception: 		Message	"Operand type clash: int is incompatible with uniqueidentifier"
                                // Turns out it was on ActivityLog_Insert.  Expected

                                odbContext.DataTypes_Insert(id, name, description, "crhodes", "");

                                //DataType dataType = new DataType();

                                //dataType.datatype_id = id;
                                //dataType.datatype_name = name;
                                //dataType.datatype_description = description;
                                //odbContext.DataTypes.InsertOnSubmit(dataType);
                                //odbContext.SubmitChanges();

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.DataTypes
                                           select r;

                                foreach (DataType row in rows)
                                {
                                    odbContext.DataTypes.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                PLLog.Info(string.Format("Unsupported element: {0}", node.Name), "ODB");
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessItemsXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//Items");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "Item":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                string name = node.Attributes.GetNamedItem("name").Value;
                                Guid itemtype = new Guid(node.Attributes.GetNamedItem("itemtype").Value);

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                ODBHelper.odbContext.Items_Insert(gid, name, itemtype, "crhodes", "");
                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.Items
                                           select r;

                                foreach (Item row in rows)
                                {
                                    odbContext.Items.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            void ProcessItemTypeAttributesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//ItemTypeAttributes");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "ItemTypeAttribute":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                Guid itemtype = new Guid(node.Attributes.GetNamedItem("itemtype").Value);
                                Guid attribute = new Guid(node.Attributes.GetNamedItem("attribute").Value);
                                int usageattributes = int.Parse(node.Attributes.GetNamedItem("usageattributes").Value);
                                int datatype = int.Parse(node.Attributes.GetNamedItem("datatype").Value);
                                int version = int.Parse(node.Attributes.GetNamedItem("version").Value);
                                string description = node.Attributes.GetNamedItem("description").Value;

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                ODBHelper.odbContext.ItemTypeAttributes_Insert(gid, itemtype, attribute, usageattributes, datatype, version, description, "crhodes", "");
                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.ItemTypeAttributes
                                           select r;

                                foreach (ODB.ItemTypeAttribute row in rows)
                                {
                                    odbContext.ItemTypeAttributes.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessItemTypeGroupsXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//ItemTypeGroups");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "ItemTypeGroup":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                string name = node.Attributes.GetNamedItem("name").Value;
                                string description = node.Attributes.GetNamedItem("description").Value;

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                ODBHelper.odbContext.ItemTypeGroups_Insert(gid, name, description, "crhodes", "");
                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.ItemTypeGroups
                                           select r;

                                foreach (ItemTypeGroup row in rows)
                                {
                                    odbContext.ItemTypeGroups.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessItemTypesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//ItemTypes");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "ItemType":
                                string id = node.Attributes.GetNamedItem("id").Value;
                                string name = node.Attributes.GetNamedItem("name").Value;
                                string group = node.Attributes.GetNamedItem("group").Value;
                                int version = int.Parse(node.Attributes.GetNamedItem("version").Value);
                                string description = node.Attributes.GetNamedItem("description").Value;

                                if (id == "NewGuid") id = Guid.NewGuid().ToString();

                                Guid gid = new Guid(id);

                                if (group == "")
                                {
                                    ODBHelper.odbContext.ItemTypes_Insert(gid, name, null, version, description, "crhodes", "");
                                }
                                else
                                {
                                    Guid ggroup = new Guid(group);
                                    ODBHelper.odbContext.ItemTypes_Insert(gid, name, ggroup, version, description, "crhodes", "");
                                }
                                
                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.ItemTypes
                                           select r;

                                foreach (ItemType row in rows)
                                {
                                    odbContext.ItemTypes.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessLogFunctionsXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//LogFunctions");

                    if (element == null) return;

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "LogFunction":
                                int id = int.Parse(node.Attributes.GetNamedItem("id").Value);
                                string name = node.Attributes.GetNamedItem("name").Value;
                                string description = node.Attributes.GetNamedItem("description").Value;
                                
                                LogFunction logFunction = new LogFunction();

                                logFunction.logfunction_id = id;
                                logFunction.logfunction_name = name;
                                logFunction.logfunction_description = description;
                                odbContext.LogFunctions.InsertOnSubmit(logFunction);
                                odbContext.SubmitChanges();

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.LogFunctions
                                               select r;

                                foreach (LogFunction row in rows)
                                {
                                    odbContext.LogFunctions.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                PLLog.Info(string.Format("Unsupported element: {0}", node.Name), "ODB");
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessTablesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//Tables");

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "Table":
                                // Hum, this works in VB !
                                //string id = node.Attributes("id").Value();

                                int id = int.Parse(node.Attributes.GetNamedItem("id").Value);
                                string name = node.Attributes.GetNamedItem("name").Value;
                                int version = int.Parse(node.Attributes.GetNamedItem("version").Value);
                                string description = node.Attributes.GetNamedItem("description").Value;
                                
                                ODBHelper.odbContext.Tables_Insert(id, name, version, description);
                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.Tables
                                               select r;

                                foreach (Table row in rows)
                                {
                                    odbContext.Tables.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }

            public void ProcessUsageAttributesXML(XmlDocument doc)
            {
                PLLog.Trace("Enter Method", "ODB");

                try
                {
                    XmlNode element = doc.DocumentElement.SelectSingleNode("//UsageAttributes");

                    if (element == null) return;

                    foreach (XmlNode node in element.ChildNodes)
                    {
                        switch (node.Name)
                        {
                            case "UsageAttribute":
                                int id = int.Parse(node.Attributes.GetNamedItem("id").Value);
                                string name = node.Attributes.GetNamedItem("name").Value;
                                string description = node.Attributes.GetNamedItem("description").Value;

                                // For some reason this fails with exception - Message	"Invalid object name 'usageAttributes'."

                                odbContext.UsageAttributes_Insert(id, name, description, "crhodes", "");

                                //UsageAttribute usageAttribute = new UsageAttribute();

                                //usageAttribute.usageattribute_id = id;
                                //usageAttribute.usageattribute_name = name;
                                //usageAttribute.usageattribute_description = description;
                                //odbContext.UsageAttributes.InsertOnSubmit(usageAttribute);
                                //odbContext.SubmitChanges();

                                break;

                            case "ClearAll":
                                var rows = from r in odbContext.UsageAttributes
                                           select r;

                                foreach (UsageAttribute row in rows)
                                {
                                    odbContext.UsageAttributes.DeleteOnSubmit(row);
                                }

                                odbContext.SubmitChanges();

                                break;

                            default:
                                PLLog.Info(string.Format("Unsupported element: {0}", node.Name), "ODB");
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    PLLog.Error(ex, "ODB");
                    throw;
                }

                PLLog.Trace("Exit Method", "ODB");
            }
        }
    }
}
