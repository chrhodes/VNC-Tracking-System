using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class ConstrainedValueEC : BusinessBase<ConstrainedValueEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_CONSTRAINEDVALUE;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id);
        public Guid Id
        {
            get { return GetProperty(IdProperty); }
            set { SetProperty(IdProperty, value); }
        }

        public static readonly PropertyInfo<Guid> ConstrainedValueListIdProperty = RegisterProperty<Guid>(p => p.ConstrainedValueListId);
        public Guid ConstrainedValueListId
        {
            get { return GetProperty(ConstrainedValueListIdProperty); }
            set { SetProperty(ConstrainedValueListIdProperty, value); }
        }

        public static readonly PropertyInfo<string> ValueProperty = RegisterProperty<string>(p => p.Value);
        public string Value
        {
            get { return GetProperty(ValueProperty); }
            set { SetProperty(ValueProperty, value); }
        }

        public static readonly PropertyInfo<int> OrdinalProperty = RegisterProperty<int>(p => p.Ordinal);
        public int Ordinal
        {
            get { return GetProperty(OrdinalProperty); }
            set { SetProperty(OrdinalProperty, value); }
        }

        public static readonly PropertyInfo<string> DescriptionProperty = RegisterProperty<string>(p => p.Description);
        public string Description
        {
            get { return GetProperty(DescriptionProperty); }
            set { SetProperty(DescriptionProperty, value); }
        }

        public static readonly PropertyInfo<DateTime> LastChangedProperty = RegisterProperty<DateTime>(p => p.LastChanged);
        public DateTime LastChanged
        {
            get { return GetProperty(LastChangedProperty); }
            set { SetProperty(LastChangedProperty, value); }
        }


        #endregion

        #region Business Rules

        protected override void AddBusinessRules()
        {
            // TODO: add validation rules
            //BusinessRules.AddRule(new Rule(), IdProperty);
        }

        private static void AddObjectAuthorizationRules()
        {
            // TODO: add authorization rules
            //BusinessRules.AddRule(...);
        }

        #endregion

        #region Factory Methods

        internal static ConstrainedValueEC New()
        {
            return DataPortal.CreateChild<ConstrainedValueEC>();
        }

        internal static ConstrainedValueEC Get()
        {
            return DataPortal.FetchChild<ConstrainedValueEC>();
        }

        internal static ConstrainedValueEC Get(object childData)
        {
            return DataPortal.FetchChild<ConstrainedValueEC>(childData);
        }

        private ConstrainedValueEC()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        //protected override void Child_Create()
        //{
        //    // TODO: load default values
        //    // omit this override if you have no defaults to set
        //    base.Child_Create();
        //}

        private void Child_Fetch(System.Data.IDataReader childData)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            Id = childData.GetGuid(0);
            ConstrainedValueListId = childData.GetGuid(1);
            Value = childData.GetString(2);
            Description = childData.GetString(3);
            Ordinal = childData.GetInt32(4);
            LastChanged = childData.GetDateTime(5);
            // TODO(crhodes): Added this to try to get things to not be dirty.
            MarkOld();
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        private void Child_Insert()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IConstrainedValueDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Insert(Id, ConstrainedValueListId, Value, Description, Ordinal, "SomeOne", "For Some Reason");
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        private void Child_Update()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IConstrainedValueDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Update(Id, ConstrainedValueListId, Value, Description, Ordinal, "SomeOne", "For Some Reason", LastChanged);
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        private void Child_DeleteSelf()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IConstrainedValueDAL>();

                using (BypassPropertyChecks)
                {
                    dal.Delete(Id, "SomeOne", "For Some Reason", LastChanged);
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        #endregion
    }
}
