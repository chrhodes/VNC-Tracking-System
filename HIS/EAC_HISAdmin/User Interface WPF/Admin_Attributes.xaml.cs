using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace EAC_HISAdmin.User_Interface.User_Controls_WPF
{
    /// <summary>
    /// Interaction logic for Admin_Attributes.xaml
    /// </summary>
    public partial class Admin_Attributes : ucBase
    {
        public Admin_Attributes()
        {
            InitializeComponent();
            Title = "Administer HISSchema.Attributes";
        }


        //// Fields...
        //private HIS.Library.AttributesECL _Attributes;

        //public HIS.Library.AttributesECL Attributes
        //{
        //    get { return _Attributes; }
        //    set { _Attributes = value; }
        //}

        #region Event Handlers

        private void canAddCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            if (dataGrid != null)
            {
                dataGrid.CanUserAddRows = true;
            }
        }

        private void canAddCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {
            if (dataGrid != null)
            {
                dataGrid.CanUserAddRows = false;
            }
        }

        private void canDeleteCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            if (dataGrid != null)
            {
                dataGrid.CanUserDeleteRows = true;
            }
        }

        private void canDeleteCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {
            if (dataGrid != null)
            {
                dataGrid.CanUserDeleteRows = false;
            }
        }

        private void readOnlyCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            if (dataGrid != null)
            {
                dataGrid.IsReadOnly = true;
            }
        }

        private void readOnlyCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {
            if (dataGrid != null)
            {
                dataGrid.IsReadOnly = false;
            }
        }

        #endregion

        private void saveButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                //HIS.Library.Common.HISSchema.Save();
                MessageBox.Show("Your changes were saved");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Your changes were not saved");
                MessageBox.Show(ex.Message);
            }
        }

        private void undoButton_Click(object sender, RoutedEventArgs e)
        {
            //HIS.Library.Common.HISSchema.CancelEdit();
        }

        private void dataGrid_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Delete &&
              _editMode == false &&
              dataGrid.CanUserDeleteRows == true)
            {
                if (MessageBox.Show("Do you want to delete this Attribute?", "Attributes", MessageBoxButton.YesNo) ==
                  MessageBoxResult.Yes)
                {
                    //Attributes.Remove((HIS.Library.AttributeEC)dataGrid.SelectedItem);
                }
                else
                {
                    e.Handled = true;
                }
            }
        }

        private void dataGrid_BeginningEdit(object sender, DataGridBeginningEditEventArgs e)
        {
            _editMode = true;
        }

        private void dataGrid_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {
            _editMode = false;
        }
    }
}
