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
        int Insert(string table_name, int table_version, string table_description);
        void Update(int table_id, string table_name, int table_version, string table_description);
        void Delete(int table_id);
    }
}
