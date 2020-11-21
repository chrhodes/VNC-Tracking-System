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

namespace HIS_Administration.User_Interface.User_Controls
{
    /// <summary>
    /// Interaction logic for Admin_TypeAttributes.xaml
    /// </summary>
    public partial class Admin_TypeAttributes : ucBase
    {
        public Admin_TypeAttributes()
        {
            InitializeComponent();
            Title = "Administer HISSchema.TypeAttributes Table";
        }

        //private bool _editMode = false;

        private HIS.Library.TypeAttributesECL _TypeAttributes;

        public HIS.Library.TypeAttributesECL TypeAttributes
        {
            get { return _TypeAttributes; }
            set { _TypeAttributes = value; }
        }

        #region Event Handlers

        private void canAddCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            if (typeAttributesDataGrid != null)
            {
                typeAttributesDataGrid.CanUserAddRows = true;
            }
        }

        private void canAddCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {
            if (typeAttributesDataGrid != null)
            {
                typeAttributesDataGrid.CanUserAddRows = false;
            }
        }

        private void canDeleteCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            if (typeAttributesDataGrid != null)
            {
                typeAttributesDataGrid.CanUserDeleteRows = true;
            }
        }

        private void canDeleteCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {
            if (typeAttributesDataGrid != null)
            {
                typeAttributesDataGrid.CanUserDeleteRows = false;
            }
        }

        private void readOnlyCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            if (typeAttributesDataGrid != null)
            {
                typeAttributesDataGrid.IsReadOnly = true;
            }
        }

        private void readOnlyCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {
            if (typeAttributesDataGrid != null)
            {
                typeAttributesDataGrid.IsReadOnly = false;
            }
        }

        #endregion

        private void saveButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                HIS.Library.Common.HISSchema.Save();
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
            HIS.Library.Common.HISSchema.CancelEdit();
        }

        private void typeAttributesDataGrid_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Delete &&
              _editMode == false &&
              typeAttributesDataGrid.CanUserDeleteRows == true)
            {
                if (MessageBox.Show(
                  "Do you want to delete this category?",
                  "Categories", MessageBoxButton.YesNo) ==
                  MessageBoxResult.Yes)
                {
                    TypeAttributes.Remove((HIS.Library.TypeAttributeEC)typeAttributesDataGrid.SelectedItem);
                }
                else
                {
                    e.Handled = true;
                }
            }
        }

        private void typeAttributesDataGrid_BeginningEdit(object sender, DataGridBeginningEditEventArgs e)
        {
            _editMode = true;
        }

        private void typeAttributesDataGrid_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {
            _editMode = false;
        }
    }
}
