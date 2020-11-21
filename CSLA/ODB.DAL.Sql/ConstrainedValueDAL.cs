using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class ConstrainedValueDAL : ODB.DAL.IConstrainedValueDAL
    {
        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(Guid constrainedvaluelist_id, string constrainedvalue_value, int constrainedvalue_ordinal, string constrainedvalue_description)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid constrainedvalue_id, Guid constrainedvaluelist_id, string constrainedvalue_value, int constrainedvalue_ordinal, string constrainedvalue_description)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid constrainedvalue_id)
        {
            throw new NotImplementedException();
        }
    }
}
