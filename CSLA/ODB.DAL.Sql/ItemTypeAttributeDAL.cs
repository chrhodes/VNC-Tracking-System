using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class ItemTypeAttributeDAL : ODB.DAL.IItemTypeAttributeDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(Guid itemtype_id, Guid attribute_id, int usage_attributes, int datatype_id, int itemtypeattribute_version, string itemtypeattribute_description)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid itemtypeattribute_id, Guid itemtype_id, Guid attribute_id, int usage_attributes, int datatype_id, int itemtypeattribute_version, string itemtypeattribute_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid itemtypeattribute_id)
        {
            throw new NotImplementedException();
        }
    }
}
