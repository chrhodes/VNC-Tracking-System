using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml;

namespace ODBAdmin
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ODB.ODBHelper odbHelper = new ODB.ODBHelper();

            ODB.ODBHelper.Schema odbSchema = new ODB.ODBHelper.Schema();
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(ODBAdmin.Properties.Resources.ODBSchemaFile);

            odbSchema.ProcessXML(xmlDoc);
        }
    }
}
