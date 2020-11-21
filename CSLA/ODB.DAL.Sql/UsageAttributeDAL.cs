using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class UsageAttributeDAL : ODB.DAL.IUsageAttributeDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public int Insert(string usageattribute_name, string usageattribute_description)
        {
            throw new NotImplementedException();
        }

        public void Update(int usageattribute_id, string usageattribute_name, string usageattribute_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(int usageattribute_id)
        {
            throw new NotImplementedException();
        }
    }
}
