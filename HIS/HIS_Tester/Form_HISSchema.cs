using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using PacificLife.Life;

namespace HIS_Tester
{
    public partial class Form_HISSchema : Form
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_TESTER;
        private const string PLLOG_APPNAME = "HIS";

        public Form_HISSchema()
        {
            InitializeComponent();
        }

        private void btnLoadHISSchema_Click(object sender, EventArgs e)
        {
            LoadHISSchema();
        }


        #region Main Function Routines

        private void LoadHISSchema()
        {
            long startTicks = PLLog.Trace("HISSchema Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            long fetchTicks;
            long bindingTicks;
            long firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            HIS.Library.HISSchemaECBL HISSchema = HIS.Library.HISSchemaECBL.Get();
            //HIS.Library.HISSchema HISSchema = HIS.Library.HISSchema.NewEditableRootParent();
            fetchTicks = PLLog.Trace("HISSchemaECBL.Get", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblLoadHISSchema.Text = string.Format("HISSchemaECBL.Get Parent Time ({0:f4}) seconds", (fetchTicks - startTicks) / frequency);

            startTicks = fetchTicks;
            HIS.Library.TypeAttributesECBL _TypeAttributes = HISSchema.TypeAttributes;
            fetchTicks = PLLog.Trace("HISSchemaECBL.TypeAttributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            typeAttributesECBLBindingSource.DataSource = _TypeAttributes;
            bindingTicks = PLLog.Trace("HISSchemaECBL.TypeAttributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypeAttributes.Text = string.Format("TypeAttributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.AttributesECBL _Attributes = HISSchema.Attributes;
            fetchTicks = PLLog.Trace("HISSchemaECBL.Attributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            attributesECBLBindingSource.DataSource = _Attributes;
            bindingTicks = PLLog.Trace("HISSchemaECBL.Attributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblAttributes.Text = string.Format("Attributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.TypesECBL _Types = HISSchema.Types;
            fetchTicks = PLLog.Trace("HISSchemaECBL.Types()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            typesECBLBindingSource.DataSource = _Types;
            bindingTicks = PLLog.Trace("HISSchemaECBL.Types() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypes.Text = string.Format("Types Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.DataTypesECBL _DataTypesECBL = HISSchema.DataTypes;
            fetchTicks = PLLog.Trace("HISSchemaECBL.DataTypes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            dataTypesECBLBindingSource.DataSource = _DataTypesECBL;
            bindingTicks = PLLog.Trace("HISSchemaECBL.DataTypes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblDataTypes.Text = string.Format("DataTypes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.CharacteristicsECBL _Chacteristics = HISSchema.Characteristics;
            fetchTicks = PLLog.Trace("HISSchemaECBL.Characteristics()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            characteristicsECBLBindingSource.DataSource = _Chacteristics;
            bindingTicks = PLLog.Trace("HISHISSchemaECBLSchema.Characteristics() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblCharacteristics.Text = string.Format("Characteristics Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.TablesECBL _TablesECBL = HISSchema.Tables;
            fetchTicks = PLLog.Trace("HISSchemaECBL.Tables()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            tablesECBLBindingSource.DataSource = _TablesECBL;
            bindingTicks = PLLog.Trace("HISSchemaECBL.Tables() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTables.Text = string.Format("Tables Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            lblTotalTime.Text = string.Format("Total Time ({0:f4}) seconds", (bindingTicks - firstTicks) / frequency);

        }

        #endregion
    }
}
