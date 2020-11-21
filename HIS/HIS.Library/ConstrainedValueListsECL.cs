using System;
using System.Collections.Generic;
using System.Data;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class ConstrainedValueListsECL :
      BusinessListBase<ConstrainedValueListsECL, ConstrainedValueListEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_CONSTRAINEDVALUELIST + 25;
        private const string PLLOG_APPNAME = "HIS";

        #region Factory Methods

        internal static ConstrainedValueListsECL New()
        {
            return DataPortal.CreateChild<ConstrainedValueListsECL>();
        }

        internal static ConstrainedValueListsECL Get()
        {
            return DataPortal.FetchChild<ConstrainedValueListsECL>();
        }

        internal static ConstrainedValueListsECL Get(object childData)
        {
            return DataPortal.FetchChild<ConstrainedValueListsECL>(childData);
        }

        private ConstrainedValueListsECL()
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
                var dal = dalManager.GetProvider<HIS.DAL.IConstrainedValueListDAL>();

                using (var data = dal.Fetch())
                {
                    while (data.Read())
                    {
                        var item = DataPortal.FetchChild<ConstrainedValueListEC>(data);
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
                var item = DataPortal.FetchChild<ConstrainedValueListEC>(childData);
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
