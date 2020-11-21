using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class LogFunctionDAL : ODB.DAL.ILogFunctionDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public int Insert(string log_function_name, string log_function_description)
        {
            throw new NotImplementedException();
        }

        public void Update(int log_function_id, string log_function_name, string log_function_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(int log_function_id)
        {
            throw new NotImplementedException();
        }
    }
}
