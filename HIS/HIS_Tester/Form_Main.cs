using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using System.Text;
using System.Windows.Forms;


namespace HIS_Tester
{
    public partial class Form_Main : Form
    {
        public Form_Main()
        {
            InitializeComponent();
        }

        private void ProcessProvisioningFile()
        {
            XElement hISSchema;

            openFileDialog.Filter = "XML Files (*.xml)|*.xml|All files (*.*)|(*.*)";

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                using (var streamReader = new StreamReader(openFileDialog.FileName) )
                {
                    hISSchema = XElement.Load(streamReader);
                    HIS.Library.Helper.ProcessXML(hISSchema);
                }
            }
        }

        private void btnProcessProvisioningFile_Click(object sender, EventArgs e)
        {
            ProcessProvisioningFile();
        }

        private HIS.Library.AttributeER _NewAttr;

        private HIS.Library.AttributesERBL _AttributesERBL;
        private void btnGetAttributesERBL_Click(object sender, EventArgs e)
        {
            _AttributesERBL = HIS.Library.AttributesERBL.GetAttributesERBL();

            bindingSource1.DataSource = _AttributesERBL;
            dataGridView2.DataSource = bindingSource1;
            //dataGridView2.DataSource = _AttributesERBL.GetEnumerator();
            //dataGridView2.Columns[0].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
        }

        private void dataGridView2_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            //_AttributesERBL = _AttributesERBL.Save();
        }

        private void btnSaveAttributesERBL_Click(object sender, EventArgs e)
        {
            _AttributesERBL.Save();
        }

        private void btnLoadHISSchemaForm_Click(object sender, EventArgs e)
        {
            Form frm = new Form_HISSchema_ChildLoad();
            frm.Show();
        }

        private void btnHISConstrainedValuesForm_Click(object sender, EventArgs e)
        {
            Form frm = new Form_HISConstrainedValues();
            frm.Show();
        }

        private void btnHISItemExplorer_Click(object sender, EventArgs e)
        {
            Form frm = new Form_HISItemExplorer();
            frm.Show();
        }

        private void btnHISSchema2Form_Click(object sender, EventArgs e)
        {
            Form frm = new Form_HISSchema();
            frm.Show();
        }

        private void btnItemDetailForm_Click(object sender, EventArgs e)
        {
            Form frm = new Form_ItemDetails();
            frm.Show();
        }

        private void btnItemDetail2Form_Click(object sender, EventArgs e)
        {
            Form frm = new Form_HISItemDetail2();
            frm.Show();
        }

    }
}
