using System;
using System.Collections.Generic;
using System.Data;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class ConstrainedValuesECL :
      BusinessListBase<ConstrainedValuesECL, ConstrainedValueEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_CONSTRAINEDVALUE + 25;
        private const string PLLOG_APPNAME = "HIS";

        #region Factory Methods

        internal static ConstrainedValuesECL New()
        {
            return DataPortal.CreateChild<ConstrainedValuesECL>();
        }

        internal static ConstrainedValuesECL Get()
        {
            return DataPortal.FetchChild<ConstrainedValuesECL>();
        }

        internal static ConstrainedValuesECL Get(object childData)
        {
            return DataPortal.FetchChild<ConstrainedValuesECL>(childData);
        }

        private ConstrainedValuesECL()
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
                var dal = dalManager.GetProvider<HIS.DAL.IConstrainedValueDAL>();

                using (var data = dal.Fetch())
                {
                    while (data.Read())
                    {
                        var item = DataPortal.FetchChild<ConstrainedValueEC>(data);
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
                var item = DataPortal.FetchChild<ConstrainedValueEC>(childData);
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
