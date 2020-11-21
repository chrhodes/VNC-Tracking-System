using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

using Csla.Data;
using PacificLife.Life;

namespace HIS.DAL.Sql
{
    public class DALManager : HIS.DAL.IDALManager
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_DAL_SQL_DALMANAGER;
        private const string PLLOG_APPNAME = "HIS";

        private static string _typeMask = typeof(DALManager).FullName.Replace("DALManager", @"{0}");

        public T GetProvider<T>() where T : class
        {
            var typeName = string.Format(_typeMask, typeof(T).Name.Substring(1));
            var type = Type.GetType(typeName);
            if (type != null)
                return Activator.CreateInstance(type) as T;
            else
                throw new NotImplementedException(typeName);
        }

        public ConnectionManager<SqlConnection> ConnectionManager { get; private set; }

        public DALManager()
        {
            ConnectionManager = ConnectionManager<SqlConnection>.GetManager("LocalDB");
        }

        public void Dispose()
        {
            ConnectionManager.Dispose();
            ConnectionManager = null;
        }
    }
}
