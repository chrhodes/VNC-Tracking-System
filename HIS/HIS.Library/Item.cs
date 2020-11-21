using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    /// <summary>
    /// This class can be a root or a child.  See ItemEC for just the Child Side.
    /// </summary>
    [Serializable]
    public class Item : BusinessBase<Item>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_ITEM;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods
        
        #region Item Properties

        public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id);
        public Guid Id
        {
            get
            {
                return GetProperty(IdProperty);
            }
            set
            {
                SetProperty(IdProperty, value);
            }
        }

        public static readonly PropertyInfo<Guid> TypeIdProperty = RegisterProperty<Guid>(p => p.TypeId);
        public Guid TypeId
        {
            get
            {
                return GetProperty(TypeIdProperty);
            }
            set
            {
                SetProperty(TypeIdProperty, value);
            }
        }

        public static readonly PropertyInfo<string> NameProperty = RegisterProperty<string>(p => p.Name);
        public string Name
        {
            get
            {
                return GetProperty(NameProperty);
            }
            set
            {
                SetProperty(NameProperty, value);
            }
        }

        public static readonly PropertyInfo<DateTime> LastChangedProperty = RegisterProperty<DateTime>(p => p.LastChanged);
        public DateTime LastChanged
        {
            get
            {
                return GetProperty(LastChangedProperty);
            }
            set
            {
                SetProperty(LastChangedProperty, value);
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

        #endregion


        private static readonly PropertyInfo<AttributeValuesECL> AttributeValuesECLProperty = RegisterProperty<AttributeValuesECL>(p => p.AttributeValues, "AttributeValues", RelationshipTypes.Child);
        public AttributeValuesECL AttributeValues
        {
            get { return GetProperty<AttributeValuesECL>(AttributeValuesECLProperty); }
        }

        #endregion

        #region Business Rules

        protected override void AddBusinessRules()
        {
            base.AddBusinessRules();

            // TODO: add validation rules
            //BusinessRules.AddRule(new Rule(), IdProperty);
        }

        private static void AddObjectAuthorizationRules()
        {
            // TODO: add authorization rules
            //BusinessRules.AddRule(...);
        }

        #endregion

        #region Root Factory Methods

        public static Item New()
        {
            return DataPortal.Create<Item>();
        }

        public static Item Get(Guid id)
        {
            return DataPortal.Fetch<Item>(id);
        }

        public static void Delete(Guid id)
        {
            DataPortal.Delete<Item>(id);
        }

        #endregion

        #region Child Factory Methods

        internal static Item NewChild()
        {
            return DataPortal.CreateChild<Item>();
        }

        internal static Item GetChild(object childData)
        {
            return DataPortal.FetchChild<Item>(childData);
        }

        private Item()
        { /* Require use of factory methods */ }

        #endregion

        #region Root Data Access

        [RunLocal]
        protected override void DataPortal_Create()
        {
            // TODO: load default values
            // omit this override if you have no defaults to set
            Id = Guid.NewGuid();
            base.DataPortal_Create();
        }

        private void DataPortal_Fetch(Guid id)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: load values
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IItemDAL>();

                using (var data = dal.Fetch(id))
                {
                    data.Read();
                    Id = data.GetGuid(0);
                    Name = data.GetString(1);
                    TypeId = data.GetGuid(2);
                    LastChanged = data.GetDateTime(3);

                    Characteristics = HIS.Library.Common.HISSchema.GetTypeCharacteristics(TypeId);

                    data.NextResult();

                    LoadProperty(AttributeValuesECLProperty, AttributeValuesECL.Get(data));
                }
            }
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Insert()
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

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Update()
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

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_DeleteSelf()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            DataPortal_Delete(this.Id);
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        private void DataPortal_Delete(Guid id)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: delete values
            // TODO (crhodes): Delete attribute values, also.
            // Need to think about edges where this object is an endpoint.
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        #endregion

        #region Child Data Access

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
            TypeId = childData.GetGuid(2);
            LastChanged = childData.GetDateTime(3);

            LoadProperty(AttributeValuesECLProperty, AttributeValuesECL.Get(Id));
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
