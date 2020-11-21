using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class HISSchema_ChildLoad : BusinessBase<HISSchema_ChildLoad>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_HISSCHEMA;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        private static readonly PropertyInfo<AttributesECL> AttributesECLProperty = RegisterProperty<AttributesECL>(p => p.Attributes, "Attributes", RelationshipTypes.Child);
        public AttributesECL Attributes
        {
            get { return GetProperty<AttributesECL>(AttributesECLProperty); }
        }

        private static readonly PropertyInfo<CharacteristicsECL> CharacteristicsECLProperty = RegisterProperty<CharacteristicsECL>(p => p.Characteristics, "Characteristics", RelationshipTypes.Child);
        public CharacteristicsECL Characteristics
        {
            get { return GetProperty<CharacteristicsECL>(CharacteristicsECLProperty); }
        }

        private static readonly PropertyInfo<ConstrainedValueListsECL> ConstrainedValueListsECLProperty = RegisterProperty<ConstrainedValueListsECL>(p => p.ConstrainedValueLists, "ConstrainedValueLists", RelationshipTypes.Child);
        public ConstrainedValueListsECL ConstrainedValueLists
        {
            get { return GetProperty<ConstrainedValueListsECL>(ConstrainedValueListsECLProperty); }
        }

        private static readonly PropertyInfo<ConstrainedValuesECL> ConstrainedValuesECLProperty = RegisterProperty<ConstrainedValuesECL>(p => p.ConstrainedValues, "ConstrainedValues", RelationshipTypes.Child);
        public ConstrainedValuesECL ConstrainedValues
        {
            get { return GetProperty<ConstrainedValuesECL>(ConstrainedValuesECLProperty); }
        }

        private static readonly PropertyInfo<DataTypesECL> DataTypesECLProperty = RegisterProperty<DataTypesECL>(p => p.DataTypes, "DataTypes", RelationshipTypes.Child);
        public DataTypesECL DataTypes
        {
            get { return GetProperty<DataTypesECL>(DataTypesECLProperty); }
        }

        private static readonly PropertyInfo<TablesECL> TablesECLProperty = RegisterProperty<TablesECL>(p => p.Tables, "Tables", RelationshipTypes.Child);
        public TablesECL Tables
        {
            get { return GetProperty<TablesECL>(TablesECLProperty); }
        }

        private static readonly PropertyInfo<TypeAttributesECL> TypeAttributesECLProperty = RegisterProperty<TypeAttributesECL>(p => p.TypeAttributes, "TypeAttributes", RelationshipTypes.Child);
        public TypeAttributesECL TypeAttributes
        {
            get { return GetProperty<TypeAttributesECL>(TypeAttributesECLProperty); }
        }

        private static readonly PropertyInfo<TypesECL> TypesECLProperty = RegisterProperty<TypesECL>(p => p.Types, "Types", RelationshipTypes.Child);
        public TypesECL Types
        {
            get { return GetProperty<TypesECL>(TypesECLProperty); }
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

        public static HISSchema_ChildLoad New()
        {
            return DataPortal.Create<HISSchema_ChildLoad>();
        }

        public static HISSchema_ChildLoad Get()
        {
            return DataPortal.Fetch<HISSchema_ChildLoad>();
        }

        public static HISSchema_ChildLoad Get(int id)
        {
            return DataPortal.Fetch<HISSchema_ChildLoad>(id);
        }

        public static void Delete(int id)
        {
            DataPortal.Delete<HISSchema_ChildLoad>(id);
        }

        private HISSchema_ChildLoad()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        [RunLocal]
        protected override void DataPortal_Create()
        {
            // TODO: load default values
            // omit this override if you have no defaults to set
            base.DataPortal_Create();
        }

        private void DataPortal_Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: load values

            // WPF versions

            LoadProperty(AttributesECLProperty, AttributesECL.Get());

            LoadProperty(CharacteristicsECLProperty, CharacteristicsECL.Get());

            LoadProperty(ConstrainedValueListsECLProperty, ConstrainedValueListsECL.Get());

            LoadProperty(ConstrainedValuesECLProperty, ConstrainedValuesECL.Get());

            LoadProperty(DataTypesECLProperty, DataTypesECL.Get());

            LoadProperty(TablesECLProperty, TablesECL.Get());

            LoadProperty(TypeAttributesECLProperty, TypeAttributesECL.Get());

            LoadProperty(TypesECLProperty, TypesECL.Get());

#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 2, startTicks);
#endif
        }

        private void DataPortal_Fetch(int criteria)
        {
            // TODO: load values
            LoadProperty(TablesECLProperty, TablesECL.Get());
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
