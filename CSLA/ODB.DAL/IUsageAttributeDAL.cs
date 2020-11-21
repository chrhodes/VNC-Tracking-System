using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IUsageAttributeDAL
    {
        IDataReader Fetch();
        int Insert(string usageattribute_name, string usageattribute_description);
        void Update(int usageattribute_id, string usageattribute_name, string usageattribute_description);
        void Delete(int usageattribute_id);
    }
}
