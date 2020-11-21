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
    public partial class Form_HISSchema_ChildLoad : Form
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_TESTER;
        private const string PLLOG_APPNAME = "HIS";

        public Form_HISSchema_ChildLoad()
        {
            InitializeComponent();
        }

        #region Event Handlers

        private void btnLoadHISSchema_Click(object sender, EventArgs e)
        {
            LoadHISSchema();
        }

        #endregion

        #region Main Function Routines

        private void LoadHISSchema()
        {
            long startTicks = PLLog.Trace("HISSchemaECBL_ChildLoad Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            long fetchTicks;
            long bindingTicks;
            long firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            HIS.Library.HISSchemaECBL_ChildLoad HISSchema = HIS.Library.HISSchemaECBL_ChildLoad.Get();
            //HIS.Library.HISSchemaERLP hISSchemaERLP = HIS.Library.HISSchemaERLP.NewEditableRootParent();
            fetchTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Get", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblLoadHISSchema.Text = string.Format("HISSchemaECBL_ChildLoad.Get Parent Time ({0:f4}) seconds", (fetchTicks - startTicks) / frequency);

            startTicks = fetchTicks;
            HIS.Library.TypeAttributesECBL _TypeAttributes = HISSchema.TypeAttributes;
            fetchTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.TypeAttributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            typeAttributesECBLBindingSource.DataSource = _TypeAttributes;
            bindingTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.TypeAttributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypeAttributes.Text = string.Format("TypeAttributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.AttributesECBL _Attributes = HISSchema.Attributes;
            fetchTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Attributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            attributesECBLBindingSource.DataSource = _Attributes;
            bindingTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Attributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblAttributes.Text = string.Format("Attributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.TypesECBL _Types = HISSchema.Types;
            fetchTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Types()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            typesECBLBindingSource.DataSource = _Types;
            bindingTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Types() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypes.Text = string.Format("Types Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.DataTypesECBL _DataTypesECBL = HISSchema.DataTypes;
            fetchTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.DataTypes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            dataTypesECBLBindingSource.DataSource = _DataTypesECBL;
            bindingTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.DataTypes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblDataTypes.Text = string.Format("DataTypes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.CharacteristicsECBL _Chacteristics = HISSchema.Characteristics;
            fetchTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Characteristics()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            characteristicsECBLBindingSource.DataSource = _Chacteristics;
            bindingTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Characteristics() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblCharacteristics.Text = string.Format("Characteristics Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.TablesECBL _TablesECBL = HISSchema.Tables;
            fetchTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Tables()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            tablesECBLBindingSource.DataSource = _TablesECBL;
            bindingTicks = PLLog.Trace("HISSchemaECBL_ChildLoad.Tables() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTables.Text = string.Format("Tables Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            lblTotalTime.Text = string.Format("Total Time ({0:f4}) seconds", (bindingTicks - firstTicks) / frequency);

        }

        #endregion

    }
}
