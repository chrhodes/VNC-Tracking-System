using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IItemDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid item_id, string item_name, Guid itemtype_id, string who, string notes);
        DateTime Update(Guid item_id, string item_name, Guid itemtype_id, string who, string notes, DateTime last_changed);
        void Delete(Guid item_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
