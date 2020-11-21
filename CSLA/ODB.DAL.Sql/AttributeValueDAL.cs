using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class AttributeValueDAL : ODB.DAL.IAttributeValueDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(int table_id, Guid item_id, Guid itemtypeattribute_id, string value)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid attributevalue_id, int table_id, Guid item_id, Guid itemtypeattribute_id, string value)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid attributevalue_id)
        {
            throw new NotImplementedException();
        }
    }
}
