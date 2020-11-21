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
        Guid Insert(Guid itemtype_id, Guid attribute_id, int usage_attributes, int datatype_id, int itemtypeattribute_version, string itemtypeattribute_description);
        void Update(Guid itemtypeattribute_id, Guid itemtype_id, Guid attribute_id, int usage_attributes, int datatype_id, int itemtypeattribute_version, string itemtypeattribute_description);
        void Delete(Guid itemtypeattribute_id);
    }
}
