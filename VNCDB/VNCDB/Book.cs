using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Csla;
using Csla.Data;

namespace VNCDB
{
    [Serializable()]
    public class Book : BusinessBase<Book>
    {

        #region Business Methods

        private Guid _id;

        [System.ComponentModel.DataObjectField(true, true)]
        public Guid Id
        {
            get
            {
                //CanReadProperty(true);
                CanReadProperty("Id");
                return _id;
            }
        }

        private string _name = string.Empty;

        public string Name
        {
            get
            {
                //CanReadProperty(true);
                CanReadProperty("Name");
                return _name;
            }
            set 
            {
                //CanWriteProperty(true);
                CanWriteProperty("Name");

                if (value == null) value = string.Empty;
                
                if (_name != value)
                {
                    _name = value;
                    PropertyHasChanged("Name");
                    // Can also call as
                    // PropertyHasChanged();
                    // Which uses System.Diagnostics to reflect on property name.
                }
            }
        }

        // This is what the CSLA code snippet inserts for a property.  Clearly more to learn !
        //private static PropertyInfo<int> NameProperty = RegisterProperty<int>(typeof(BusinessClass), new PropertyInfo<int>("Name", "Name"));
        //public int Name
        //{
        //    get { return GetProperty<int>(NameProperty); }
        //    set { SetProperty<int>(NameProperty, value); }
        //}

        private Guid _itemtype;

        public Guid Itemtype
        {
            get 
            {
                //CanReadProperty(true);
                CanReadProperty("Itemtype");
                return _itemtype;
            }
            set 
            {
                //CanWriteProperty(true);
                CanWriteProperty("Itemtype");
                
                if (_itemtype != value)
                {
                    _itemtype = value;
                    PropertyHasChanged("Itemtype");
                }
            }
        }

        private string _author = string.Empty;

        public string Author
        {
            get 
            {
                //CanReadProperty(true);
                CanReadProperty("Author");

                return _author;
            }
            set 
            {
                //CanWriteProperty();
                CanWriteProperty("Author");
                
                if (value == null) value = string.Empty;

                if (_author != value)
                {
                    _author = value;
                    PropertyHasChanged("Author");
                }
            }
        }

        protected override object GetIdValue()
        {
            return _id;
        }

        // The default IsValid and IsDirty properties must be enhanced
        // for all objects that subclas BusinessBase and contain child objects.

        public override bool IsValid
        {
            get
            {
                 return base.IsValid /* && whatever children*/ ;
            }
        }

        public override bool IsDirty
        {
            get
            {
                return base.IsDirty /* || whatever children */ ;
            }
        }

        #endregion

        #region Validation Methods

        protected override void AddBusinessRules()
        {
            ValidationRules.AddRule(Csla.Validation.CommonRules.StringRequired, "Name");
            ValidationRules.AddRule(Csla.Validation.CommonRules.StringMinLength, new Csla.Validation.CommonRules.MinLengthRuleArgs("Name", 1));
            ValidationRules.AddRule(Csla.Validation.CommonRules.StringMaxLength, new Csla.Validation.CommonRules.MaxLengthRuleArgs("Name", 256));
        }
        #endregion

        #region Authorization Methods

        protected override void AddAuthorizationRules()
        {
            base.AddAuthorizationRules();
        }

        public static bool CanGetObject()
        {
            return true;
        }

        public static bool CanAddObject()
        {
            return true;
        }

        public static bool CanEditObject()
        {
            return true;
        }

        public static bool CanDeleteObject()
        {
            return true;
        }

        #endregion
        
        #region Factory Methods

        public static Book NewBook()
        {
            if (!CanAddObject())
            {
                throw new System.Security.SecurityException(
                    "User is not authorized to add a Book");
            }

            return DataPortal.Create<Book>(null);
        }

        public static Book GetBook(Guid id)
        {
            if (!CanGetObject())
            {
                throw new System.Security.SecurityException(
                    "User is not authorized to view a Book");
            }

            return DataPortal.Fetch<Book>(new Criteria(id));
        }

        public static void DeleteBook(Guid id)
        {
            if (!CanDeleteObject())
            {
                throw new System.Security.SecurityException(
                    "User is not authorized to delete a Book");
            }

            DataPortal.Delete(new Criteria(id));
        }

        private Book()
        {
            // Non-Public Constructor.
            //
            // Marked private so Factory methods must be called.
        }

        public override Book Save()
        {
            if ( IsDeleted && ! CanDeleteObject() )
            {
                throw new System.Security.SecurityException(
                    "User is not authorized to delete a book");
            }
            else if ( IsNew && ! CanAddObject() )
            {
                throw new System.Security.SecurityException(
                    "User is not authorized to create a book");
            }
            else if ( ! CanEditObject() )
            {
                throw new System.Security.SecurityException(
                    "User is not authorized to update a book");
            }

            return base.Save();
        }
        #endregion

        #region Data Access

        ODB.ODBClassesDataContext odbContext = new ODB.ODBClassesDataContext();

        [Serializable()]
        private class Criteria
        {
            private Guid _id;

            public Guid Id
            {
                get { return _id; }
            }

            public Criteria(Guid id)
            {
                _id = Id;
            }
        }

        [RunLocal()]
        private void DataPortal_Create(Criteria criteria)
        {
            _id = Guid.NewGuid();
            ValidationRules.CheckRules();
        }

        private void DataPortal_Fetch(Criteria criteria)
        {
            // Perhaps this should be in Book class.
            //ODB.ODBClassesDataContext odbContext = new ODBClassesDataContext();

            var itemQuery = from item in odbContext.Items
                            where item.item_id == _id
                            select item;

           foreach (ODB.Item item in itemQuery)
           {
                System.Diagnostics.Debug.WriteLine(item.item_id);
                System.Diagnostics.Debug.WriteLine(item.item_name);
                System.Diagnostics.Debug.WriteLine(item.itemtype_id);              
           }

        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Insert()
        {
            odbContext.Items_Insert(_id, _name, _itemtype, "crhodes", "I created it");
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Update()
        {
            if (base.IsDirty)
            {
                odbContext.Items_Update(_id, _name, _itemtype, "crhodes", "I updated it");
            }
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_DeleteSelf()
        {
            DataPortal_Delete(new Criteria(_id));
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        private void DataPortal_Delete(Criteria criteria)
        {
            odbContext.Items_Delete(_id, "crhodes", "I deleted it");
            // This will also need to delete any attributes and associations
            // related to this item.
        }

        #endregion

        #region Exists


        #endregion




    }
}
