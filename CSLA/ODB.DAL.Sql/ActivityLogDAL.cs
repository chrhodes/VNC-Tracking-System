using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL.Sql
{
    class ActivityLogDAL : ODB.DAL.IActivityLogDAL
    {

        public System.Data.IDataReader Fetch()
        {
            throw new NotImplementedException();
        }

        public Guid Insert(int table_id, Guid item_id, int logfunction_id, string value, string who, DateTime when, string notes)
        {
            throw new NotImplementedException();
        }

        public void Update(Guid activity_log_id, int table_id, Guid item_id, int logfunction_id, string value, string who, DateTime when, string notes)
        {
            throw new NotImplementedException();
        }

        public void Delete(Guid activity_log_id)
        {
            throw new NotImplementedException();
        }
    }
}
