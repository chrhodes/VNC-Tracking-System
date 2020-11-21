using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class TableDAL : ODB.DAL.ITableDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public int Insert(string table_name, int table_version, string table_description)
        {
            throw new NotImplementedException();
        }

        public void Update(int table_id, string table_name, int table_version, string table_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(int table_id)
        {
            throw new NotImplementedException();
        }
    }
}
