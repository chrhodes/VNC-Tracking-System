using System;
using System.Collections.Generic;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class AttributesERBL :
      BusinessBindingListBase<AttributesERBL, AttributeEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_DAL_SQL_ATTRIBUTE;
        private const string PLLOG_APPNAME = "HIS";

        #region Authorization Rules

        private static void AddObjectAuthorizationRules()
        {
            // TODO: add authorization rules
            //AuthorizationRules.AllowGet(typeof(AttributeERBL), "Role");
        }

        #endregion

        #region Factory Methods

        public static AttributesERBL NewAttributesERBL()
        {
            return DataPortal.Create<AttributesERBL>();
        }

        public static AttributesERBL GetAttributesERBL()
        {
            return DataPortal.Fetch<AttributesERBL>();
        }

        public static AttributesERBL GetAttributesERBL(int id)
        {
            return DataPortal.Fetch<AttributesERBL>(id);
        }

        private AttributesERBL()
        { /* Require use of factory methods */ }

        #endregion

        #region Data Access

        private void DataPortal_Fetch()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            RaiseListChangedEvents = false;

            using (var dalManager = HIS.DAL.DALFactory.GetManager())
            {
                var dal = dalManager.GetProvider<HIS.DAL.IAttributeDAL>();

                // TODO(crhodes): Redo Fetch to take Guid directly and not a where clause.
                using (var data = dal.Fetch())
                {
                    while (data.Read())
                    {
                        var item = DataPortal.FetchChild<AttributeEC>(data);
                        Add(item);
                        // TODO(crhodes): Hack. How to indicate this child matches the database.
                  
                    }
                }
            }

            RaiseListChangedEvents = true;
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        private void DataPortal_Fetch(int criteria)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            RaiseListChangedEvents = false;

            // TODO: load values into memory
            object childData = null;
            foreach (var item in (List<object>)childData)
                this.Add(AttributeEC.GetAttributeEC(childData));

            RaiseListChangedEvents = true;
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
            // TODO: open database, update values
            base.Child_Update();
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Delete(object criteria)
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            base.DataPortal_Delete(criteria);
#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }
                
        #endregion
    }
}
