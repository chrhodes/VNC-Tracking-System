using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface IItemDAL
    {
        IDataReader Fetch();
        IDataReader Fetch2();
        IDataReader Fetch(Guid item_id);
        IDataReader Fetch2(Guid item_id);
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid item_id, string name, Guid type_id, string who, string notes);
        DateTime Update(Guid item_id, string name, Guid type_id, string who, string notes, DateTime last_changed);
        void Delete(Guid item_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
