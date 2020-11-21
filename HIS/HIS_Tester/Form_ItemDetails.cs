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
    public partial class Form_ItemDetails : Form
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_TESTER;
        private const string PLLOG_APPNAME = "HIS";

        public Form_ItemDetails()
        {
            InitializeComponent();
        }

        private void btnLoadItems_Click(object sender, EventArgs e)
        {
            LoadItems();
        }

        private void LoadItems()
        {
            long startTicks;
            long fetchTicks;
            long bindingTicks;
            double frequency = Stopwatch.Frequency;

            startTicks = PLLog.Trace("Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            HIS.Library.ItemsERLP _Items = HIS.Library.ItemsERLP.GetEditableRootParent();
            fetchTicks = PLLog.Trace("HIS.Library.ItemsERLP", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            itemsECBLBindingSource.DataSource = _Items.Items;
            bindingTicks = PLLog.Trace("HIS.Library.ItemsERLP", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, fetchTicks);
           
            lblItems.Text = string.Format("Items Time {0:f4} (F:{1:f4} B:{2:f4}) seconds", 
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            // TODO(crhodes): Need to get the item_id from the selected row in the datagrid 
            // and use that to get the AttributeValues property from that row.
            //attributeValuesECBLBindingSource.DataSource = ;
        }

        private void btnLoadAttributeValues_Click(object sender, EventArgs e)
        {
            LoadItemAttributeValues();
        }

        private void LoadItemAttributeValues()
        {
            HIS.Library.Item item = HIS.Library.Item.Get(Guid.Parse(txtItemId.Text));
            attributeValuesECBLBindingSource.DataSource = item.AttributeValues;
        }

        private void itemsECBLDataGridView_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            string item_id = itemsECBLDataGridView[0, e.RowIndex].Value.ToString();
            txtItemId.Text = item_id;
            LoadItemAttributeValues();
        }
    }
}
