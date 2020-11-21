using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface ICharacteristicDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(int characteristic_id, string name, string description, string who, string notes);
        DateTime Update(int characteristic_id, string name, string description, string who, string notes, DateTime last_changed);
        void Delete(int characteristic_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
