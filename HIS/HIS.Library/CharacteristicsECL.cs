using System;
using System.Collections.Generic;
using System.Data;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class CharacteristicsECL :
      BusinessListBase<CharacteristicsECL, CharacteristicEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_CHARACTERISTIC + 25;
        private const string PLLOG_APPNAME = "HIS";

        #region Factory Methods

        internal static CharacteristicsECL New()
        {
            return DataPortal.CreateChild<CharacteristicsECL>();
        }

        internal static CharacteristicsECL Get()
        {
            return DataPortal.FetchChild<CharacteristicsECL>();
        }

        internal static CharacteristicsECL Get(object childData)
        {
            return DataPortal.FetchChild<CharacteristicsECL>(childData);
        }

        private CharacteristicsECL()
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
                var dal = dalManager.GetProvider<HIS.DAL.ICharacteristicDAL>();

                using (var data = dal.Fetch())
                {
                    while (data.Read())
                    {
                        var item = DataPortal.FetchChild<CharacteristicEC>(data);
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

            while (((IDataReader)childData).Read())
            {
                var item = DataPortal.FetchChild<CharacteristicEC>(childData);
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
