using System;
using System.Collections.Generic;
using System.Data;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class ItemsECL2 :
      BusinessListBase<ItemsECL2, ItemEC2>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_ITEM + 25;
        private const string PLLOG_APPNAME = "HIS";

        #region Factory Methods

        internal static ItemsECL2 New()
        {
            return DataPortal.CreateChild<ItemsECL2>();
        }

        internal static ItemsECL2 Get()
        {
            return DataPortal.FetchChild<ItemsECL2>();
        }

        internal static ItemsECL2 Get(object childData)
        {
            return DataPortal.FetchChild<ItemsECL2>(childData);
        }

        private ItemsECL2()
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
                var dal = dalManager.GetProvider<HIS.DAL.IItemDAL>();

                using (var data = dal.Fetch2())
                {
                    while (data.Read())
                    {
                        var item = DataPortal.FetchChild<ItemEC2>(data);
                        Add(item);
                    }
                }
            }

            RaiseListChangedEvents = true;
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2, startTicks);
#endif
        }

        private void Child_Fetch(object childData)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            RaiseListChangedEvents = false;

            while (((IDataReader)childData).Read())
            {
                var item = DataPortal.FetchChild<ItemEC2>(childData);
                Add(item);
            }

            RaiseListChangedEvents = true;
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        #endregion
    }
}
