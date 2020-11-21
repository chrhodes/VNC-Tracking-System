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
        int Insert(string associationtype_name, string associationtype_description);
        void Update(int associationtype_id, string associationtype_name, string associationtype_description);
        void Delete(int associationtype_id);
    }
}
