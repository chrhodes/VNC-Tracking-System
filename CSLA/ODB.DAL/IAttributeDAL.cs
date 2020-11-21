using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IAttributeDAL
    {
        IDataReader Fetch();
        Guid Insert(string attribute_name);
        void Update(Guid attribute_id, string name);
        void Delete(Guid attribute_id);
    }
}
