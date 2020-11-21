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
    /// Interaction logic for Admin_ConstrainedValues.xaml
    /// </summary>
    public partial class Admin_ConstrainedValues : ucBase
    {
        public Admin_ConstrainedValues()
        {
            InitializeComponent();
            Title = "Administer HISSchema.ConstrainedValues Table";
        }

        private void readOnlyCheckBox_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void canAddCheckBox_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void canDeleteCheckBox_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void readOnlyCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {

        }

        private void canAddCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {

        }

        private void canDeleteCheckBox_UnChecked(object sender, RoutedEventArgs e)
        {

        }

        private void saveButton_Click(object sender, RoutedEventArgs e)
        {

        }

        private void undoButton_Click(object sender, RoutedEventArgs e)
        {

        }

        private void constrainedValuesDataGrid_PreviewKeyDown(object sender, KeyEventArgs e)
        {

        }

        private void constrainedValuesDataGrid_BeginningEdit(object sender, DataGridBeginningEditEventArgs e)
        {

        }

        private void constrainedValuesDataGrid_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {

        }
    }
}
