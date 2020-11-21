using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IAssociationDAL
    {
        IDataReader Fetch();
        Guid Insert(int table_id_begin, Guid item_id_begin, int table_id_end, Guid item_id_end, Guid associationrule_id, Guid itemtypegroup_id);
        void Update(Guid association_id, int table_id_begin, Guid item_id_begin, int table_id_end, Guid item_id_end, Guid associationrule_id, Guid itemtypegroup_id);
        void Delete(Guid association_id);
    }
}
