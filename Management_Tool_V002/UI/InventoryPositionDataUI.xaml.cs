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
using System.Windows.Shapes;
using System.Data.SqlClient;

namespace Management_Tool_V002.UI
{
    /// <summary>
    /// Interaction logic for InventoryPositionDataUI.xaml
    /// </summary>
    public partial class InventoryPositionDataUI : Window
    {
        SqlCommand cmd;
        SqlConnection Conn;
        String sqlStatement;


        public InventoryPositionDataUI()
        {
            InitializeComponent();
            sqlStatement = "";
        }

        private void textBoxInventoryName_LostFocus(object sender, RoutedEventArgs e)
        {
            String inventoryName = textBoxInventoryPositionBuilding.Text.ToString();

            try
            {
                cmd = new SqlCommand();
                Conn = new SqlConnection("Data Source=.;Initial Catalog=MTDB;Integrated Security=SSPI");
                Conn.Open();
                cmd.Connection = Conn;
                cmd.CommandText = "SELECT iv_building, iv_description FROM MTDB..inventory_positions WHERE iv_building='" + inventoryName+ "' AND (iv_DELETED=0 OR iv_DELETED IS NULL)";
                cmd.ExecuteNonQuery();
                SqlDataReader reader = null;
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    textBoxInventoryDescription.Text = reader["iv_description"].ToString();
                    sqlStatement = "Update";
                }
                Conn.Close();
            }
            catch (SqlException sq)
            {
                MessageBox.Show(sq.ToString());
            }
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            String inventoryName = textBoxInventoryPositionBuilding.Text.ToString();
            String inventoryDescription = textBoxInventoryDescription.Text.ToString();
            Int32 inventoryDelete = 0;

            if (checkBoxInventoryDelete.IsChecked == true)
            {
                inventoryDelete = 1;
                sqlStatement = "Delete";
            }

            if (sqlStatement.Equals(""))
            {
                try
                {
                    cmd = new SqlCommand();
                    Conn = new SqlConnection("Data Source=.;Initial Catalog=MTDB;Integrated Security=SSPI");
                    Conn.Open();
                    cmd.Connection = Conn;
                    cmd.CommandText = "INSERT INTO MTDB..inventory_positions (iv_building, iv_description, iv_deleted) Values('" + inventoryName + "','" + inventoryDescription + "'," + inventoryDelete + ")";
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    MessageBox.Show("Lagerposition erfolgreich eingefügt");
                    this.Close();
                }
                catch (SqlException sq)
                {
                    MessageBox.Show(sq.ToString());
                }
            }

            if (sqlStatement.Equals("Update"))
            {
                try
                {
                    cmd = new SqlCommand();
                    Conn = new SqlConnection("Data Source=.;Initial Catalog=MTDB;Integrated Security=SSPI");
                    Conn.Open();
                    cmd.Connection = Conn;
                    cmd.CommandText = "Update MTDB..inventory_positions SET iv_building='" + inventoryName+ "', iv_description='" + inventoryDescription+ "', iv_deleted=" + inventoryDelete+ " WHERE iv_building='" + inventoryName+ "'";
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    MessageBox.Show("Lagerposition erfolgreich geändert");
                    this.Close();
                }
                catch (SqlException sq)
                {
                    MessageBox.Show(sq.ToString());
                }
            }

            if (sqlStatement.Equals("Delete"))
            {
                string message = "Sind Sie sicher, dass Sie die Lagerposition löschen möchten?";
                string caption = "Lagerposition Löschen";
                MessageBoxButton buttons = MessageBoxButton.YesNo;
                MessageBoxResult result;
                result = MessageBox.Show(message, caption, buttons, MessageBoxImage.Warning);

                if (result == System.Windows.MessageBoxResult.Yes)
                {
                    try
                    {
                        cmd = new SqlCommand();
                        Conn = new SqlConnection("Data Source=.;Initial Catalog=MTDB;Integrated Security=SSPI");
                        Conn.Open();
                        cmd.Connection = Conn;
                        cmd.CommandText = "DELETE FROM MTDB..inventory_positions WHERE iv_building='" + inventoryName+ "'";
                        cmd.ExecuteNonQuery();
                        Conn.Close();
                        MessageBox.Show("Lagerposition gelöscht");
                        this.Close();
                    }
                    catch (SqlException sq)
                    {
                        MessageBox.Show(sq.ToString());
                    }
                }
                if (result == System.Windows.MessageBoxResult.No)
                {
                    this.Close();
                }
            }
        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
