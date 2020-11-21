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
    /// Interaction logic for HIS_Schema.xaml
    /// </summary>
    public partial class HIS_SchemaECL : Window
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_ADMINISTRATION;
        private const string PLLOG_APPNAME = "HIS";

        public HIS_SchemaECL()
        {
            InitializeComponent();
        }

        private void btnLoadHISSchema_Click(object sender, RoutedEventArgs e)
        {
            LoadHISSchema();
        }


        private void LoadHISSchema()
        {
            long startTicks = PLLog.Trace("HISSchema Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
            long fetchTicks;
            long bindingTicks = 0;
            long firstTicks = startTicks;
            double frequency = Stopwatch.Frequency;

            //HIS.Library.HISSchema HISSchema = HIS.Library.HISSchema.Get();
            HIS.Library.HISSchema HISSchema = HIS.Library.Common.HISSchema;

            //his.library.hisschemaerlp hisschemaerlp = his.library.hisschemaerlp.neweditablerootparent();
            fetchTicks = PLLog.Trace("HISSchemaECL.Get", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            lblLoadTimeHISSchema.Content = string.Format("HISSchemaECL.Get Parent Load Time ({0:f4}) seconds", (fetchTicks - startTicks) / frequency);

            bindingTicks = fetchTicks;

            startTicks = bindingTicks;
            HIS.Library.TypesECL _Types = HISSchema.Types;
            fetchTicks = PLLog.Trace("HISSchemaECL.Types()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //typesECBLBindingSource.DataSource = _Types;
            typesECBLDataGrid.ItemsSource = _Types;
            bindingTicks = PLLog.Trace("HISSchemaECL.Types() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypes.Content = string.Format("Types Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.AttributesECL _Attributes = HISSchema.Attributes;
            fetchTicks = PLLog.Trace("HISSchemaECL.Attributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //attributesECBLBindingSource.DataSource = _Attributes;
            attributesECBLDataGrid.ItemsSource = _Attributes;
            bindingTicks = PLLog.Trace("HISSchemaECL.Attributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblAttributes.Content = string.Format("Attributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = fetchTicks;
            HIS.Library.TypeAttributesECL _TypeAttributes = HISSchema.TypeAttributes;
            fetchTicks = PLLog.Trace("HISSchemaECL.TypeAttributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //typeAttributesECBLBindingSource.DataSource = _TypeAttributes;
            typeAttributesECBLDataGrid.ItemsSource = _TypeAttributes;
            bindingTicks = PLLog.Trace("HISSchemaECL.TypeAttributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTypeAttributes.Content = string.Format("TypeAttributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.DataTypesECL _DataTypesECBL = HISSchema.DataTypes;
            fetchTicks = PLLog.Trace("HISSchemaECL.DataTypes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //dataTypesECBLBindingSource.DataSource = _DataTypesECBL;
            dataTypesECBLDataGrid.ItemsSource = _DataTypesECBL;
            bindingTicks = PLLog.Trace("HISSchemaECL.DataTypes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblDataTypes.Content = string.Format("DataTypes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.CharacteristicsECL _Chacteristics = HISSchema.Characteristics;
            fetchTicks = PLLog.Trace("HISSchemaECL.Characteristics()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //characteristicsECBLBindingSource.DataSource = _Chacteristics;
            characteristicsECBLDataGrid.ItemsSource = _Chacteristics;
            bindingTicks = PLLog.Trace("HISSchemaECL.Characteristics() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblCharacteristics.Content = string.Format("Characteristics Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            startTicks = bindingTicks;
            HIS.Library.TablesECL _TablesECBL = HISSchema.Tables;
            fetchTicks = PLLog.Trace("HISSchemaECL.Tables()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
            //tablesECBLBindingSource.DataSource = _TablesECBL;
            tablesECBLDataGrid.ItemsSource = _TablesECBL;
            bindingTicks = PLLog.Trace("HISSchemaECL.Tables() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

            lblTables.Content = string.Format("Tables Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
                (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

            lblLoadTimeTotal.Content = string.Format("LoadTime Total ({0:f4}) seconds", (bindingTicks - firstTicks) / frequency);

        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

            System.Windows.Data.CollectionViewSource typesECBLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("typesECBLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // typesECBLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource attributesECBLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("attributesECBLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // attributesECBLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource typeAttributesECBLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("typeAttributesECBLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // typeAttributesECBLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource characteristicsECBLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("characteristicsECBLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // characteristicsECBLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource dataTypesECBLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("dataTypesECBLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // dataTypesECBLViewSource.Source = [generic data source]
            System.Windows.Data.CollectionViewSource tablesECBLViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("tablesECBLViewSource")));
            // Load data by setting the CollectionViewSource.Source property:
            // tablesECBLViewSource.Source = [generic data source]
        }
    }
}
