using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface ITableDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(int table_id, string table_name, int table_version, string table_description, string who, string notes);
        DateTime Update(int table_id, string table_name, int table_version, string table_description, string who, string notes, DateTime last_changed);
        void Delete(int table_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
