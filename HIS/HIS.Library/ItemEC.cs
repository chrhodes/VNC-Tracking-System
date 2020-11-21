using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class ItemEC : BusinessBase<ItemEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_ITEM;
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

        public static readonly PropertyInfo<Guid> TypeIdProperty = RegisterProperty<Guid>(p => p.TypeId);
        public Guid TypeId
        {
            get { return GetProperty(TypeIdProperty); }
            set { SetProperty(TypeIdProperty, value); }
        }

        public static readonly PropertyInfo<DateTime> LastChangedProperty = RegisterProperty<DateTime>(p => p.LastChanged);
        public DateTime LastChanged
        {
            get { return GetProperty(LastChangedProperty); }
            set { SetProperty(LastChangedProperty, value); }
        }

        private static readonly PropertyInfo<AttributeValuesECBL> AttributeValuesECBLProperty = RegisterProperty<AttributeValuesECBL>(p => p.AttributeValues, "AttributeValues", RelationshipTypes.Child);
        public AttributeValuesECBL AttributeValues
        {
            get { return GetProperty<AttributeValuesECBL>(AttributeValuesECBLProperty); }
        }

        public static readonly PropertyInfo<string> TypeNameProperty = RegisterProperty<string>(p => p.TypeName);
        public string TypeName
        {
            get
            {
                return GetProperty(TypeNameProperty);
            }
            set
            {
                SetProperty(TypeNameProperty, value);
            }
        }

        public static readonly PropertyInfo<int> CharacteristicsProperty = RegisterProperty<int>(p => p.Characteristics);
        public int Characteristics
        {
            get
            {
                return GetProperty(CharacteristicsProperty);
            }
            set
            {
                SetProperty(CharacteristicsProperty, value);
            }
        }

        public static readonly PropertyInfo<int> VersionProperty = RegisterProperty<int>(p => p.Version);
        public int Version
        {
            get
            {
                return GetProperty(VersionProperty);
            }
            set
            {
                SetProperty(VersionProperty, value);
            }
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

        internal static ItemEC New()
        {
            return DataPortal.CreateChild<ItemEC>();
        }

        internal static ItemEC Get()
        {
            return DataPortal.FetchChild<ItemEC>();
        }

        internal static ItemEC Get(object childData)
        {
            return DataPortal.FetchChild<ItemEC>(childData);
        }

        private ItemEC()
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
            // First get the data from the retrieved record
            Id = childData.GetGuid(0);
            Name = childData.GetString(1);
            TypeId = childData.GetGuid(2);
            LastChanged = childData.GetDateTime(3);

            // Then call the Schema to get other information
            TypeName = HIS.Library.Common.HISSchema.GetTypeName(TypeId);
            Characteristics = HIS.Library.Common.HISSchema.GetTypeCharacteristics(TypeId);
            Version = HIS.Library.Common.HISSchema.GetTypeVersion(TypeId);

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
                var dal = dalManager.GetProvider<HIS.DAL.IItemDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Insert(Id, Name, TypeId, "SomeOne", "For Some Reason");
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
                var dal = dalManager.GetProvider<HIS.DAL.IItemDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Update(Id, Name, TypeId, "SomeOne", "For Some Reason", LastChanged);
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
                var dal = dalManager.GetProvider<HIS.DAL.IItemDAL>();

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
