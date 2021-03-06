﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IConstrainedValueListDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid constrainedvaluelist_id, String constrainedvaluelist_name, string constrainedvaluelist_description, int constrainedvaluelist_nbritems, int constrainedvaluelist_datatype_id, string who, string notes);
        DateTime Update(Guid constrainedvaluelist_id, String constrainedvaluelist_name, string constrainedvaluelist_description, int constrainedvaluelist_nbritems, int constrainedvaluelist_datatype_id, string who, string notes, DateTime last_changed);
        void Delete(Guid constrainedvaluelist_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
