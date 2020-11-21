using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IDataTypeDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(int datatype_id, string datatype_name, string datatype_description, string who, string notes);
        DateTime Update(int datatype_id, string datatype_name, string datatype_description, string who, string notes, DateTime last_changed);
        void Delete(int datatype_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
