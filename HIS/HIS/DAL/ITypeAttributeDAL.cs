using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface ITypeAttributeDAL
    {
        IDataReader Fetch();
        IDataReader Fetch(string whereClause);
        DateTime Insert(Guid typeattribute_id, Guid type_id, Guid attribute_id, int characteristics, int datatype_id, int version, string description, string who, string notes);
        DateTime Update(Guid typeattribute_id, Guid type_id, Guid attribute_id, int characteristics, int datatype_id, int version, string description, string who, string notes, DateTime last_changed);
        void Delete(Guid type_id, string who, string notes, DateTime last_changed);
        void DeleteAll(string who, string notes);
    }
}
