using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IItemTypeDAL
    {
        IDataReader Fetch();
        Guid Insert(string itemtype_name, Guid itemtypegroup_id, int itemtype_version, string itemtype_description);
        void Update(Guid itemtype_id, string itemtype_name, Guid itemtypegroup_id, int itemtype_version, string itemtype_description);
        void Delete(Guid itemtype_id);
    }
}
