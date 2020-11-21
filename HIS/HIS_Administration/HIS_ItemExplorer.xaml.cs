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
    /// Interaction logic for HIS_ItemExplorer.xaml
    /// </summary>
    public partial class HIS_ItemExplorer : Window
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_ADMINISTRATION;
        private const string PLLOG_APPNAME = "HIS";

        HIS.Library.ItemsAll2 itemsAll;

        public HIS_ItemExplorer()
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
        }

        private void GetItems()
        {
            long startTicks = PLLog.Trace("HISSchema Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            double beginTicks;
            double bindingTicks;
            double firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            beginTicks = startTicks;

            // Initialize the Schema so it is available when we start accessing items.
            HIS.Library.HISSchema schema = HIS.Library.Common.HISSchema;

            itemsAll = HIS.Library.ItemsAll2.Get();
            
            itemsECLDataGrid.ItemsSource = itemsAll.Items;


            ////HIS.Library.HISSchema_ChildLoad hisSchema = HIS.Library.HISSchema_ChildLoad.Get();
            //hisSchema = HIS.Library.HISSchema_ChildLoad.Get();

            //startTicks = PLLog.Trace("HISSchemaECL_ChildLoad.Get", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //lblLoadTimeHISSchema.Content = string.Format("HISSchemaECL_ChildLoad.Get Parent Time ({0:f4}) seconds", (startTicks - beginTicks) / frequency);

            //beginTicks = startTicks;
            ////HIS.Library.ConstrainedValueListsECBL _ConstrainedValueLists = hisSchema.ConstrainedValueLists;
            //HIS.Library.ConstrainedValueListsECL _ConstrainedValueLists = hisSchema.ConstrainedValueLists;
            //bindingTicks = PLLog.Trace("HISSchemaECL_ChildLoad.ConstrainedValueLists()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            ////constrainedValueListsECBLBindingSource.DataSource = _ConstrainedValueLists;
            //constrainedValueListsECLDataGrid.ItemsSource = _ConstrainedValueLists;
            //startTicks = PLLog.Trace("HISSchemaECL_ChildLoad.ConstrainedValueLists() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //lblConstrainedValueLists.Content = string.Format("ConstrainedValueLists Time {0:f4} ({1:f4}) seconds", (startTicks - bindingTicks) / frequency, (bindingTicks - beginTicks) / frequency);

            //beginTicks = startTicks;
            //HIS.Library.ConstrainedValuesECL _ConstrainedValues = hisSchema.ConstrainedValues;
            //bindingTicks = PLLog.Trace("HISSchemaECL_ChildLoad.Tables()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            //// This shows all the values in the ConstrainedValues
            ////constrainedValuesECLDataGrid.ItemsSource = _ConstrainedValues;
            //// Instead we will selective load them from the SelectionChanged event.

            //startTicks = PLLog.Trace("HISSchemaECL_ChildLoad.ConstrainedValues() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //lblConstrainedValues.Content = string.Format("ConstrainedValues Time {0:f4} ({1:f4}) seconds", (startTicks - bindingTicks) / frequency, (bindingTicks - beginTicks) / frequency);

            //lblLoadTimeTotal.Content = string.Format("Total Time ({0:f4}) seconds", (startTicks - firstTicks) / frequency);
        }
        private void btnGetItems_Click(object sender, RoutedEventArgs e)
        {
            GetItems();
        }

        private void itemsECLDataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            HIS.Library.ItemEC seli = (HIS.Library.ItemEC)((DataGrid)sender).SelectedItem;
            //Guid cvId = Guid.Parse("{EA69AB8E-E1B2-4994-9C80-B56D11E7D8A3}");
            Guid avId = seli.Id;

            IEnumerable<HIS.Library.AttributeValueEC> matches = from av in itemsAll.AttributeValues
                                                                where av.ItemId == avId
                                                                select av;

            attributeValuesECLDataGrid.ItemsSource = matches.ToList();
        }
    }
}
