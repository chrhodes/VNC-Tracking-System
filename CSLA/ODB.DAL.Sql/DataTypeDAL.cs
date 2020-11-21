using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class DataTypeDAL : ODB.DAL.IDataTypeDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public int Insert(string datatype_name, string datatype_description)
        {
            throw new NotImplementedException();
        }

        public void Update(int datatype_id, string datatype_name, string datatype_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(int datatype_id)
        {
            throw new NotImplementedException();
        }
    }
}
