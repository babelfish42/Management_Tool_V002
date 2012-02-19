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

namespace Management_Tool_V002.UI
{
    /// <summary>
    /// Interaction logic for MainFrame.xaml
    /// </summary>
    public partial class MainFrame : Window
    {
        public MainFrame()
        {
            InitializeComponent();
        }

        private void SelectedShowArticleData(object sender, RoutedEventArgs e)
        {
            ArticleDataUI windowArticle = new ArticleDataUI();
            windowArticle.Show();
        }

    }
}
