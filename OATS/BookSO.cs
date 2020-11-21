using System;

using Csla;
using HIS.Library;
using PacificLife.Life;

namespace OATS
{
    [Serializable]
    public class BookSO : BusinessBase<BookSO>
    {
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

        public static readonly PropertyInfo<string> AuthorProperty = RegisterProperty<string>(p => p.Author);
        public string Author
        {
            get { return GetProperty(AuthorProperty); }
            set { SetProperty(AuthorProperty, value); }
        }

        public static readonly PropertyInfo<int> PagesProperty = RegisterProperty<int>(p => p.Pages);
        public int Pages
        {
            get { return GetProperty(PagesProperty); }
            set { SetProperty(PagesProperty, value); }
        }

        // TODO(crhodes): Not sure if need this.  Maybe just on the HIS stuff inside.
        public static readonly PropertyInfo<DateTime> LastChangedProperty = RegisterProperty<DateTime>(p => p.LastChanged);
        public DateTime LastChanged
        {
            get { return GetProperty(LastChangedProperty); }
            set { SetProperty(LastChangedProperty, value); }
        }

        public static readonly PropertyInfo<Guid> ItemTypeProperty = RegisterProperty<Guid>(p => p.ItemType);
        public Guid ItemType
        {
            get { return GetProperty(ItemTypeProperty); }
            set { SetProperty(ItemTypeProperty, value); }
        }

        private static readonly PropertyInfo<AttributesECBL> AttributesECBLProperty = RegisterProperty<AttributesECBL>(p => p.Attributes, "Attributes", RelationshipTypes.Child);
        public AttributesECBL Attributes
        {
            get { return GetProperty<AttributesECBL>(AttributesECBLProperty); }
        }

        private static readonly PropertyInfo<AttributeValuesECBL> AttributeValuesECBLProperty = RegisterProperty<AttributeValuesECBL>(p => p.AttributeValues, "AttributeValues", RelationshipTypes.Child);
        public AttributeValuesECBL AttributeValues
        {
            get { return GetProperty<AttributeValuesECBL>(AttributeValuesECBLProperty); }
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

        public static BookSO NewSwitchableObject()
        {
            return DataPortal.Create<BookSO>();
        }

        public static BookSO GetSwitchableObject(int id)
        {
            return DataPortal.Fetch<BookSO>(id);
        }

        public static void DeleteSwitchableObject(int id)
        {
            DataPortal.Delete<BookSO>(id);
        }

        #endregion

        #region Child Factory Methods

        internal static BookSO NewSwitchableChild()
        {
            return DataPortal.CreateChild<BookSO>();
        }

        internal static BookSO GetSwitchableChild(object childData)
        {
            return DataPortal.FetchChild<BookSO>(childData);
        }

        private BookSO()
        { /* Require use of factory methods */ }

        #endregion

        #region Root Data Access

        [RunLocal]
        protected override void DataPortal_Create()
        {
            // TODO: load default values
            // omit this override if you have no defaults to set
            base.DataPortal_Create();
        }

        private void DataPortal_Fetch(int criteria)
        {
            // TODO: load values
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Insert()
        {
            // TODO: insert values
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Update()
        {
            // TODO: update values
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
        }

        #endregion

        #region Child Data Access

        protected override void Child_Create()
        {
            // TODO: load default values
            // omit this override if you have no defaults to set
            base.Child_Create();
        }

        private void Child_Fetch(object childData)
        {
            // TODO: load values
        }

        private void Child_Insert(object parent)
        {
            // TODO: insert values
        }

        private void Child_Update(object parent)
        {
            // TODO: update values
        }

        private void Child_DeleteSelf(object parent)
        {
            // TODO: delete values
        }

        #endregion
    }
}
