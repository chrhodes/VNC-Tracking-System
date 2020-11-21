﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

using Csla.Data;
using PacificLife.Life;

namespace HIS.DAL.Sql
{
    public class CharacteristicDAL : HIS.DAL.ICharacteristicDAL
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_DAL_SQL_CHARACTERISTIC;
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
                    sqlCmd.CommandText = "Characteristics_Select";

                    try
                    {
                        reader = sqlCmd.ExecuteReader();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2); 
                        throw new ApplicationException("Characteristics_Select");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
            return reader;
        }

        public IDataReader Fetch(string whereClause)
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
                    sqlCmd.CommandText = "Characteristics_Select";
                    sqlCmd.Parameters.AddWithValue("@whereClause", whereClause);

                    try
                    {
                        reader = sqlCmd.ExecuteReader();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 5);
                        throw new ApplicationException("Characteristics_Select");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 6, startTicks);
#endif
            return reader;
        }

        public DateTime Insert(int characteristic_id, string name, string description, string who, string notes)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 7);
#endif
            DateTime lastUpdateTime;

            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "Characteristics_Insert";

                    sqlCmd.Parameters.AddWithValue("@characteristic_id", characteristic_id);
                    sqlCmd.Parameters.AddWithValue("@name", name);
                    sqlCmd.Parameters.AddWithValue("@description", description);

                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);

                    try
                    {
                        lastUpdateTime = (DateTime)sqlCmd.ExecuteScalar();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 8);
                        throw new ApplicationException("Characteristics_Insert");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 9, startTicks);
#endif
            return lastUpdateTime;
        }

        public DateTime Update(int characteristic_id, string name, string description, string who, string notes, DateTime last_changed)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 10);
#endif
            DateTime lastUpdateTime;

            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "Characteristics_Update";

                    sqlCmd.Parameters.AddWithValue("@characteristic_id", characteristic_id);
                    sqlCmd.Parameters.AddWithValue("@name", name);
                    sqlCmd.Parameters.AddWithValue("@description", description);

                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);
                    sqlCmd.Parameters.AddWithValue("@last_changed", last_changed);

                    try
                    {
                        lastUpdateTime = (DateTime)sqlCmd.ExecuteScalar();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 11);
                        throw new ApplicationException("Characteristics_Update");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 12, startTicks);
#endif
            return lastUpdateTime;
        }

        public void Delete(int characteristic_id, string who, string notes, DateTime last_changed)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 13);
#endif
            using (var sqlConn = ConnectionManager<SqlConnection>.GetManager("LocalDB"))
            {
                using (var sqlCmd = sqlConn.Connection.CreateCommand())
                {
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.CommandText = "Characteristics_Delete";

                    sqlCmd.Parameters.AddWithValue("@characteristic_id", characteristic_id);

                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);
                    sqlCmd.Parameters.AddWithValue("@last_changed", last_changed);

                    try
                    {
                        sqlCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 14);
                        throw new ApplicationException("Characteristics_Delete");
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
                    sqlCmd.CommandText = "Characteristics_DeleteAll";
                    sqlCmd.Parameters.AddWithValue("@who", who);
                    sqlCmd.Parameters.AddWithValue("@notes", notes);

                    try
                    {
                        sqlCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        PLLog.Error(ex, PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 17);
                        throw new ApplicationException("Characteristics_DeleteAll");
                    }
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 18, startTicks);
#endif
        }
    }
}
