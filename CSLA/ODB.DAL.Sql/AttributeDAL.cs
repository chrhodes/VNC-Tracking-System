using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class AttributeDAL : ODB.DAL.IAttributeDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(string attribute_name)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid attribute_id, string name)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid attribute_id)
        {
            throw new NotImplementedException();
        }
    }
}
