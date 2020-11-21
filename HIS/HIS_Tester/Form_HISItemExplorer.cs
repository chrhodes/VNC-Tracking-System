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
    public partial class Form_HISItemExplorer : Form
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_TESTER;
        private const string PLLOG_APPNAME = "HIS";

        public Form_HISItemExplorer()
        {
            InitializeComponent();
        }

        private void btnLoadItems_Click(object sender, EventArgs e)
        {
            LoadItemExplorer();
        }

         private void LoadItemExplorer()
        {
            long startTicks = PLLog.Trace("HISSchema Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            long beginTicks;
            long bindingTicks;
            long firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            beginTicks = startTicks;
            //HIS.Library.HISSchemaERLP hISSchemaERLP = HIS.Library.HISSchemaERLP.GetEditableRootParent();
            ////HIS.Library.HISSchemaERLP hISSchemaERLP = HIS.Library.HISSchemaERLP.NewEditableRootParent();
            //startTicks = PLLog.Trace("HISSchemaERLP.GetEditableRootParent", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //lblLoadHISSchema.Text = string.Format("GetEditableRoot Parent Time ({0:f4}) seconds", (startTicks - beginTicks) / frequency);

            beginTicks = startTicks;
            HIS.Library.ItemsERLP _Items = HIS.Library.ItemsERLP.GetEditableRootParent();

            //bindingTicks = PLLog.Trace("HISSchemaERLP.TypeAttributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            itemsECBLBindingSource.DataSource = _Items.Items;
            attributeValuesECBLBindingSource.DataSource = _Items.AttributeValues;

            //startTicks = PLLog.Trace("HISSchemaERLP.TypeAttributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //lblTypeAttributes.Text = string.Format("TypeAttributes Time {0:f4} ({1:f4}) seconds", (startTicks - bindingTicks) / frequency, (bindingTicks - beginTicks) / frequency);

            //beginTicks = startTicks;
            //HIS.Library.AttributesECBL _Attributes = hISSchemaERLP.Attributes;
            //bindingTicks = PLLog.Trace("HISSchemaERLP.Attributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //attributesECBLBindingSource.DataSource = _Attributes;
            //startTicks = PLLog.Trace("HISSchemaERLP.Attributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //lblAttributes.Text = string.Format("Attributes Time {0:f4} ({1:f4}) seconds", (startTicks - bindingTicks) / frequency, (bindingTicks - beginTicks) / frequency);


        }
    }
}
