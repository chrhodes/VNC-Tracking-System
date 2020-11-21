using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace ODB.DAL
{
    public interface IConstrainedValueDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid constrainedvalue_id, Guid constrainedvaluelist_id, string constrainedvalue_value, int constrainedvalue_ordinal, string constrainedvalue_description, string who, string notes);
        DateTime Update(Guid constrainedvalue_id, Guid constrainedvaluelist_id, string constrainedvalue_value, int constrainedvalue_ordinal, string constrainedvalue_description, string who, string notes, DateTime last_changed);
        void Delete(Guid constrainedvalue_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
