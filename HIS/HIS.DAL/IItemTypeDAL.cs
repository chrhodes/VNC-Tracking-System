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
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid itemtype_id, string itemtype_name, Guid itemtypegroup_id, int itemtype_version, string itemtype_description, string who, string notes);
        DateTime Update(Guid itemtype_id, string itemtype_name, Guid itemtypegroup_id, int itemtype_version, string itemtype_description, string who, string notes, DateTime last_changed);
        void Delete(Guid itemtype_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
