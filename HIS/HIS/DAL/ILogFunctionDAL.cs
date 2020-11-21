using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;


namespace HIS.DAL
{
    public interface ILogFunctionDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(int log_function_id, string log_function_name, string log_function_description, string who, string notes);
        DateTime Update(int log_function_id, string log_function_name, string log_function_description, string who, string notes, DateTime last_changed);
        void Delete(int log_function_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
