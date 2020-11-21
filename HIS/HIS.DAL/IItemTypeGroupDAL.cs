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
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid itemtypegroup_id, string itemtypegroup_name, string itemtypegroup_description, string who, string notes);
        DateTime Update(Guid itemtypegroup_id, string itemtypegroup_name, string itemtypegroup_description, string who, string notes, DateTime last_changed);
        void Delete(Guid itemtypegroup_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
