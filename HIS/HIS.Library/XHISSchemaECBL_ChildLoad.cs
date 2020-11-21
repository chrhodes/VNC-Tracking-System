using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class HISSchemaECBL_ChildLoad : BusinessBase<HISSchemaECBL_ChildLoad>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_HISSCHEMA;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        // example with private backing field
        public static readonly PropertyInfo<int> IdProperty = RegisterProperty<int>(p => p.Id, RelationshipTypes.PrivateField);
        private int _Id = IdProperty.DefaultValue;
        public int Id
        {
            get { return GetProperty(IdProperty, _Id); }
            set { SetProperty(IdProperty, ref _Id, value); }
        }

        // example with managed backing field
        public static readonly PropertyInfo<string> NameProperty = RegisterProperty<string>(p => p.Name);
        public string Name
        {
            get { return GetProperty(NameProperty); }
            set { SetProperty(NameProperty, value); }
        }

        // example with Editable Child list

        private static readonly PropertyInfo<AttributesECBL> AttributesECBLProperty = RegisterProperty<AttributesECBL>(p => p.Attributes, "Attributes", RelationshipTypes.Child);
        public AttributesECBL Attributes
        {
            get { return GetProperty<AttributesECBL>(AttributesECBLProperty); }
        }

         private static readonly PropertyInfo<CharacteristicsECBL> CharacteristicsECBLProperty = RegisterProperty<CharacteristicsECBL>(p => p.Characteristics, "Characteristics", RelationshipTypes.Child);
        public CharacteristicsECBL Characteristics
        {
            get { return GetProperty<CharacteristicsECBL>(CharacteristicsECBLProperty); }
        }

        private static readonly PropertyInfo<ConstrainedValueListsECBL> ConstrainedValueListsECBLProperty = RegisterProperty<ConstrainedValueListsECBL>(p => p.ConstrainedValueLists, "ConstrainedValueLists", RelationshipTypes.Child);
        public ConstrainedValueListsECBL ConstrainedValueLists
        {
            get { return GetProperty<ConstrainedValueListsECBL>(ConstrainedValueListsECBLProperty); }
        }

        private static readonly PropertyInfo<ConstrainedValuesECBL> ConstrainedValuesECBLProperty = RegisterProperty<ConstrainedValuesECBL>(p => p.ConstrainedValues, "ConstrainedValues", RelationshipTypes.Child);
        public ConstrainedValuesECBL ConstrainedValues
        {
            get { return GetProperty<ConstrainedValuesECBL>(ConstrainedValuesECBLProperty); }
        }

        private static readonly PropertyInfo<DataTypesECBL> DataTypesECBLProperty = RegisterProperty<DataTypesECBL>(p => p.DataTypes, "DataTypes", RelationshipTypes.Child);
        public DataTypesECBL DataTypes
        {
            get { return GetProperty<DataTypesECBL>(DataTypesECBLProperty); }
        }

        private static readonly PropertyInfo<TablesECBL> TablesECBLProperty = RegisterProperty<TablesECBL>(p => p.Tables, "Tables", RelationshipTypes.Child);
        public TablesECBL Tables
        {
            get { return GetProperty<TablesECBL>(TablesECBLProperty); }
        }

        private static readonly PropertyInfo<TypeAttributesECBL> TypeAttributesECBLProperty = RegisterProperty<TypeAttributesECBL>(p => p.TypeAttributes, "TypeAttributes", RelationshipTypes.Child);
        public TypeAttributesECBL TypeAttributes
        {
            get { return GetProperty<TypeAttributesECBL>(TypeAttributesECBLProperty); }
        }

        private static readonly PropertyInfo<TypesECBL> TypesECBLProperty = RegisterProperty<TypesECBL>(p => p.Types, "Types", RelationshipTypes.Child);
        public TypesECBL Types
        {
            get { return GetProperty<TypesECBL>(TypesECBLProperty); }
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

        public static HISSchemaECBL_ChildLoad New()
        {
            return DataPortal.Create<HISSchemaECBL_ChildLoad>();
        }

        public static HISSchemaECBL_ChildLoad Get()
        {
            return DataPortal.Fetch<HISSchemaECBL_ChildLoad>();
        }

        public static HISSchemaECBL_ChildLoad Get(int id)
        {
            return DataPortal.Fetch<HISSchemaECBL_ChildLoad>(id);
        }

        public static void Delete(int id)
        {
            DataPortal.Delete<HISSchemaECBL_ChildLoad>(id);
        }

        private HISSchemaECBL_ChildLoad()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        [RunLocal]
        protected override void DataPortal_Create()
        {
            // TODO: load default values
            // omit this override if you have no defaults to set
            LoadProperty(TablesECBLProperty, TablesECBL.New());
            //LoadProperty(ChildProperty, EditableChild.NewEditableChild());
            base.DataPortal_Create();
        }

        private void DataPortal_Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: load values

            // WinForm versions

            LoadProperty(AttributesECBLProperty, AttributesECBL.Get());

            LoadProperty(CharacteristicsECBLProperty, CharacteristicsECBL.Get());

            LoadProperty(ConstrainedValueListsECBLProperty, ConstrainedValueListsECBL.Get());

            LoadProperty(ConstrainedValuesECBLProperty, ConstrainedValuesECBL.Get());

            LoadProperty(DataTypesECBLProperty, DataTypesECBL.Get());

            LoadProperty(TablesECBLProperty, TablesECBL.Get());

            LoadProperty(TypeAttributesECBLProperty, TypeAttributesECBL.Get());

            LoadProperty(TypesECBLProperty, TypesECBL.Get());

#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2, startTicks);
#endif
        }

        private void DataPortal_Fetch(int criteria)
        {
            // TODO: load values
            LoadProperty(TablesECBLProperty, TablesECBL.Get());
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
            DataPortal_Delete(this.Id);
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
