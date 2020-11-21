using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class AttributeEC : BusinessBase<AttributeEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_ATTRIBUTE;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        //// example with private backing field
        //public static readonly PropertyInfo<int> IdProperty = RegisterProperty<int>(p => p.Id, RelationshipTypes.PrivateField);
        //private int _Id = IdProperty.DefaultValue;
        //public int Id
        //{
        //    get { return GetProperty(IdProperty, _Id); }
        //    set { SetProperty(IdProperty, ref _Id, value); }
        //}

        // example with managed backing field
        public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id);
        public Guid Id
        {
            get { return GetProperty(IdProperty); }
            set { SetProperty(IdProperty, value); }
        }

        // example with managed backing field
        public static readonly PropertyInfo<string> NameProperty = RegisterProperty<string>(p => p.Name);
        public string Name
        {
            get { return GetProperty(NameProperty); }
            set { SetProperty(NameProperty, value); }
        }

        // example with managed backing field
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

        internal static AttributeEC NewAttributeEC()
        {
            return DataPortal.CreateChild<AttributeEC>();
        }

        internal static AttributeEC GetAttributeEC()
        {
            return DataPortal.FetchChild<AttributeEC>();
        }

        internal static AttributeEC GetAttributeEC(object childData)
        {
            return DataPortal.FetchChild<AttributeEC>(childData);
        }

        private AttributeEC()
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
            Name = childData.GetString(1);
            LastChanged = childData.GetDateTime(2);
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
            // TODO: update values
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Insert(Id, Name, "SomeOne", "For Some Reason");
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
            // TODO: update values
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Update(Id, Name, "SomeOne", "For Some Reason", LastChanged);
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
            // TODO: delete values
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeDAL>();

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
