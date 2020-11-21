using System;
using System.Collections.Generic;

using Csla;
using PacificLife.Life;

namespace HIS.Library
{
    [Serializable]
    public class AttributesERL :
      BusinessListBase<AttributesERL, AttributeEC>
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_DAL_SQL_CHARACTERISTIC;
        private const string PLLOG_APPNAME = "HIS";

        #region Authorization Rules

        private static void AddObjectAuthorizationRules()
        {
            // TODO: add authorization rules
            //AuthorizationRules.AllowGet(typeof(AttributesERL), "Role");
        }

        #endregion

        #region Factory Methods

        public static AttributesERL NewAttributesERL()
        {
            return DataPortal.Create<AttributesERL>();
        }

        public static AttributesERL GetAttributesERL()
        {
            return DataPortal.Fetch<AttributesERL>();
        }

        public static AttributesERL GetAttributesERL(Guid id)
        {
            return DataPortal.Fetch<AttributesERL>(id);
        }

        private AttributesERL()
        { /* Require use of factory methods */
            // Allow adding new items in grid

            AllowNew = true;
        }

        protected override AttributeEC AddNewCore()
        {
            var item = AttributeEC.NewAttributeEC();
            Add(item);
            return item;
        }
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
                    }

                    //foreach (var item in (List<AttributeEC>)data)
                    //{
                    //    this.Add(AttributeEC.GetAttributeEC(item));
                    //}
                }
            }

            RaiseListChangedEvents = true;
        }

        private void DataPortal_Fetch(int criteria)
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
                    }

                    //foreach (var item in (List<AttributeEC>)data)
                    //{
                    //    this.Add(AttributeEC.GetAttributeEC(item));
                    //}
                }
            }

            RaiseListChangedEvents = true;
        }

        [Transactional(TransactionalTypes.TransactionScope)]
        protected override void DataPortal_Update()
        {
#if TRACE
            long startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
#endif
            // TODO: open database, update values
            //base.Child_Update();

            foreach (var Item in this)
            {

                Item.Save();

            }

#if TRACE
            PLLog.Trace("End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 3, startTicks);
#endif
        }

        #endregion
    }
}
