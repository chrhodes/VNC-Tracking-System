using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

using Csla.Data;

namespace ODB.DAL.Sql
{
    public class DALManager : ODB.DAL.IDALManager
    {
        private static string _typeMask = typeof(DALManager).FullName.Replace("DalManager", @"{0}");

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
            ConnectionManager = ConnectionManager<SqlConnection>.GetManager("LocalDb");
        }

        public void Dispose()
        {
            ConnectionManager.Dispose();
            ConnectionManager = null;
        }
    }
}
