using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface IDataTypeDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(int datatype_id, string name, string description, string who, string notes);
        DateTime Update(int datatype_id, string name, string description, string who, string notes, DateTime last_changed);
        void Delete(int datatype_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
