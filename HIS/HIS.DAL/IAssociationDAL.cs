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
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid association_id, int table_id_begin, Guid item_id_begin, int table_id_end, Guid item_id_end, Guid associationrule_id, Guid itemtypegroup_id, string who, string notes);
        DateTime Update(Guid association_id, int table_id_begin, Guid item_id_begin, int table_id_end, Guid item_id_end, Guid associationrule_id, Guid itemtypegroup_id, string who, string notes, DateTime last_changed);
        void Delete(Guid association_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
