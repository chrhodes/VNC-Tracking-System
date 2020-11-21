using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class ItemTypeDAL : ODB.DAL.IItemTypeDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(string itemtype_name, Guid itemtypegroup_id, int itemtype_version, string itemtype_description)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid itemtype_id, string itemtype_name, Guid itemtypegroup_id, int itemtype_version, string itemtype_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid itemtype_id)
        {
            throw new NotImplementedException();
        }
    }
}
