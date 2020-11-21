using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IItemTypeGroupDAL
    {
        IDataReader Fetch();
        Guid Insert(string itemtypegroup_name, string itemtypegroup_description);
        void Update(Guid itemtypegroup_id, string itemtypegroup_name, string itemtypegroup_description);
        void Delete(Guid itemtypegroup_id);
    }
}
