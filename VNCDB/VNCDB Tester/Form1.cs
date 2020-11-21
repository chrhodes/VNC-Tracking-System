using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace VNCDB_Tester
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            VNCDB.Book book = VNCDB.Book.NewBook();

            book.Name = "My First VNCDB Book";
            book.Author = "Vikki Schanz";
            Guid itemend = new Guid(node.Attributes.GetNamedItem("itemend").Value);
            book.Save();

        }
    }
}
