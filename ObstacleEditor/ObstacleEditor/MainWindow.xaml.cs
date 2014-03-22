using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Reflection;
using System.IO;
using System.Xml;
using System.Xml.Linq;
using Microsoft.Win32;
using System.Windows.Media.Effects;

namespace ObstacleEditor
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private List<Image> ObstacleList = new List<Image>();
        private Point DragOffSet;
        private Image CurrentImage;
        private int slideValue = 0;

        public MainWindow()
        {
            InitializeComponent();
            InitImage();
            PictureSize.Init();
        }

        private void InitImage()
        {
            FieldInfo[] fields = getObjects();
            foreach(FieldInfo fl in fields)
            {
                object item = fl.GetValue(this);
                if (item is Image)
                {
                    Image ImageItem = (item as Image);
                    string key = ImageItem.Name;
                    ImageItem.Source = new BitmapImage(new Uri("/pic/" + key + ".png", UriKind.Relative));
                }
            }
        }

        private void CreateObstacle(object sender, MouseButtonEventArgs e)
        {
            string key = (sender as Image).Name;
            //FileStream READER = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            Image newImage = new Image();
            BitmapImage source = new BitmapImage(new Uri("/pic/" + key + ".png", UriKind.Relative));
            object[] size = PictureSize.picSize[key];
            newImage.Width = Convert.ToDouble(size[0]);
            newImage.Height = Convert.ToDouble(size[1]);
            newImage.Source = source;
            newImage.Stretch = Stretch.Fill;
            newImage.Name = key;
            this.Stage.Children.Add(newImage as UIElement);
            ObstacleList.Add(newImage);
            Canvas.SetTop(newImage, slideValue);
            newImage.MouseDown += StartDrag;
        }

        private void StartDrag(object sender, MouseButtonEventArgs e)
        {
            if(CurrentImage != null)
            {
                CurrentImage.Effect = null; 
            }


            Image img = sender as Image;
            CurrentImage = img;
            DropShadowEffect effect = new DropShadowEffect();
            effect.Color = Color.FromRgb(255, 255, 255);
            effect.ShadowDepth = 0;
            effect.BlurRadius = 20;
            effect.Opacity = 1;
            CurrentImage.Effect = effect;


            this.Stage.Children.Remove(img);
            this.Stage.Children.Add(img);
            this.Stage.MouseMove += Dragging;
            this.Stage.MouseUp += StopDrag;
            Point targetPt = Mouse.GetPosition(this.Stage);
            Point trans = img.TranslatePoint(new Point(0, 0), this.Stage);
            DragOffSet = new Point(trans.X - targetPt.X, trans.Y - targetPt.Y);
        }

        private void Dragging(object sender, MouseEventArgs e)
        {
            if (CurrentImage == null)
                return;
            Point targetPt = Mouse.GetPosition(this.Stage);
            Canvas.SetLeft(CurrentImage, Math.Round((targetPt.X + DragOffSet.X) / 10) * 10);
            Canvas.SetTop(CurrentImage, Math.Round((targetPt.Y + DragOffSet.Y) / 10) * 10);
        }

        private void CancelDrag(object sender, MouseButtonEventArgs e)
        {
            StopDrag(null, null);
        }

        private void StopDrag(object sender, MouseButtonEventArgs e)
        {
            if (CurrentImage == null)
                return;
            this.Stage.MouseMove -= Dragging;
            this.Stage.MouseUp -= StopDrag;
        }

        private void Reset(object sender, RoutedEventArgs e)
        {
            this.Stage.Children.Clear();
            foreach(Image img in ObstacleList)
            {
                img.MouseDown -= StartDrag;
            }
            ObstacleList.Clear();
        }


        private object getObjectFromResources(string key)
        {
            return ObstacleEditor.Properties.Resources.ResourceManager.GetObject(key);
        }

        private object  getObject(string name)
        {
            return this.GetType().GetField(name, BindingFlags.Instance | BindingFlags.NonPublic).GetValue(this);
        }

        private FieldInfo[] getObjects()
        {
            FieldInfo[] fields = this.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic);
            return fields;
        }

        private void Export(object sender, RoutedEventArgs e)
        {
            SaveFileDialog dialog = new SaveFileDialog();
            dialog.Filter = "XML Files (*.xml)|*.xml";
            dialog.Title = "輸出XML";
            Nullable<bool> result = dialog.ShowDialog(this);

            if (result == true)
            {
                XElement xd = new XElement("group");
                for (int i = 0; i < ObstacleList.Count; i++)
                {
                    Image item = ObstacleList[i];
                    if (item.Name != "character")
                    {
                        Point trans = item.TranslatePoint(new Point(0, 0), this.Stage);
                        xd.Add(new XElement(item.Name, new XElement("x", trans.X * 2), new XElement("y", trans.Y * 2)));
                    }
                }
                FileStream fs = (FileStream)dialog.OpenFile();
                xd.Save(fs, SaveOptions.None);
            }
        }

        private void BringFront(object sender, RoutedEventArgs e)
        {
            if (CurrentImage == null)
                return;
            this.Stage.Children.Remove(CurrentImage);
            this.Stage.Children.Add(CurrentImage);
        }

        private void BringBack(object sender, RoutedEventArgs e)
        {
            if (CurrentImage == null)
                return;
            this.Stage.Children.Remove(CurrentImage);
            this.Stage.Children.Insert(0,CurrentImage);
        }

        private void Remove(object sender, RoutedEventArgs e)
        {
            if (CurrentImage == null)
                return;
            this.Stage.Children.Remove(CurrentImage);
            CurrentImage.MouseDown -= StartDrag;
            ObstacleList.Remove(CurrentImage);
        }

        private void Slide(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            slideValue = (int)Math.Round((sender as Slider).Value / 10) * 10;
            Canvas.SetTop(this.Stage, -slideValue);
            this.top.Content = (slideValue * 2).ToString();
            this.bottom.Content = (slideValue * 2 + 1000).ToString();
        }

        private void Import(object sender, RoutedEventArgs e)
        {
            OpenFileDialog file = new OpenFileDialog();
            file.Filter = "XML Files|*.xml";
            Nullable<bool> result = file.ShowDialog(this);
            if (result == true)
            {
                Reset(null, null);
                string path = file.FileName;
                FileStream READER = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                XmlDocument Group = new System.Xml.XmlDocument();
                Group.Load(READER);
                XmlNodeList NodeList = Group.GetElementsByTagName("group");
                XmlNodeList BlockList = NodeList[0].ChildNodes;
                foreach (XmlNode Block in BlockList)
                {
                    string key = Block.Name;
                    Image newImage = new Image();
                    object[] size = PictureSize.picSize[key];
                    newImage.Width = Convert.ToDouble(size[0]);
                    newImage.Height = Convert.ToDouble(size[1]);
                    newImage.Source = new BitmapImage(new Uri("/pic/" + key + ".png", UriKind.Relative));
                    newImage.Stretch = Stretch.Fill;
                    newImage.Name = key;
                    Canvas.SetLeft(newImage, Convert.ToDouble(Block.ChildNodes[0].InnerText) / 2);
                    Canvas.SetTop(newImage, Convert.ToDouble(Block.ChildNodes[1].InnerText) / 2);
                    this.Stage.Children.Add(newImage);
                    ObstacleList.Add(newImage);
                    newImage.MouseDown += StartDrag;
                }
            }
        }

        private void AddBackground(object sender, RoutedEventArgs e)
        {
            OpenFileDialog file = new OpenFileDialog();
            file.Filter = "PNG Files (*.png)|*.png|JPG Files (*.jpg)|*.jpg|GIF Files (*.gif)|*.gif|JPEG Files (*.jpeg)|*.jpeg|All|*.*";
            Nullable<bool> result = file.ShowDialog(this);
            if (result == true)
            {
                this.background.Source = new BitmapImage(new Uri(file.FileName, UriKind.Absolute));
            }
        }
    }
}
