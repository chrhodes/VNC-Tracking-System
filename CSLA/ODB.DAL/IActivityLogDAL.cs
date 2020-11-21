using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;


namespace ODB.DAL
{
    public interface IActivityLogDAL
    {
        IDataReader Fetch();
        Guid Insert(int table_id, Guid item_id, int logfunction_id, string value, string who, DateTime when, string notes);
        void Update(Guid activity_log_id, int table_id, Guid item_id, int logfunction_id, string value, string who, DateTime when, string notes);
        void Delete(Guid activity_log_id);
    }
}
