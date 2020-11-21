using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

using Csla.Data;
using PacificLife.Life;

namespace HIS.DAL.Sql
{
    public class SchemaDAL : HIS.DAL.ISchemaDAL
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_DAL_SQL_SCHEMA;
        private const string PLLOG_APPNAME = "HIS";

        public System.Data.IDataReader Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif

            IDataReader reader = null;

            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "Schema_SelectAll";

                    try
                    {
                        reader = sqlCmd.ExecuteReader();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2);
                        throw new ApplicationException("Schema_SelectAll");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
            return reader;
        }

    }
}

