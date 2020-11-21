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
    /// Interaction logic for HIS_Schema2.xaml
    /// </summary>
    public partial class HIS_SchemaECL_ChildLoad : Window
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_TESTER;
        private const string PLLOG_APPNAME = "HIS";

        public HIS_SchemaECL_ChildLoad()
        {
            InitializeComponent();
        }


        private void LoadHISSchema()
        {
            long startTicks = PLLog.Trace("HISSchemaECL_ChildLoad.Get Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            long fetchTicks;
            long bindingTicks = 0;
            long firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            HIS.Library.HISSchema_ChildLoad HISSchema = HIS.Library.HISSchema_ChildLoad.Get();
            //his.library.hisschemaerlp hisschemaerlp = his.library.hisschemaerlp.neweditablerootparent();
            fetchTicks = PLLog.Trace("HISSchemaECL_ChildLoad.Get", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblLoadTimeHISSchema.Content = string.Format("HISSchemaECL_ChildLoad.Get Parent Load Time ({0:f4}) seconds", (fetchTicks - startTicks) / frequency);

            bindingTicks = fetchTicks;

            startTicks = bindingTicks;
            HIS.Library.TypesECL _Types = HISSchema.Types;
            fetchTicks = PLLog.Trace("HISSchema.Types()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //typesECLBindingSource.DataSource = _Types;
            typesECLDataGrid.ItemsSource = _Types;
            bindingTicks = PLLog.Trace("HISSchema.Types() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypes.Content = string.Format("Types Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.AttributesECL _Attributes = HISSchema.Attributes;
            fetchTicks = PLLog.Trace("HISSchema.Attributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //attributesECLBindingSource.DataSource = _Attributes;
            attributesECLDataGrid.ItemsSource = _Attributes;
            bindingTicks = PLLog.Trace("HISSchema.Attributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblAttributes.Content = string.Format("Attributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = fetchTicks;
            HIS.Library.TypeAttributesECL _TypeAttributes = HISSchema.TypeAttributes;
            fetchTicks = PLLog.Trace("HISSchema.TypeAttributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //typeAttributesECLBindingSource.DataSource = _TypeAttributes;
            typeAttributesECLDataGrid.ItemsSource = _TypeAttributes;
            bindingTicks = PLLog.Trace("HISSchema.TypeAttributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypeAttributes.Content = string.Format("TypeAttributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.DataTypesECL _DataTypesECL = HISSchema.DataTypes;
            fetchTicks = PLLog.Trace("HISSchema.DataTypes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //dataTypesECLBindingSource.DataSource = _DataTypesECL;
            dataTypesECLDataGrid.ItemsSource = _DataTypesECL;
            bindingTicks = PLLog.Trace("HISSchema.DataTypes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblDataTypes.Content = string.Format("DataTypes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.CharacteristicsECL _Chacteristics = HISSchema.Characteristics;
            fetchTicks = PLLog.Trace("HISSchema.Characteristics()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //characteristicsECLBindingSource.DataSource = _Chacteristics;
            characteristicsECLDataGrid.ItemsSource = _Chacteristics;
            bindingTicks = PLLog.Trace("HISSchema.Characteristics() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblCharacteristics.Content = string.Format("Characteristics Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.TablesECL _TablesECL = HISSchema.Tables;
            fetchTicks = PLLog.Trace("HISSchema.Tables()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //tablesECLBindingSource.DataSource = _TablesECL;
            tablesECLDataGrid.ItemsSource = _TablesECL;
            bindingTicks = PLLog.Trace("HISSchema.Tables() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTables.Content = string.Format("Tables Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            lblLoadTimeTotal.Content = string.Format("LoadTime Total ({0:f4}) seconds", (bindingTicks - firstTicks) / frequency);

        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            System.Windows.Data.CollectionViewSource typesECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("typesECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // typesECLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource attributesECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("attributesECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // attributesECLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource typeAttributesECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("typeAttributesECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // typeAttributesECLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource characteristicsECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("characteristicsECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // characteristicsECLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource dataTypesECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("dataTypesECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // dataTypesECLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource tablesECLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("tablesECLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // tablesECLViewSource.Source = [generic data source]
        }

        private void btnLoadHISSchema_Click(object sender, RoutedEventArgs e)
        {
            LoadHISSchema();
        }
    }
}
