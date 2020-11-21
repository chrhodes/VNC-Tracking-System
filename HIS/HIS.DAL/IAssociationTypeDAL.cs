using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IAssociationTypeDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(int associationtype_id, string associationtype_name, string associationtype_description, string who, string notes);
        DateTime Update(int associationtype_id, string associationtype_name, string associationtype_description, string who, string notes, DateTime last_changed);
        void Delete(int associationtype_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
