using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using PacificLife.Life;

namespace HIS.Library
{
    public class Common
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_LIBRARY_HISSCHEMA;
        private const string PLLOG_APPNAME = "HIS";

        private static HIS.Library.HISSchema _HISSchema;
        public static HIS.Library.HISSchema HISSchema
        {
            get
            {
                if (null == _HISSchema)
                {
                    long startTicks = PLLog.Trace("Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 0);
                    _HISSchema = HIS.Library.HISSchema.Get();
                    PLLog.Trace("End()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
                }

                return _HISSchema;
            }
            set
            {
                _HISSchema = value;
            }
        }
    }
}
