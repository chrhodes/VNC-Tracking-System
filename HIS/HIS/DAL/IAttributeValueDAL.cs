using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface IAttributeValueDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(Guid item_id);
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid attributevalue_id, int table_id, Guid item_id, Guid type_id, string value, string who, string notes);
        DateTime Update(Guid attributevalue_id, int table_id, Guid item_id, Guid type_id, string value, string who, string notes, DateTime last_changed);
        void Delete(Guid attributevalue_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
