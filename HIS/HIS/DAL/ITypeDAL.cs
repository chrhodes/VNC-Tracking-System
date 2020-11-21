using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface ITypeDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid type_id, string name, int characteristics, int version, string description, string who, string notes);
        DateTime Update(Guid type_id, string name, int characteristics, int version, string description, string who, string notes, DateTime last_changed);
        void Delete(Guid type_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
