using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;


namespace ODB.DAL
{
    public interface ILogFunctionDAL
    {
        IDataReader Fetch();
        int Insert(string log_function_name, string log_function_description);
        void Update(int log_function_id, string log_function_name, string log_function_description);
        void Delete(int log_function_id);
    }
}
