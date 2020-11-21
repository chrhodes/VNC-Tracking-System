using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class ItemTypeGroupDAL : ODB.DAL.IItemTypeGroupDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(string itemtypegroup_name, string itemtypegroup_description)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid itemtypegroup_id, string itemtypegroup_name, string itemtypegroup_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid itemtypegroup_id)
        {
            throw new NotImplementedException();
        }
    }
}
