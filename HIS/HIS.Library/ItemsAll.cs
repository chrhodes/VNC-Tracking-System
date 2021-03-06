using System;
using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class ItemsAll : BusinessBase<ItemsAll>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_HISSCHEMA;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        private static readonly PropertyInfo<AttributeValuesECL> AttributeValuesProperty = RegisterProperty<AttributeValuesECL>(p => p.AttributeValues, "AttributeValues", RelationshipTypes.Child);
        public AttributeValuesECL AttributeValues
        {
            get { return GetProperty<AttributeValuesECL>(AttributeValuesProperty); }
        }

        private static readonly PropertyInfo<ItemsECL> ItemsProperty = RegisterProperty<ItemsECL>(p => p.Items, "Items", RelationshipTypes.Child);
        public ItemsECL Items
        {
            get { return GetProperty<ItemsECL>(ItemsProperty); }
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

        public static ItemsAll New()
        {
            return DataPortal.Create<ItemsAll>();
        }

        public static ItemsAll Get()
        {
            return DataPortal.Fetch<ItemsAll>();
        }

        public static ItemsAll Get(int id)
        {
            return DataPortal.Fetch<ItemsAll>(id);
        }

        public static void Delete(int id)
        {
            DataPortal.Delete<ItemsAll>(id);
        }

        private ItemsAll()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        [RunLocal]
        protected override void DataPortal_Create()
        {
            // TODO: load default values
            // omit this override if you have no defaults to set
            LoadProperty(ItemsProperty, ItemsECL.New());
            base.DataPortal_Create();
        }

        private void DataPortal_Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: load values
            LoadProperty(AttributeValuesProperty, AttributeValuesECL.Get());
            LoadProperty(ItemsProperty, ItemsECL.Get());
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2, startTicks);
#endif
        }

        private void DataPortal_Fetch(int criteria)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            LoadProperty(AttributeValuesProperty, AttributeValuesECL.Get(null));
            LoadProperty(ItemsProperty, ItemsECL.Get(null));
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2, startTicks);
#endif
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Insert()
        {
            // TODO: insert values
            FieldManager.UpdateChildren(this);
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Update()
        {
            // TODO: update values
            FieldManager.UpdateChildren(this);
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_DeleteSelf()
        {
            //DataPortal_Delete(this.Id);
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        private void DataPortal_Delete(int criteria)
        {
            // TODO: delete values
            FieldManager.UpdateChildren(this);
        }

        #endregion
    }
}
