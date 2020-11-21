using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IAssociationRuleDAL
    {
        IDataReader Fetch();
        Guid Insert(int table_id_begin, int table_id_end, Guid item_type_id_begin, Guid item_type_id_end, int associationtype_id);
        void Update(Guid associationrule_id, int table_id_begin, int table_id_end, Guid item_type_id_begin, Guid item_type_id_end, int associationtype_id);
        void Delete(Guid associationrule_id);
    }
}
