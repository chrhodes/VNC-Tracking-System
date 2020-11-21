using System;
using System.Collections.Generic;
using System.Data;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class TablesECL :
      BusinessListBase<TablesECL, TableEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_TABLE;
        private const string PLLOG_APPNAME = "HIS";

        #region Factory Methods

        internal static TablesECL New()
        {
            return DataPortal.CreateChild<TablesECL>();
        }

        internal static TablesECL Get()
        {
            return DataPortal.FetchChild<TablesECL>();
        }

        internal static TablesECL Get(object childData)
        {
            return DataPortal.FetchChild<TablesECL>(childData);
        }

        private TablesECL()
        { }

        #endregion

        #region Data Access

        private void Child_Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            RaiseListChangedEvents = false;

            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.ITableDAL>();

                using (var data = dal.Fetch())
                {
                    while (data.Read())
                    {
                        var item = DataPortal.FetchChild<TableEC>(data);
                        Add(item);
                    }
                }
            }

            RaiseListChangedEvents = true;
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        private void Child_Fetch(object childData)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            RaiseListChangedEvents = false;

            //using (var dalManager = HIS.DAL.DALFactory.GetManager())
            //{
            //    var dal = dalManager.GetProvider<HIS.DAL.ITableDAL>();

            //    using (var data = dal.Fetch())
            //    {
                    while (((IDataReader)childData).Read())
                    {
                        var item = DataPortal.FetchChild<TableEC>(childData);
                        Add(item);
                    }
            //    }
            //}

            RaiseListChangedEvents = true;
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        #endregion
    }
}
