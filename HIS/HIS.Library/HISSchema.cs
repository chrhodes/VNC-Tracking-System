using System;
using System.Collections.Generic;
using System.Linq;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    // This version is for WPF

    [Serializable]
    public class HISSchema : BusinessBase<HISSchema>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_HISSCHEMA;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        //// example with private backing field
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

        //// Example with Editable Child 
        //private static readonly PropertyInfo<EditableChild> ChildProperty = RegisterProperty<EditableChild>(p => p.Child, "Child", RelationshipTypes.Child);
        //public EditableChild Child
        //{
        //    get { return GetProperty<EditableChild>(ChildProperty); }
        //}
      
        #region Properties

        //private static HIS.Library.Helper _Helper;
        //public static HIS.Library.Helper Helper
        //{
        //    get
        //    {
        //        return _Helper;
        //    }
        //    set
        //    {
        //        _Helper = value;
        //    }
        //}

        private static readonly PropertyInfo<AttributesECL> AttributesECLProperty = RegisterProperty<AttributesECL>(p => p.Attributes, "Attributes", RelationshipTypes.Child);
        public AttributesECL Attributes
        {
            get
            {
                return GetProperty<AttributesECL>(AttributesECLProperty);
            }
        }

        private static readonly PropertyInfo<CharacteristicsECL> CharacteristicsECLProperty = RegisterProperty<CharacteristicsECL>(p => p.Characteristics, "Characteristics", RelationshipTypes.Child);
        public CharacteristicsECL Characteristics
        {
            get
            {
                return GetProperty<CharacteristicsECL>(CharacteristicsECLProperty);
            }
        }

        private static readonly PropertyInfo<ConstrainedValueListsECL> ConstrainedValueListsECLProperty = RegisterProperty<ConstrainedValueListsECL>(p => p.ConstrainedValueLists, "ConstrainedValueLists", RelationshipTypes.Child);
        public ConstrainedValueListsECL ConstrainedValueLists
        {
            get
            {
                return GetProperty<ConstrainedValueListsECL>(ConstrainedValueListsECLProperty);
            }
        }

        private static readonly PropertyInfo<ConstrainedValuesECL> ConstrainedValuesECLProperty = RegisterProperty<ConstrainedValuesECL>(p => p.ConstrainedValues, "ConstrainedValues", RelationshipTypes.Child);
        public ConstrainedValuesECL ConstrainedValues
        {
            get
            {
                return GetProperty<ConstrainedValuesECL>(ConstrainedValuesECLProperty);
            }
        }

        private static readonly PropertyInfo<DataTypesECL> DataTypesECLProperty = RegisterProperty<DataTypesECL>(p => p.DataTypes, "DataTypes", RelationshipTypes.Child);
        public DataTypesECL DataTypes
        {
            get
            {
                return GetProperty<DataTypesECL>(DataTypesECLProperty);
            }
        }

        private static readonly PropertyInfo<TablesECL> TablesECLProperty = RegisterProperty<TablesECL>(p => p.Tables, "Tables", RelationshipTypes.Child);
        public TablesECL Tables
        {
            get
            {
                return GetProperty<TablesECL>(TablesECLProperty);
            }
        }

        private static readonly PropertyInfo<TypeAttributesECL> TypeAttributesECLProperty = RegisterProperty<TypeAttributesECL>(p => p.TypeAttributes, "TypeAttributes2", RelationshipTypes.Child);
        public TypeAttributesECL TypeAttributes
        {
            get
            {
                return GetProperty<TypeAttributesECL>(TypeAttributesECLProperty);
            }
        }

        private static readonly PropertyInfo<TypesECL> TypesECLProperty = RegisterProperty<TypesECL>(p => p.Types, "Types", RelationshipTypes.Child);
        public TypesECL Types
        {
            get
            {
                return GetProperty<TypesECL>(TypesECLProperty);
            }
        }

        #endregion

        #region Methods


        public int GetTypeCharacteristics(Guid typeId)
        {
            IEnumerable<int> matches = from t in this.Types
                                          where t.Id == typeId
                                          select t.Characteristics;

            return matches.First<int>();

        }


        public string GetTypeDescription(Guid typeId)
        {
            IEnumerable<string> matches = from t in Common.HISSchema.Types
                                          where t.Id == typeId
                                          select t.Description;

            return matches.First<string>();

        }

        public string GetTypeName(Guid typeId)
        {
            IEnumerable<string> matches = from t in Common.HISSchema.Types
                                       where t.Id == typeId
                                       select t.Name;

            return matches.First<string>();

        }

        public int GetTypeVersion(Guid typeId)
        {
            IEnumerable<int> matches = from t in Common.HISSchema.Types
                                       where t.Id == typeId
                                       select t.Version;

            return matches.First<int>();

        }

        #endregion

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

        public static HISSchema New()
        {
            return DataPortal.Create<HISSchema>();
        }

        public static HISSchema Get()
        {
            return DataPortal.Fetch<HISSchema>();
        }

        public static HISSchema Get(int id)
        {
            return DataPortal.Fetch<HISSchema>(id);
        }

        public static void Delete(int id)
        {
            DataPortal.Delete<HISSchema>(id);
        }

        private HISSchema()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        [RunLocal]
        //protected override void DataPortal_Create()
        //{
        //    // TODO: load default values
        //    // omit this override if you have no defaults to set
        //    base.DataPortal_Create();
        //}

        private void DataPortal_Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.ISchemaDAL>();

                using (var data = dal.Fetch())
                {
                    // Process the result sets in order (See SP Schema_SelectAll)

                    // Tables
                    LoadProperty(TablesECLProperty, TablesECL.Get(data));

                    // LogFunctions
                    data.NextResult();

                    // Attributes
                    data.NextResult();
                    LoadProperty(AttributesECLProperty, AttributesECL.Get(data));

                    // Types
                    data.NextResult();
                    LoadProperty(TypesECLProperty, TypesECL.Get(data));

                    // TypeAttributes
                    data.NextResult();
                    LoadProperty(TypeAttributesECLProperty, TypeAttributesECL.Get(data));

                    // DataTypes
                    data.NextResult();
                    LoadProperty(DataTypesECLProperty, DataTypesECL.Get(data));

                    // Characteristics
                    data.NextResult();
                    LoadProperty(CharacteristicsECLProperty, CharacteristicsECL.Get(data));

                    // ConstrainedValueLists
                    data.NextResult();
                    LoadProperty(ConstrainedValueListsECLProperty, ConstrainedValueListsECL.Get(data));

                    // ConstrainedValues
                    data.NextResult();
                    LoadProperty(ConstrainedValuesECLProperty, ConstrainedValuesECL.Get(data));
                }
            }

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
