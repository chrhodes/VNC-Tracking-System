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
        Guid Insert(Guid constrainedvaluelist_id, string constrainedvalue_value, int constrainedvalue_ordinal, string constrainedvalue_description);
        void Update(Guid constrainedvalue_id, Guid constrainedvaluelist_id, string constrainedvalue_value, int constrainedvalue_ordinal, string constrainedvalue_description);
        void Delete(Guid constrainedvalue_id);
    }
}
