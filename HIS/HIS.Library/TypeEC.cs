using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class TypeEC : BusinessBase<TypeEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_ITEMTYPE;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id);
        public Guid Id
        {
            get { return GetProperty(IdProperty); }
            set { SetProperty(IdProperty, value); }
        }

        public static readonly PropertyInfo<string> NameProperty = RegisterProperty<string>(p => p.Name);
        public string Name
        {
            get { return GetProperty(NameProperty); }
            set { SetProperty(NameProperty, value); }
        }

        public static readonly PropertyInfo<int> CharacteristicsProperty = RegisterProperty<int>(p => p.Characteristics);
        public int Characteristics
        {
            get { return GetProperty(CharacteristicsProperty); }
            set { SetProperty(CharacteristicsProperty, value); }
        }

        public static readonly PropertyInfo<int> VersionProperty = RegisterProperty<int>(p => p.Version);
        public int Version
        {
            get { return GetProperty(VersionProperty); }
            set { SetProperty(VersionProperty, value); }
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

        internal static TypeEC NewTypeEC()
        {
            return DataPortal.CreateChild<TypeEC>();
        }

        internal static TypeEC GetTypeEC(object childData)
        {
            return DataPortal.FetchChild<TypeEC>(childData);
        }

        private TypeEC()
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
            Characteristics = childData.GetInt32(2);
            Version = childData.GetInt32(3);
            Description = childData.GetString(4);
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
                var dal = dalManager.GetProvider<HIS.DAL.ITypeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Insert(Id, Name, Characteristics, Version, Description, "SomeOne", "For Some Reason");
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
                var dal = dalManager.GetProvider<HIS.DAL.ITypeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Update(Id, Name, Characteristics, Version, Description, "SomeOne", "For Some Reason", LastChanged);
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
                var dal = dalManager.GetProvider<HIS.DAL.ITypeDAL>();

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
