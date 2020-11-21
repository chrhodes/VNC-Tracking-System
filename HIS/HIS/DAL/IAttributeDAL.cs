using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface IAttributeDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid attribute_id, string name, string who, string notes);
        DateTime Update(Guid attribute_id, string name, string who, string notes, DateTime last_changed);
        void Delete(Guid attribute_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
