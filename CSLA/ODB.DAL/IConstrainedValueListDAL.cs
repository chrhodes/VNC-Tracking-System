using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IConstrainedValueListDAL
    {
        IDataReader Fetch();
        Guid Insert(String constrainedvaluelist_name, string constrainedvaluelist_description, int constrainedvaluelist_nbritems, int constrainedvaluelist_datatype_id);
        void Update(Guid constrainedvaluelist_id, String constrainedvaluelist_name, string constrainedvaluelist_description, int constrainedvaluelist_nbritems, int constrainedvaluelist_datatype_id);
        void Delete(Guid constrainedvaluelist_id);
    }
}
