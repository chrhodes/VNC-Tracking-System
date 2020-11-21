using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class ConstrainedValueListDAL : ODB.DAL.IConstrainedValueListDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(string constrainedvaluelist_name, string constrainedvaluelist_description, int constrainedvaluelist_nbritems, int constrainedvaluelist_datatype_id)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid constrainedvaluelist_id, string constrainedvaluelist_name, string constrainedvaluelist_description, int constrainedvaluelist_nbritems, int constrainedvaluelist_datatype_id)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid constrainedvaluelist_id)
        {
            throw new NotImplementedException();
        }
    }
}
