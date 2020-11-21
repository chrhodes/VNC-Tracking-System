using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class AssociationDAL : ODB.DAL.IAssociationDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(int table_id_begin, Guid item_id_begin, int table_id_end, Guid item_id_end, Guid associationrule_id, Guid itemtypegroup_id)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid association_id, int table_id_begin, Guid item_id_begin, int table_id_end, Guid item_id_end, Guid associationrule_id, Guid itemtypegroup_id)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid association_id)
        {
            throw new NotImplementedException();
        }
    }
}
