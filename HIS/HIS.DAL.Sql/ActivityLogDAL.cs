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
    public class ActivityLogDAL : HIS.DAL.IActivityLogDAL
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_DAL_SQL_ACTIVITYLOG;
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
                    sqlCmd.CommandText = "ActivityLog_Select";

                    try
                    {
                        reader = sqlCmd.ExecuteReader();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2);
                        throw new ApplicationException("ActivityLog_Select");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
            return reader;
        }

        public System.Data.IDataReader Fetch(string whereClause)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 4);
#endif
            IDataReader reader = null;

            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "ActivityLog_Select";
                    sqlCmd.Parameters.AddWithValue("@whereClause", whereClause);

                    try
                    {
                        reader = sqlCmd.ExecuteReader();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 5);
                        throw new ApplicationException("ActivityLog_Select");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 6, startTicks);
#endif

            return reader;
        }

        public Guid Insert(int logfunction_id, int table_id, Guid item_id, string value, string who, string notes)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 7);
#endif
            Guid id;

            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "ActivityLog_Insert";
                    sqlCmd.Parameters.AddWithValue("@logfunction_id", logfunction_id);
                    sqlCmd.Parameters.AddWithValue("@table_id", table_id);
                    sqlCmd.Parameters.AddWithValue("@item_id", item_id);
                    sqlCmd.Parameters.AddWithValue("@value", value);
                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);

                    try
                    {
                        id = (Guid)sqlCmd.ExecuteScalar();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 8);
                        throw new ApplicationException("ActivityLog_Insert");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 9, startTicks);
#endif
            return id;
        }

        public void Update(Guid activitylog_id, int logfunction_id, int table_id, Guid item_id, string value, string who, string notes)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 10);
#endif
            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "ActivityLog_Update";
                    sqlCmd.Parameters.AddWithValue("@activitylog_id", activitylog_id);
                    sqlCmd.Parameters.AddWithValue("@logfunction_id", logfunction_id);
                    sqlCmd.Parameters.AddWithValue("@table_id", table_id);
                    sqlCmd.Parameters.AddWithValue("@item_id", item_id);
                    sqlCmd.Parameters.AddWithValue("@value", value);
                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);

                    try
                    {
                        sqlCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 11);
                        throw new ApplicationException("ActivityLog_Update");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 12, startTicks);
#endif
        }

        public void Delete(Guid activitylog_id, string who, string notes)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 13);
#endif
            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "ActivityLog_Delete";
                    sqlCmd.Parameters.AddWithValue("@activitylog_id", activitylog_id);
                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);

                    try
                    {
                        sqlCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 14);
                        throw new ApplicationException("ActivityLog_Update");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 15, startTicks);
#endif
        }

        public void DeleteAll(string who, string notes)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 16);
#endif
            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "ActivityLog_DeleteAll";
                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);

                    try
                    {
                        sqlCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 17);
                        throw new ApplicationException("ActivityLog_DeleteAll");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 18, startTicks);
#endif
        }
    }
}
