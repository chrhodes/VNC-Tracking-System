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
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid associationrule_id, int table_id_begin, int table_id_end, Guid item_type_id_begin, Guid item_type_id_end, int associationtype_id, string who, string notes);
        DateTime Update(Guid associationrule_id, int table_id_begin, int table_id_end, Guid item_type_id_begin, Guid item_type_id_end, int associationtype_id, string who, string notes, DateTime last_changed);
        void Delete(Guid associationrule_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
