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
        int Insert(string datatype_name, string datatype_description);
        void Update(int datatype_id, string datatype_name, string datatype_description);
        void Delete(int datatype_id);
    }
}
