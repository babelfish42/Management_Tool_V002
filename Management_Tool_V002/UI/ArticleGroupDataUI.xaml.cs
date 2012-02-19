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
    /// Interaction logic for ArticleGroupDataUI.xaml
    /// </summary>
    public partial class ArticleGroupDataUI : Window
    {
        SqlCommand cmd;
        SqlConnection Conn;
        String sqlStatement;

        public ArticleGroupDataUI()
        {
            InitializeComponent();
            sqlStatement = "";
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            String articleGroupName = textBoxArticleGroupName.Text.ToString();
            String articleGroupDescription = textBoxArticleGroupDescription.Text.ToString();
            Int32 articleGroupDelete = 0;
            
            if (checkBoxDeleteArticleGroup.IsChecked == true)
            {
                articleGroupDelete = 1;
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
                    cmd.CommandText = "INSERT INTO MTDB..article_Group (ag_name, ag_description, ag_deleted) Values('" + articleGroupName + "','" + articleGroupDescription + "'," + articleGroupDelete + ")";
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    MessageBox.Show("Artikel Gruppe erfolgreich eingefügt");
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
                    cmd.CommandText = "Update MTDB..article_groups SET ag_name ='" + articleGroupName+ "', ag_description='" + articleGroupDescription+ "', ag_deleted=" + articleGroupDelete+" WHERE ag_name='" + articleGroupName+"'";
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    MessageBox.Show("Artikel erfolgreich geändert");
                    this.Close();
                }
                catch (SqlException sq)
                {
                    MessageBox.Show(sq.ToString());
                }
            }

            if (sqlStatement.Equals("Delete"))
            {
                string message = "Sind Sie sicher, dass Sie die Artikel Gruppe löschen möchten?";
                string caption = "Artikel Gruppe Löschen";
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
                        cmd.CommandText = "DELETE FROM MTDB..article_groups WHERE ag_name='" + articleGroupName + "'";
                        cmd.ExecuteNonQuery();
                        Conn.Close();
                        MessageBox.Show("Artikel Gruppe gelöscht");
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

        private void textBoxArticleGroupName_LostFocus(object sender, RoutedEventArgs e)
        {
            String articleGroupName = textBoxArticleGroupName.Text.ToString();

            try
            {
                cmd = new SqlCommand();
                Conn = new SqlConnection("Data Source=.;Initial Catalog=MTDB;Integrated Security=SSPI");
                Conn.Open();
                cmd.Connection = Conn;
                cmd.CommandText = "SELECT ag_name, ag_description FROM MTDB..article_Groups WHERE ag_name='" + articleGroupName + "' AND (AG_DELETED=0 OR AG_DELETED IS NULL)";
                cmd.ExecuteNonQuery();
                SqlDataReader reader = null;
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    textBoxArticleGroupName.Text = reader["ag_name"].ToString();
                    textBoxArticleGroupDescription.Text = reader["ag_description"].ToString();
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
