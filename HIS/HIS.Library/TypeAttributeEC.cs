using System;
using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class TypeAttributeEC : BusinessBase<TypeAttributeEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_TYPEATTRIBUTE;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id);
        public Guid Id
        {
            get { return GetProperty(IdProperty); }
            set { SetProperty(IdProperty, value); }
        }

        public static readonly PropertyInfo<Guid> TypeIdProperty = RegisterProperty<Guid>(p => p.TypeId);
        public Guid TypeId
        {
            get { return GetProperty(TypeIdProperty); }
            set { SetProperty(TypeIdProperty, value); }
        }

        public static readonly PropertyInfo<Guid> AttributeIDProperty = RegisterProperty<Guid>(p => p.AttributeId);
        public Guid AttributeId
        {
            get { return GetProperty(AttributeIDProperty); }
            set { SetProperty(AttributeIDProperty, value); }
        }

        public static readonly PropertyInfo<int> ChacteristicsProperty = RegisterProperty<int>(p => p.Characteristics);
        public int Characteristics
        {
            get { return GetProperty(ChacteristicsProperty); }
            set { SetProperty(ChacteristicsProperty, value); }
        }

        public static readonly PropertyInfo<int> DataTypeIdProperty = RegisterProperty<int>(p => p.DataTypeId);
        public int DataTypeId
        {
            get { return GetProperty(DataTypeIdProperty); }
            set { SetProperty(DataTypeIdProperty, value); }
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

        internal static TypeAttributeEC NewTypeAttributeEC()
        {
            return DataPortal.CreateChild<TypeAttributeEC>();
        }

        internal static TypeAttributeEC GetTypeAttributeEC(object childData)
        {
            return DataPortal.FetchChild<TypeAttributeEC>(childData);
        }

        private TypeAttributeEC()
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
            TypeId = childData.GetGuid(1);
            AttributeId = childData.GetGuid(2);
            Characteristics = childData.GetInt32(3);
            DataTypeId = childData.GetInt32(4);
            Version = childData.GetInt32(5);
            Description = childData.GetString(6);
            LastChanged = childData.GetDateTime(7);
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
                var dal = dalManager.GetProvider<HIS.DAL.ITypeAttributeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Insert(Id, TypeId, AttributeId, Characteristics, DataTypeId, Version, Description, "SomeOne", "For Some Reason");
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
                var dal = dalManager.GetProvider<HIS.DAL.ITypeAttributeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Update(Id, TypeId, AttributeId, Characteristics, DataTypeId, Version, Description, "SomeOne", "For Some Reason", LastChanged);
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
                var dal = dalManager.GetProvider<HIS.DAL.ITypeAttributeDAL>();

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
