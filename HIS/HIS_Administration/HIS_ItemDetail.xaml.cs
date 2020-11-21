using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

using PacificLife.Life;

namespace HIS_Administration
{
    /// <summary>
    /// Interaction logic for HIS_ItemDetail.xaml
    /// </summary>
    public partial class HIS_ItemDetail : Window
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_ADMINISTRATION;
        private const string PLLOG_APPNAME = "HIS";

        HIS.Library.ItemsAll itemsAll;

        public HIS_ItemDetail()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            System.Windows.Data.CollectionViewSource itemsECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("itemsECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // itemsECLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource attributeValuesECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("attributeValuesECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // attributeValuesECLViewSource.Source = [generic data source]
            
            // Initialize the Schema so it is available when we start accessing items.
            HIS.Library.HISSchema schema = HIS.Library.Common.HISSchema;
        }

        private void GetItems()
        {
            long startTicks = PLLog.Trace("GetItems Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            double beginTicks;
            double bindingTicks;
            double fetchTicks;
            double firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            beginTicks = startTicks;

            //// Initialize the Schema so it is available when we start accessing items.
            //HIS.Library.HISSchema schema = HIS.Library.Common.HISSchema;

            itemsAll = HIS.Library.ItemsAll.Get();
            
            itemsECLDataGrid.ItemsSource = itemsAll.Items;

            fetchTicks = PLLog.Trace("ItemsAll.Get()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblLoadTimeTotal.Content = string.Format("ItemsAll.Get() Load Time ({0:f4}) seconds", (fetchTicks - startTicks) / frequency);
        }

        private void btnGetItems_Click(object sender, RoutedEventArgs e)
        {
            GetItems();
        }

        private void itemsECLDataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            long startTicks = PLLog.Trace("Item.Get(avId) Start", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            double beginTicks;
            double bindingTicks;
            double fetchTicks;
            double firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            HIS.Library.ItemEC seli = (HIS.Library.ItemEC)((DataGrid)sender).SelectedItem;
            Guid avId = seli.Id;
            HIS.Library.Item detailItem = HIS.Library.Item.Get(avId);

            //IEnumerable<HIS.Library.AttributeValueEC> matches = from av in itemsAll.AttributeValues
            //                                                      where av.ItemId == avId
            //                                                      select av;

            //attributeValuesECLDataGrid.ItemsSource = matches.ToList();

            attributeValuesECLDataGrid.ItemsSource = detailItem.AttributeValues;

            fetchTicks = PLLog.Trace("Item.Get(avId) End", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblAttributeValueLoadTimeTotal.Content = string.Format("Item.Get(avId) Load Time ({0:f4}) seconds", (fetchTicks - startTicks) / frequency);
        }
    }
}
