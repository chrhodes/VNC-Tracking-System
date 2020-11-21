using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class AttributeER : BusinessBase<AttributeER>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_DAL_SQL_CHARACTERISTIC;
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

        // Using private backing field
        public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id, RelationshipTypes.PrivateField);
        private Guid _Id = IdProperty.DefaultValue;
        public Guid Id
        {
            get { return GetProperty(IdProperty, _Id); }
            set { SetProperty(IdProperty, ref _Id, value); }
        }

        public static readonly PropertyInfo<string> NameProperty = RegisterProperty<string>(p => p.Name, RelationshipTypes.PrivateField);
        private string _Name = NameProperty.DefaultValue;
        public string Name
        {
            get { return GetProperty(NameProperty, _Name); }
            set { SetProperty(NameProperty, ref _Name, value); }
        }

        public static readonly PropertyInfo<DateTime> LastChangedProperty = RegisterProperty<DateTime>(p => p.LastChanged, RelationshipTypes.PrivateField);
        private DateTime _LastChanged = LastChangedProperty.DefaultValue;
        public DateTime LastChanged
        {
            get { return GetProperty(LastChangedProperty, _LastChanged); }
            set { SetProperty(LastChangedProperty, ref _LastChanged, value); }
        }

        //// Using managed backing field
        //public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id);
        //public Guid Id
        //{
        //    get { return GetProperty(IdProperty); }
        //    set { SetProperty(IdProperty, value); }
        //}

        //public static readonly PropertyInfo<string> NameProperty = RegisterProperty<string>(p => p.Name);
        //public string Name
        //{
        //    get { return GetProperty(NameProperty); }
        //    set { SetProperty(NameProperty, value); }
        //}

        //public static readonly PropertyInfo<DateTime> LastChangedProperty = RegisterProperty<DateTime>(p => p.LastChanged);
        //public DateTime LastChanged
        //{
        //    get { return GetProperty(LastChangedProperty); }
        //    set { SetProperty(LastChangedProperty, value); }
        //}

        #endregion

        #region Business Rules

        protected override void AddBusinessRules()
        {
            // TODO: add validation rules
            base.AddBusinessRules();

            //BusinessRules.AddRule(new Rule(IdProperty));
        }

        private static void AddObjectAuthorizationRules()
        {
            // TODO: add authorization rules
            //BusinessRules.AddRule(...);
        }

        #endregion

        #region Factory Methods

        public static AttributeER NewAttributeER()
        {
            return DataPortal.Create<AttributeER>();
        }

        public static AttributeER GetAttributeER(Guid id)
        {
            return DataPortal.Fetch<AttributeER>(id);
        }

        public static void DeleteAttributeER(Guid id)
        {
            DataPortal.Delete<AttributeER>(id);
        }

        private AttributeER()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        [RunLocal]
        protected override void DataPortal_Create()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: load default values
            // omit this override if you have no defaults to set
            Id = Guid.NewGuid();
            base.DataPortal_Create();
        }

        // TODO(crhodes): Add Fetch overload to take where clause.  Explore criteria objects.
        private void DataPortal_Fetch(Guid criteria)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeDAL>();
                
                // TODO(crhodes): Redo Fetch to take Guid directly and not a where clause.
                using (var data = dal.Fetch(string.Format("where attribute_id = '{0}'", criteria.ToString())))
                {
                    data.Read();
                    Id = data.GetGuid(0);
                    Name = data.GetString(1);
                    LastChanged = data.GetDateTime(2);
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
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Insert(Id, Name, "SomeOne", "For Some Reason");
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
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Update(Id, Name, "SomeOne", "For Some Reason", LastChanged);
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
        private void DataPortal_Delete(Guid criteria)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: delete values
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        #endregion
    }
}
