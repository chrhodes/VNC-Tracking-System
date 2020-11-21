using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IItemTypeAttributeDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid itemtypeattribute_id, Guid itemtype_id, Guid attribute_id, int usageattributes, int datatype_id, int itemtypeattribute_version, string itemtypeattribute_description, string who, string notes);
        DateTime Update(Guid itemtypeattribute_id, Guid itemtype_id, Guid attribute_id, int usageattributes, int datatype_id, int itemtypeattribute_version, string itemtypeattribute_description, string who, string notes, DateTime last_changed);
        void Delete(Guid itemtypeattribute_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
