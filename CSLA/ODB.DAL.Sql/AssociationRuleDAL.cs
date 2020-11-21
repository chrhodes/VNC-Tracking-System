using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class AssociationRuleDAL : ODB.DAL.IAssociationRuleDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(int table_id_begin, int table_id_end, Guid item_type_id_begin, Guid item_type_id_end, int associationtype_id)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid associationrule_id, int table_id_begin, int table_id_end, Guid item_type_id_begin, Guid item_type_id_end, int associationtype_id)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid associationrule_id)
        {
            throw new NotImplementedException();
        }
    }
}
