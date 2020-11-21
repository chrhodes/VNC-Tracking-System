using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IAttributeValueDAL
    {
        IDataReader Fetch();
        Guid Insert(int table_id, Guid item_id, Guid itemtypeattribute_id, string value);
        void Update(Guid attributevalue_id, int table_id, Guid item_id, Guid itemtypeattribute_id, string value);
        void Delete(Guid attributevalue_id);
    }
}
