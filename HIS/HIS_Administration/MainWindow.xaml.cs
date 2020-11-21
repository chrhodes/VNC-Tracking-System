using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows;
using System.Xml.Linq;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

using PacificLife.Life;

namespace HIS_Administration
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_ADMINISTRATION;
        private const string PLLOG_APPNAME = "HIS";

        public MainWindow()
        {
            InitializeComponent();
        }

        #region Event Handlers

        private void btnAdminSchema_Click(object sender, RoutedEventArgs e)
        {
            Window wnd = new User_Interface.Windows.Admin_Schema();
            wnd.Show();
        }

        private void btnConstrainedValuesWindow_Click(object sender, RoutedEventArgs e)
        {
            Window wnd = new HIS_ConstrainedValues();
            wnd.Show();
        }

        private void btnHISSchemaWindow_Click(object sender, RoutedEventArgs e)
        {
            Window wnd = new HIS_SchemaECL();
            wnd.Show();
        }

        private void btnHISSchemaWindow2_Click(object sender, RoutedEventArgs e)
        {
            Window wnd = new HIS_SchemaECL_ChildLoad();
            wnd.Show();
        }

        private void btnItemDetail2Window_Click(object sender, RoutedEventArgs e)
        {
            Window wnd = new HIS_ItemDetail2();
            wnd.Show();
        }

        private void btnItemDetailWindow_Click(object sender, RoutedEventArgs e)
        {
            Window wnd = new HIS_ItemDetail();
            wnd.Show();
        }

        private void btnItemExplorerWindow_Click(object sender, RoutedEventArgs e)
        {
            Window wnd = new HIS_ItemExplorer();
            wnd.Show();
        }

        private void btnProcessProvisioningFile_Click(object sender, RoutedEventArgs e)
        {
            ProcessProvisioningFile();
        }

        #endregion


        #region Main Function Routines

        private void ProcessProvisioningFile()
        {
            Microsoft.Win32.OpenFileDialog openFileDialog = new Microsoft.Win32.OpenFileDialog();

            XElement hISSchema;

            openFileDialog.Filter = "XML Files (*.xml)|*.xml|All files (*.*)|(*.*)";
            openFileDialog.DefaultExt = "xml";

            if (openFileDialog.ShowDialog() == true)
            {
                using (var streamReader = new StreamReader(openFileDialog.FileName))
                {
                    hISSchema = XElement.Load(streamReader);
                    HIS.Library.Helper.ProcessXML(hISSchema);
                }
            }
        }

        #endregion

    }
}
