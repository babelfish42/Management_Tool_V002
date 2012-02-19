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
using System.Data;
using Microsoft.PointOfService;
using OnBarcode.Barcode.BarcodeScanner;
using Microsoft.Win32;
using System.IO;


namespace Management_Tool_V002.UI
{
    /// <summary>
    /// Interaction logic for ArticleDataUI.xaml
    /// </summary>
    public partial class ArticleDataUI : Window
    {
        SqlCommand cmd;
        SqlConnection Conn;
        String sqlStatement;
        
        public ArticleDataUI()
        {
            InitializeComponent();

            this.comoboxArticleGroups.ItemsSource = getArticleGroupInformation();
            this.comoboxArticleGroups.DisplayMemberPath = "ag_name";
            this.comoboxArticleGroups.SelectedValuePath = "ag_id";

            this.comoboxArticlePositions.ItemsSource = getInventoryPositionsInformation();
            this.comoboxArticlePositions.DisplayMemberPath = "iv_building";
            this.comoboxArticlePositions.SelectedValuePath = "iv_id";

            this.comoboxArticleSuppliers.ItemsSource = getSupplierInformation();
            this.comoboxArticleSuppliers.DisplayMemberPath = "adr_name";
            this.comoboxArticleSuppliers.SelectedValuePath = "adr_id";
            sqlStatement = "";

        }

        private List<Model.articles> getArticleInformation()
        {
            List<Model.articles> articles = new List<Model.articles>();
            using (Model.MTDBEntities context = new Model.MTDBEntities())
            {
                articles = context.articles.ToList();
            }
            return articles;
        }

        private List<Model.addresses> getSupplierInformation()
        {
            List<Model.addresses> results = new List<Model.addresses>();
            List<Model.addresses> addresses = new List<Model.addresses>();
            using (Model.MTDBEntities context = new Model.MTDBEntities())
            {
                addresses = context.addresses.ToList();
                foreach (Model.addresses address in addresses)
                {
                    if(address.adr_type == 6)
                    {
                        results.Add(address);
                    }
                }
            }
            return results;
        }

        private List<Model.article_groups> getArticleGroupInformation()
        {
            List<Model.article_groups> articleGroups = new List<Model.article_groups>();
            using (Model.MTDBEntities context = new Model.MTDBEntities())
            {
                articleGroups = context.article_groups.ToList();
            }
            return articleGroups;
        }

