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
    /// Interaction logic for SupplierDataUI.xaml
    /// </summary>
    public partial class SupplierDataUI : Window
    {

        SqlCommand cmd;
        SqlConnection Conn;
        String sqlStatement;


        public SupplierDataUI()
        {
            InitializeComponent();
            sqlStatement = "";
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            Int32 supplierAdressType = 6;
            String supplierName = textBoxSupplierName.Text.ToString();
            String supplierStreet = textBoxSupplierStreet.Text.ToString();
            String supplierHno = textBoxSupplierHno.Text.ToString();
            Int32 supplierZip = Int32.Parse(textBoxSupplierZIP.Text.ToString());
            String supplierCity = textBoxSupplierCity.Text.ToString();
            String supplierCountry = textBoxSupplierCountry.Text.ToString();
            String supplierDescription = textBoxSupplierDescription.Text.ToString();
            Int32 supplierDelete = 0;
            
            if (checkBoxDeleteSupplier.IsChecked == true)
            {
                supplierDelete = 1;
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
                    cmd.CommandText = "INSERT INTO MTDB..addresses (adr_type, adr_name, adr_street, adr_hno, adr_zip, adr_city, adr_countryCode, adr_comment, adr_deleted) Values("+supplierAdressType+",'" + supplierName + "','" + supplierStreet + "','" + supplierHno + "'," + supplierZip + ",'" + supplierCity + "','" + supplierCountry + "','" + supplierDescription + "'," + supplierDelete + ")";
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    MessageBox.Show("Lieferant erfolgreich eingefügt");
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
                    cmd.CommandText = "Update MTDB..addresses SET adr_name ='" + supplierName+ "', adr_street='" + supplierStreet + "', adr_hno='" + supplierHno+ "', adr_zip=" + supplierZip+ ", adr_city='" + supplierCity+ "', adr_countryCode='" + supplierCountry+ "', adr_comment='" + supplierDescription + "', adr_deleted=" + supplierDelete+ " WHERE adr_name='" + supplierName + "' AND adr_type=6";
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    MessageBox.Show("Lieferant erfolgreich geändert");
                    this.Close();
                }
                catch (SqlException sq)
                {
                    MessageBox.Show(sq.ToString());
                }
            }

            if (sqlStatement.Equals("Delete"))
            {
                string message = "Sind Sie sicher, dass Sie den Lieferanten löschen möchten?";
                string caption = "Lieferant Löschen";
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
                        cmd.CommandText = "DELETE FROM MTDB..addresses WHERE adr_name='" + supplierName + "' AND ADR_TYPE=6";
                        cmd.ExecuteNonQuery();
                        Conn.Close();
                        MessageBox.Show("Lieferant gelöscht");
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

        private void textBoxSupplierName_LostFocus(object sender, RoutedEventArgs e)
        {
            String supplierName = textBoxSupplierName.Text.ToString();

            try
            {
                cmd = new SqlCommand();
                Conn = new SqlConnection("Data Source=.;Initial Catalog=MTDB;Integrated Security=SSPI");
                Conn.Open();
                cmd.Connection = Conn;
                cmd.CommandText = "SELECT adr_name, adr_street, adr_hno, adr_zip, adr_city, adr_countryCode, adr_comment FROM MTDB..addresses WHERE adr_type=6 AND adr_name='" + supplierName+ "' AND (ADR_DELETED=0 OR ADR_DELETED IS NULL)";
                cmd.ExecuteNonQuery();
                SqlDataReader reader = null;
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    textBoxSupplierStreet.Text = reader["adr_street"].ToString();
                    textBoxSupplierHno.Text = reader["adr_hno"].ToString();
                    textBoxSupplierZIP.Text = reader["adr_zip"].ToString();
                    textBoxSupplierCity.Text = reader["adr_city"].ToString();
                    textBoxSupplierCountry.Text = reader["adr_countryCode"].ToString();
                    textBoxSupplierDescription.Text = reader["adr_comment"].ToString();
                    sqlStatement = "Update";
                }
                Conn.Close();
            }
            catch (SqlException sq)
            {
                MessageBox.Show(sq.ToString());
            }
        }
    }
}
