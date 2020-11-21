using System;
using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class ItemsERLP : BusinessBase<ItemsERLP>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_HISSCHEMA;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        // example with private backing field
        //public static readonly PropertyInfo<int> IdProperty = RegisterProperty<int>(p => p.Id, RelationshipTypes.PrivateField);
        //private int _Id = IdProperty.DefaultValue;
        //public int Id
        //{
        //    get { return GetProperty(IdProperty, _Id); }
        //    set { SetProperty(IdProperty, ref _Id, value); }
        //}

        //// example with managed backing field
        //public static readonly PropertyInfo<string> NameProperty = RegisterProperty<string>(p => p.Name);
        //public string Name
        //{
        //    get { return GetProperty(NameProperty); }
        //    set { SetProperty(NameProperty, value); }
        //}
        // example with Editable Child list 

        private static readonly PropertyInfo<ItemsECBL> ItemsECBLProperty = RegisterProperty<ItemsECBL>(p => p.Items, "Items", RelationshipTypes.Child);
        public ItemsECBL Items
        {
            get { return GetProperty<ItemsECBL>(ItemsECBLProperty); }
        }

        private static readonly PropertyInfo<AttributeValuesECBL> AttributeValuesECBLProperty = RegisterProperty<AttributeValuesECBL>(p => p.AttributeValues, "AttributeValues", RelationshipTypes.Child);
        public AttributeValuesECBL AttributeValues
        {
            get { return GetProperty<AttributeValuesECBL>(AttributeValuesECBLProperty); }
        }

        //// Example with Editable Child 
        //private static readonly PropertyInfo<EditableChild> ChildProperty = RegisterProperty<EditableChild>(p => p.Child, "Child", RelationshipTypes.Child);
        //public EditableChild Child
        //{
        //    get { return GetProperty<EditableChild>(ChildProperty); }
        //}

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

        public static ItemsERLP NewEditableRootParent()
        {
            return DataPortal.Create<ItemsERLP>();
        }

        public static ItemsERLP GetEditableRootParent()
        {
            return DataPortal.Fetch<ItemsERLP>();
        }

        public static ItemsERLP GetEditableRootParent(int id)
        {
            return DataPortal.Fetch<ItemsERLP>(id);
        }

        public static void DeleteEditableRootParent(int id)
        {
            DataPortal.Delete<ItemsERLP>(id);
        }

        private ItemsERLP()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        [RunLocal]
        protected override void DataPortal_Create()
        {
            // TODO: load default values
            // omit this override if you have no defaults to set
            LoadProperty(ItemsECBLProperty, ItemsECBL.New());
            //LoadProperty(ChildProperty, EditableChild.NewEditableChild());
            base.DataPortal_Create();
        }

        private void DataPortal_Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: load values
            LoadProperty(ItemsECBLProperty, ItemsECBL.Get());
            LoadProperty(AttributeValuesECBLProperty, AttributeValuesECBL.Get()) ;
            //LoadProperty(ChildProperty, EditableChild.GetEditableChild(null));
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2, startTicks);
#endif
        }

        private void DataPortal_Fetch(int criteria)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: load values
            LoadProperty(ItemsECBLProperty, ItemsECBL.Get(null));
            //LoadProperty(ChildProperty, EditableChild.GetEditableChild(null));
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