        private List<Model.inventory_positions> getInventoryPositionsInformation()
        {
            List<Model.inventory_positions> inventoryPositions = new List<Model.inventory_positions>();
            using (Model.MTDBEntities context = new Model.MTDBEntities())
            {
                inventoryPositions = context.inventory_positions.ToList();
            }
            return inventoryPositions;

        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            Int32 articleNr = Int32.Parse(textBoxArticleNr.Text.ToString());
            Int32 articleGroup = Int32.Parse(comoboxArticleGroups.SelectedValue.ToString());
            Int32 articleCnt = Convert.ToInt32(textBoxArticleCnt.Text.ToString());
            String articleName = textBoxArticleName.Text.ToString();
            float articlePrice = Convert.ToInt32(textBoxArticlePrice.Text.ToString());
            Int32 articleInventoryPosition = Int32.Parse(comoboxArticlePositions.SelectedValue.ToString());
            Int32 articleSupplier = Int32.Parse(comoboxArticleSuppliers.SelectedValue.ToString());
            String articleBarcoe = Convert.ToString(textBoxArticleBarcode.Text.ToString());
            String articleDescription = textBoxArticleDescription.Text.ToString();
            String articlePicturePath = textBoxArticlePicutrePath.Text.ToString();
            Int32 articleDelete = 0;
            if (checkBoxDeleteArticle.IsChecked == true)
            {
                articleDelete = 1;
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
                    cmd.CommandText = "INSERT INTO MTDB..articles (ar_nr, ar_ag_id, ar_adr_id, ar_cnt, ar_name, ar_price, ar_barcode, ar_iv_id, ar_description, ar_picturePath, ar_deleted) Values(" + articleNr + "," + articleGroup + "," + articleSupplier + "," + articleCnt + ",'" + articleName + "'," + articlePrice + ",'" + articleBarcoe + "'," + articleInventoryPosition + ",'" + articleDescription + "','" + articlePicturePath + "',"+articleDelete+")";
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    MessageBox.Show("Artikel erfolgreich eingefügt");
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
                    cmd.CommandText = "Update MTDB..articles SET ar_ag_id ="+articleGroup+", ar_adr_id="+articleSupplier+", ar_cnt="+articleCnt+", ar_name='"+articleName+"', ar_price="+articlePrice+", ar_barcode='"+articleBarcoe+"', ar_iv_id="+articleInventoryPosition+", ar_description='"+articleDescription+"', ar_picturePath='"+articlePicturePath+"', ar_deleted="+articleDelete+" WHERE ar_nr=" + articleNr;
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
                string message = "Sind Sie sicher, dass Sie den Artikel löschen möchten?";
                string caption = "Artikel Löschen";
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
                        cmd.CommandText = "DELETE FROM MTDB..articles WHERE ar_nr=" + articleNr;
                        cmd.ExecuteNonQuery();
                        Conn.Close();
                        MessageBox.Show("Artikel gelöscht");
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

        private void textBoxArticleNr_LostFocus(object sender, RoutedEventArgs e)
        {

            Int32 articleNR = Int32.Parse(textBoxArticleNr.Text.ToString());

            

            try
            {
                cmd = new SqlCommand();
                Conn = new SqlConnection("Data Source=.;Initial Catalog=MTDB;Integrated Security=SSPI");
                Conn.Open();
                cmd.Connection = Conn;
                cmd.CommandText = "SELECT ar_nr,ar_ag_id, ar_adr_id, ar_cnt, ar_name, ar_price, ar_barcode, ar_iv_id, ar_picturePath FROM MTDB..articles WHERE ar_nr=" + articleNR + "AND (AR_DELETED=0 OR AR_DELETED IS NULL)";
                cmd.ExecuteNonQuery();
                SqlDataReader reader = null;
                reader = cmd.ExecuteReader();

                while (reader.Read())
                    {
                        comoboxArticleGroups.SelectedValue = reader["ar_ag_id"].ToString();
                        comoboxArticleSuppliers.SelectedValue = reader["ar_adr_id"].ToString();
                        textBoxArticleCnt.Text = reader["ar_cnt"].ToString();
                        textBoxArticleName.Text = reader["ar_name"].ToString();
                        textBoxArticlePrice.Text = reader["ar_price"].ToString();
                        textBoxArticleBarcode.Text = reader["ar_barcode"].ToString();
                        comoboxArticlePositions.SelectedValue = reader["ar_iv_id"].ToString();
                        textBoxArticlePicutrePath.Text = reader["ar_PicturePath"].ToString();

                        if (textBoxArticlePicutrePath.Text != "")
                        {

                            BitmapImage articleBitmapImage = new BitmapImage();
                            articleBitmapImage.BeginInit();
                            articleBitmapImage.UriSource = new Uri(reader["ar_picturePath"].ToString());
                            articleBitmapImage.EndInit();
                            imageOfArticle.Stretch = Stretch.Fill;
                            imageOfArticle.Source = articleBitmapImage;
                        }
                        sqlStatement = "Update";
                    }
                Conn.Close();
            }
            catch (SqlException sq)
            {
                MessageBox.Show(sq.ToString());
            }
        }

        private void btnSearchPicture_Click(object sender, RoutedEventArgs e)
        {
            
            OpenFileDialog openFileDialog1 = new OpenFileDialog();
            openFileDialog1.InitialDirectory = "C:\\Users\\sandra\\Pictures";
            openFileDialog1.RestoreDirectory = true;
            openFileDialog1.ShowDialog();
            
            
            String articlePicutrePath = openFileDialog1.FileName.ToString();
            //Image articleImage = new Image();
            BitmapImage articleBitmapImage = new BitmapImage();
            articleBitmapImage.BeginInit();
            articleBitmapImage.UriSource = new Uri(articlePicutrePath);
            articleBitmapImage.EndInit();
            imageOfArticle.Stretch = Stretch.Fill;
            imageOfArticle.Source = articleBitmapImage;
            textBoxArticlePicutrePath.Text = articlePicutrePath.ToString();
        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
