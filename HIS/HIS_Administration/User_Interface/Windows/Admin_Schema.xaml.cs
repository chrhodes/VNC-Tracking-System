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

namespace HIS_Administration.User_Interface.Windows
{
    /// <summary>
    /// Interaction logic for Admin_Schema.xaml
    /// </summary>
    public partial class Admin_Schema : Window
    {
        private readonly static int CLASS_BASE_ERRORNUMBER = HIS.ErrorNumbers.HIS_ADMINISTRATION;
        private const string PLLOG_APPNAME = "HIS";

        public Admin_Schema()
        {
            InitializeComponent();
        }

        private ucBase _currentControl;
        HIS.Library.HISSchema _schema;

        #region Event Handlers

        private void btnAttributes_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_Attributes uc = new User_Controls.Admin_Attributes();
            uc.dataGrid.ItemsSource = _schema.Attributes;
            ShowUserControl(uc);
        }

        private void btnCharacteristics_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_Characteristics uc = new User_Controls.Admin_Characteristics();
            uc.characteristicsDataGrid.ItemsSource = _schema.Characteristics;
            ShowUserControl(uc);
        }

        private void btnConstrainedValueLists_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_ConstrainedValueLists uc = new User_Controls.Admin_ConstrainedValueLists();
            uc.constrainedValueListsDataGrid.ItemsSource = _schema.ConstrainedValueLists;
            ShowUserControl(uc);
        }

        private void btnConstrainedValues_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_ConstrainedValues uc = new User_Controls.Admin_ConstrainedValues();
            uc.constrainedValuesDataGrid.ItemsSource = _schema.ConstrainedValues;
            ShowUserControl(uc);
        }

        private void btnDataTypes_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_DataTypes uc = new User_Controls.Admin_DataTypes();
            uc.dataGrid.ItemsSource = _schema.DataTypes;
            ShowUserControl(uc);
        }

        private void UnhookTitleEvent(ucBase control)
        {
            if (control != null)
            {
                control.TitleChanged -= SetTitle;
            }
        }

        private void ShowUserControl(ucBase control)
        {
            UnhookTitleEvent(_currentControl);
            dpUserControlContainer.Children.Clear();

            if (control != null)
            {
            	dpUserControlContainer.Children.Add(control);
                _currentControl = control;
            }

            HookTitleEvent(_currentControl);
        }

        private void HookTitleEvent(ucBase control)
        {
            SetTitle(control, EventArgs.Empty);

            if (control != null)
            {
                control.TitleChanged += SetTitle;
            }

        }
        private void SetTitle(object sender, EventArgs e)
        {
            ucBase uc = sender as ucBase;

            if (uc != null && ! string.IsNullOrEmpty(uc.Title))
            {
            	this.Title = string.Format("{0}", uc.Title);
            }
            else
            {
                this.Title = "main Form";
            }
        }

        private void btnTables_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_Tables uc = new User_Controls.Admin_Tables();
            uc.dataGrid.ItemsSource = _schema.Tables;
            uc.Tables = HIS.Library.Common.HISSchema.Tables;
            ShowUserControl(uc);
        }

        private void btnTypeAttributes_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_TypeAttributes uc = new User_Controls.Admin_TypeAttributes();
            uc.typeAttributesDataGrid.ItemsSource = _schema.TypeAttributes;
            ShowUserControl(uc);
        }

        private void btnTypes_Click(object sender, RoutedEventArgs e)
        {
            HIS_Administration.User_Interface.User_Controls.Admin_Types uc = new User_Controls.Admin_Types();
            uc.dataGrid.ItemsSource = _schema.Types;
            ShowUserControl(uc);
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // Initialize the Schema so it is available when we start accessing items.
            _schema = HIS.Library.Common.HISSchema;
        }
        #endregion


        //private void LoadHISSchema()
        //{
        //    long startTicks = PLLog.Trace("HISSchema Start()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1);
        //    long fetchTicks;
        //    long bindingTicks = 0;
        //    long firstTicks = startTicks;
        //    double frequency = Stopwatch.Frequency;

        //    //HIS.Library.HISSchema HISSchema = HIS.Library.HISSchema.Get();
        //    HIS.Library.HISSchema HISSchema = HIS.Library.Common.HISSchema;

        //    //his.library.hisschemaerlp hisschemaerlp = his.library.hisschemaerlp.neweditablerootparent();
        //    fetchTicks = PLLog.Trace("HISSchemaECL.Get", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
        //    lblLoadTimeHISSchema.Content = string.Format("HISSchemaECL.Get Parent Load Time ({0:f4}) seconds", (fetchTicks - startTicks) / frequency);

        //    bindingTicks = fetchTicks;

        //    startTicks = bindingTicks;
        //    HIS.Library.TypesECL _Types = HISSchema.Types;
        //    fetchTicks = PLLog.Trace("HISSchemaECL.Types()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
        //    //typesECBLBindingSource.DataSource = _Types;
        //    typesECBLDataGrid.ItemsSource = _Types;
        //    bindingTicks = PLLog.Trace("HISSchemaECL.Types() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

        //    lblTypes.Content = string.Format("Types Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
        //        (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

        //    startTicks = bindingTicks;
        //    HIS.Library.AttributesECL _Attributes = HISSchema.Attributes;
        //    fetchTicks = PLLog.Trace("HISSchemaECL.Attributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
        //    //attributesECBLBindingSource.DataSource = _Attributes;
        //    attributesECBLDataGrid.ItemsSource = _Attributes;
        //    bindingTicks = PLLog.Trace("HISSchemaECL.Attributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

        //    lblAttributes.Content = string.Format("Attributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
        //        (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

        //    startTicks = fetchTicks;
        //    HIS.Library.TypeAttributesECL _TypeAttributes = HISSchema.TypeAttributes;
        //    fetchTicks = PLLog.Trace("HISSchemaECL.TypeAttributes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
        //    //typeAttributesECBLBindingSource.DataSource = _TypeAttributes;
        //    typeAttributesECBLDataGrid.ItemsSource = _TypeAttributes;
        //    bindingTicks = PLLog.Trace("HISSchemaECL.TypeAttributes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

        //    lblTypeAttributes.Content = string.Format("TypeAttributes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
        //        (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

        //    startTicks = bindingTicks;
        //    HIS.Library.DataTypesECL _DataTypesECBL = HISSchema.DataTypes;
        //    fetchTicks = PLLog.Trace("HISSchemaECL.DataTypes()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
        //    //dataTypesECBLBindingSource.DataSource = _DataTypesECBL;
        //    dataTypesECBLDataGrid.ItemsSource = _DataTypesECBL;
        //    bindingTicks = PLLog.Trace("HISSchemaECL.DataTypes() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

        //    lblDataTypes.Content = string.Format("DataTypes Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
        //        (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

        //    startTicks = bindingTicks;
        //    HIS.Library.CharacteristicsECL _Chacteristics = HISSchema.Characteristics;
        //    fetchTicks = PLLog.Trace("HISSchemaECL.Characteristics()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
        //    //characteristicsECBLBindingSource.DataSource = _Chacteristics;
        //    characteristicsECBLDataGrid.ItemsSource = _Chacteristics;
        //    bindingTicks = PLLog.Trace("HISSchemaECL.Characteristics() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

        //    lblCharacteristics.Content = string.Format("Characteristics Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
        //        (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

        //    startTicks = bindingTicks;
        //    HIS.Library.TablesECL _TablesECBL = HISSchema.Tables;
        //    fetchTicks = PLLog.Trace("HISSchemaECL.Tables()", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);
        //    //tablesECBLBindingSource.DataSource = _TablesECBL;
        //    tablesECBLDataGrid.ItemsSource = _TablesECBL;
        //    bindingTicks = PLLog.Trace("HISSchemaECL.Tables() Binding", PLLOG_APPNAME, CLASS_BASE_ERRORNUMBER + 1, startTicks);

        //    lblTables.Content = string.Format("Tables Time {0:f4} (F:{1:f4} B:{2:f4}) seconds",
        //        (bindingTicks - startTicks) / frequency, (fetchTicks - startTicks) / frequency, (bindingTicks - fetchTicks) / frequency);

        //    lblLoadTimeTotal.Content = string.Format("LoadTime Total ({0:f4}) seconds", (bindingTicks - firstTicks) / frequency);

        //}
    }
}
