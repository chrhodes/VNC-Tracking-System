using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class AssociationTypeDAL : ODB.DAL.IAssociationTypeDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public int Insert(string associationtype_name, string associationtype_description)
        {
            throw new NotImplementedException();
        }

        public void Update(int associationtype_id, string associationtype_name, string associationtype_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(int associationtype_id)
        {
            throw new NotImplementedException();
        }
    }
}
