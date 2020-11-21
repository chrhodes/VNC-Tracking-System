using System;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class AttributeValueEC : BusinessBase<AttributeValueEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_ATTRIBUTEVALUE;
        private const string PLLOG_APPNAME = "HIS";

        #region Business Methods

        // TODO: add your own fields, properties and methods

        public static readonly PropertyInfo<Guid> IdProperty = RegisterProperty<Guid>(p => p.Id);
        public Guid Id
        {
            get { return GetProperty(IdProperty); }
            set { SetProperty(IdProperty, value); }
        }

        public static readonly PropertyInfo<int> TableIdProperty = RegisterProperty<int>(p => p.TableId);
        public int TableId
        {
            get { return GetProperty(TableIdProperty); }
            set { SetProperty(TableIdProperty, value); }
        }

        public static readonly PropertyInfo<Guid> ItemIdProperty = RegisterProperty<Guid>(p => p.ItemId);
        public Guid ItemId
        {
            get { return GetProperty(ItemIdProperty); }
            set { SetProperty(ItemIdProperty, value); }
        }

        public static readonly PropertyInfo<Guid> TypeAttributeIdProperty = RegisterProperty<Guid>(p => p.TypeAttributeId);
        public Guid TypeAttributeId
        {
            get { return GetProperty(TypeAttributeIdProperty); }
            set { SetProperty(TypeAttributeIdProperty, value); }
        }

        public static readonly PropertyInfo<string> ValueProperty = RegisterProperty<string>(p => p.Value);
        public string Value
        {
            get { return GetProperty(ValueProperty); }
            set { SetProperty(ValueProperty, value); }
        }

        public static readonly PropertyInfo<DateTime> LastChangedProperty = RegisterProperty<DateTime>(p => p.LastChanged);
        public DateTime LastChanged
        {
            get { return GetProperty(LastChangedProperty); }
            set { SetProperty(LastChangedProperty, value); }
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

        internal static AttributeValueEC New()
        {
            return DataPortal.CreateChild<AttributeValueEC>();
        }

        internal static AttributeValueEC Get()
        {
            return DataPortal.FetchChild<AttributeValueEC>();
        }

        internal static AttributeValueEC Get(object childData)
        {
            return DataPortal.FetchChild<AttributeValueEC>(childData);
        }

        private AttributeValueEC()
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
            Id = childData.GetGuid(0);
            TableId = childData.GetInt32(1);
            ItemId = childData.GetGuid(2);
            TypeAttributeId = childData.GetGuid(3);
            Value = childData.GetString(4);
            LastChanged = childData.GetDateTime(5);
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
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeValueDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Insert(Id, TableId, ItemId, TypeAttributeId, Value, "SomeOne", "For Some Reason");
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
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeValueDAL>();

                using (BypassPropertyChecks)
                {
                    LastChanged = dal.Update(Id, TableId, ItemId, TypeAttributeId, Value, "SomeOne", "For Some Reason", LastChanged);
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
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeValueDAL>();

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
