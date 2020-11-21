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
        IDataReader Fetch(string whereClause);
        DateTime Insert(int usageattribute_id, string usageattribute_name, string usageattribute_description, string who, string notes);
        DateTime Update(int usageattribute_id, string usageattribute_name, string usageattribute_description, string who, string notes, DateTime last_changed);
        void Delete(int usageattribute_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
