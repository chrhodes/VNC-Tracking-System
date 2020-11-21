using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface ITableDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(int table_id, string name, int version, string description, string who, string notes);
        DateTime Update(int table_id, string name, int version, string description, string who, string notes, DateTime last_changed);
        void Delete(int table_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
