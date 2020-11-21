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
    public partial class Form_HISConstrainedValues : Form
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_TESTER;
        private const string PLLOG_APPNAME = "HIS";

        public Form_HISConstrainedValues()
        {
            InitializeComponent();
        }

        private void btnLoadHISSchema_Click(object sender, EventArgs e)
        {
            LoadHISSchema();
        }

        private void LoadHISSchema()
        {
            long startTicks = PLLog.Trace("HISSchema Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            double beginTicks;
            double bindingTicks;
            double firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            beginTicks = startTicks;
            HIS.Library.HISSchemaECBL_ChildLoad hISSchemaERLP = HIS.Library.HISSchemaECBL_ChildLoad.Get();

            startTicks = PLLog.Trace("HISSchemaERLP.GetEditableRootParent", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblLoadHISSchema.Text = string.Format("GetEditableRoot Parent Time ({0:f4}) seconds", (startTicks - beginTicks) / frequency);

            beginTicks = startTicks;
            HIS.Library.ConstrainedValueListsECBL _ConstrainedValueLists = hISSchemaERLP.ConstrainedValueLists;
            bindingTicks = PLLog.Trace("HISSchemaERLP.ConstrainedValueLists()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            constrainedValueListsECBLBindingSource.DataSource = _ConstrainedValueLists;
            startTicks = PLLog.Trace("HISSchemaERLP.ConstrainedValueLists() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblConstrainedValueLists.Text = string.Format("ConstrainedValueLists Time {0:f4} ({1:f4}) seconds", (startTicks - bindingTicks) / frequency, (bindingTicks - beginTicks) / frequency);

            beginTicks = startTicks;
            HIS.Library.ConstrainedValuesECBL _ConstrainedValues = hISSchemaERLP.ConstrainedValues;
            bindingTicks = PLLog.Trace("HISSchemaERLP.Tables()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            constrainedValuesECBLBindingSource.DataSource = _ConstrainedValues;
            startTicks = PLLog.Trace("HISSchemaERLP.ConstrainedValues() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblConstrainedValues.Text = string.Format("ConstrainedValues Time {0:f4} ({1:f4}) seconds", (startTicks - bindingTicks) / frequency, (bindingTicks - beginTicks) / frequency);

            lblTotalTime.Text = string.Format("Total Time ({0:f4}) seconds", (startTicks - firstTicks) / frequency);
        }
    }
}
