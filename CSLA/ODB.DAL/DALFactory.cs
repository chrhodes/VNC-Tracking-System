using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace ODB.DAL
{
    public static class DALFactory
    {
        private static Type _dalType;

        private static IDALManager GetManager()
        {
            if (_dalType == null)
            {
                var dalTypeName = ConfigurationManager.AppSettings["DalManagerType"];

                if ( ! string.IsNullOrEmpty(dalTypeName))
                {
                	_dalType = Type.GetType(dalTypeName);
                }
                else
                {
                    throw new NullReferenceException("DalManagerType");
                }

                if (_dalType == null)
                {
                	throw new ArgumentException(string.Format("Type {0} could not be found", dalTypeName));
                }
            }

            return (IDALManager)Activator.CreateInstance(_dalType);
        }
    }
}
