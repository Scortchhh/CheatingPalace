using MahApps.Metro.Controls;
using System;
using System.Diagnostics;
using System.Net;
using System.Windows;
using System.Windows.Media;
using System.Threading;
using System.Windows.Controls;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows.Input;
using System.ComponentModel;
using System.Timers;
using Microsoft.Win32;
using System.Windows.Media.Imaging;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Windows.Interop;
using CryptSharp;
using System.Runtime.InteropServices;
using Windows.Media.Protection.PlayReady;
using System.Reflection;

namespace mainLoader
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        private readonly string newHwid = Hwid.getHardwareID();
        public static string uhashdkqm = "mainLoader.exe";
        public static bool lolSubValid;
        public static int lolSessionCount;
        public static bool csgoSubValid;
        public static int loadTracker = 0;
        public static string Loaderpatch = "1.65";
        public static string userName;
        public string OfficialScripts;
        public string CommunityScripts;
        public string VipScripts;
        public string FavoriteScripts;
        public string FavoriteScriptsCommunity;
        public string allDownloadedScripts;
        public bool downloadCompleteEvent = false;
        public System.Timers.Timer inGameCheckTimer = new System.Timers.Timer();
        public static string LoadFileName = "";
        public static bool isLoadFileValid = false;
        public static bool isLoggedUser = false;

        public static DateTime endSub;
        public static string hwid;
        public static string ip = Ip.GetIP();
        public static string isZoomHackUser;

        public int costingCheatingPalacePoints;
        public static string totalCheatingPalacePoints;

        public static List<CheckBox> checkboxes = new List<CheckBox>();
        public static List<CheckBox> checkedCheckboxes = new List<CheckBox>();
        public static List<TextBlock> labelNames = new List<TextBlock>();
        public List<CheckBox> CommunityCheckboxes = new List<CheckBox>();
        public List<CheckBox> checkedCheckboxesCommunity = new List<CheckBox>();
        public List<CheckBox> favoriteCheckboxes = new List<CheckBox>();
        public List<CheckBox> checkedCheckboxesFavorites = new List<CheckBox>();
        public List<CheckBox> favoriteCheckboxesCommunity = new List<CheckBox>();
        public List<CheckBox> checkedCheckboxesFavoritesCommunity = new List<CheckBox>();
        public static List<string> subCheckboxes = new List<string>();
        public static List<dynamic> scriptRatings;
        public static (string, string, string) patches;


        public List<CheckBox> VipCheckBoxes = new List<CheckBox>();

        public MainWindow()
        {
            //AbstractLayer.changeProccessName();
            InitializeComponent();

            if (!isLoggedUser)
            {
                // load login form
                Register.Visibility = Visibility.Visible;
            }
            else
            {
                if (DbHandler.isPasswordEmpty())
                {
                    Register.Visibility = Visibility.Hidden;
                    setPasswordTab.Visibility = Visibility.Visible;
                }
                else
                {
                    Home.Visibility = Visibility.Visible;
                    navbar.Visibility = Visibility.Visible;
                    navbar2.Visibility = Visibility.Visible;
                    scriptRatings = DbHandler.GetScriptRating();
                    //new Thread(ChangeProcessNameHandler).Start();
                    Initalize_App();
                }
            }
        }

        private void Initalize_App()
        {
            AbstractLayer.CheckFiles();

            // update load cheat button text and clickability for if our cheat is outdated
            //if (patches.Item2.ToString() != patches.Item3.ToString())
            //{
            //    patchVer.Text = "LOL outdated for: " + patches.Item2.ToString();
            //    loadbtn.IsEnabled = false;
            //    patchVer.Foreground = Brushes.Red;
            //}
            //else
            //{
            //    patchVer.Text = "LOL updated for: " + patches.Item2.ToString();
            //    patchVer.Foreground = Brushes.Green;
            //}
            CheckZoomStatus();
            loltab.Visibility = Visibility.Visible;
            user.Content = userName;
            expireDate.Content += "LOL: " + endSub.ToString("dd/MM/yyyy");
            DateTime today = Convert.ToDateTime(Date.GetDate());
            DateTime sub = Convert.ToDateTime(endSub);
            int result = DateTime.Compare(today, sub);
            if (result < 0)
            {
                lolSubValid = true;
            } else if (result == 0)
            {
                lolSubValid = true;
            } else
            {
                if (lolSessionCount != 0)
                {
                    lolSubValid = true;
                }
            }
            if (lolSubValid == false)
            {
                loadbtn.IsEnabled = false;
                loadbtn.Content = "Please renew your subscription";
            }

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Settings\loader.ini";
            if (File.Exists(path))
            {
                bool isAutoCheatEnabled = false;
                bool isAutoCheckCoreScriptsEnabled = false;
                foreach (string line in File.ReadLines(path))
                {
                    if (line == "AutoLoad=True")
                    {
                        inGameCheckTimer.Elapsed += new ElapsedEventHandler(InGameCheckEvent);
                        inGameCheckTimer.Interval = 4000;
                        inGameCheckTimer.Enabled = true;
                        isAutoCheatEnabled = true;
                    }
                    if(line == "AutoCheckCoreScripts=True")
                    {
                        isAutoCheckCoreScriptsEnabled = true;
                    }
                }
                this.Dispatcher.Invoke(() =>
                {
                    if(isAutoCheatEnabled)
                    {
                        autoLoadCheat.IsChecked = true;
                    }
                    if(isAutoCheckCoreScriptsEnabled)
                    {
                        autoCheckCoreScriptsBtn.IsChecked = true;
                    }
                });
            }

            CreateFavorites();
            CreateCoreList();
            CreateChampionList();
            CreateCommunity();
            CreateVipList();
            DownloadLibs();
            nameHome.Text = "Welcome " + userName;
            parentScrollViewer.MouseRightButtonDown += new MouseButtonEventHandler(CanvasMenu_MouseDown);
            parentScrollViewer.PreviewMouseLeftButtonDown += new MouseButtonEventHandler(CanvasMenu_Close);
            var myTimer = new System.Timers.Timer();
            myTimer.Elapsed += new ElapsedEventHandler(MyEvent);
            myTimer.Interval = 2500;
            myTimer.Enabled = true;

            var myTimer2 = new System.Timers.Timer();
            myTimer2.Elapsed += new ElapsedEventHandler(IsProxyActive);
            myTimer2.Interval = 250;
            myTimer2.Enabled = true;

            var myTimerCheckLatestUpdate = new System.Timers.Timer();
            myTimerCheckLatestUpdate.Elapsed += new ElapsedEventHandler(IsLatestVersion);
            myTimerCheckLatestUpdate.Interval = 5000;
            myTimerCheckLatestUpdate.Enabled = true;

            var myTimerCheckLoadFile = new System.Timers.Timer();
            myTimerCheckLoadFile.Elapsed += new ElapsedEventHandler(DeleteLoadFile);
            myTimerCheckLoadFile.Interval = 2500;
            myTimerCheckLoadFile.Enabled = true;
        }

        public static void IsProxyActive(object source, ElapsedEventArgs e)
        {
            RegistryKey key = Registry.CurrentUser.OpenSubKey(@"SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\", true);
            //if it does exist, retrieve the stored values  
            if (key != null)
            {
                try
                {
                    if (key.GetValue("ProxyEnable").ToString() != "0")
                    {
                        // delete all and log
                        Log.SentToDb("declined", "Proxy enabled");
                        key.SetValue("ProxyEnable", 0, RegistryValueKind.DWord);
                        SelfDelete.Delete();
                    }
                    if (key.GetValue("ProxyServer") != null)
                    {
                        // delete all and log
                        Log.SentToDb("declined", "Proxy detected");
                        key.DeleteValue("ProxyServer");
                        SelfDelete.Delete();
                    }
                    key.Close();
                }
                catch (Exception)
                {
                    // no worries
                    key.Close();
                }
            }
        }

        public static void IsLatestVersion(object source, ElapsedEventArgs e)
        {
            string patchloader = patches.Item1;
            if (patchloader != Loaderpatch)
            {
                Process.Start("autoupdater.exe");
                Environment.Exit(0);
                //SelfDelete.Delete();
            }
        }

        public void ChangeProcessNameHandler()
        {
            var changeProcessName = new System.Timers.Timer();
            changeProcessName.Elapsed += new ElapsedEventHandler(ChangeProcessName);
            changeProcessName.Interval = 5000;
            changeProcessName.Enabled = true;
        }

        public void ChangeProcessName(object source, ElapsedEventArgs e)
        {
            this.Dispatcher.Invoke(() => {
                string newName = AbstractLayer.RandomString(20);
                IntPtr windowHandle = new WindowInteropHelper(Application.Current.MainWindow).Handle;
                AbstractLayer.SetNameOfWindow(windowHandle, newName);
            });
        }

        public static void DeleteLoadFile(object source, ElapsedEventArgs e)
        {
            int waitTime = 7500;
            if (!isLoadFileValid)
            {
                if (File.Exists(LoadFileName))
                {
                    File.Delete(LoadFileName);
                }
            } else
            {
                if (File.Exists(LoadFileName))
                {
                    Thread.Sleep(waitTime);
                    File.Delete(LoadFileName);
                }
            }
            string dir = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/";
            string[] files = Directory.GetFiles(dir);
            foreach (string file in files)
            {
                if (file.Contains(LoadFileName))
                {
                    Thread.Sleep(waitTime);
                    File.Delete(file);
                }
                if (!file.Contains(LoadFileName))
                {
                    File.Delete(file);
                }
            }
        }

        // Implement a call with the right signature for events going off
        private void MyEvent(object source, ElapsedEventArgs e) {
            AbstractLayer.CheckDebuggers();
        }

        private void InGameCheckEvent(object source, ElapsedEventArgs e)
        {
            inGameCheckTimer.Enabled = false;
            InGameAndCheatNotLoaded();
        }

        private bool IsCheatLoaded(Process[] processlist)
        {
            foreach (Process process in processlist)
            {
                if (process.ProcessName == "cmd")
                {
                    return true;
                }
            }
            return false;
        }

        private void InGameAndCheatNotLoaded()
        {
            Process[] processlist = Process.GetProcesses();
            foreach (Process process in processlist)
            {
                bool isCheatOpen = IsCheatLoaded(processlist);
                if (process.ProcessName == "League of Legends")
                {
                    if(!isCheatOpen)
                    {
                        this.Dispatcher.Invoke(() =>
                        {
                            GetModules();
                        });
                    }
                }
            }
            this.Dispatcher.Invoke(() =>
            {
                if (autoLoadCheat.IsChecked == true)
                {
                    inGameCheckTimer.Enabled = true;
                }
            });
        }

        private void CanvasMenu_MouseDown(object sender, MouseEventArgs e)
        {
            refreshBtn.Content = "Refresh Scripts";
            refreshBtn.Visibility = Visibility.Visible;
            TranslateTransform transform = new TranslateTransform
            {
                X = Mouse.GetPosition(parentScrollViewer).X - 290,
                Y = Mouse.GetPosition(parentScrollViewer).Y - 40
            };
            transform.Y += parentScrollViewer.VerticalOffset;
            refreshBtn.RenderTransform = transform;
        }

        private void CanvasMenu_Close(object sender, MouseEventArgs e)
        {
            if (!refreshBtn.IsMouseOver)
            {
                refreshBtn.Visibility = Visibility.Hidden;
            }
        }

        private void RefreshScriptLists(object sender, RoutedEventArgs e)
        {
            parentScrollViewer.ScrollToTop();
            coreSelection.Children.Clear();
            utilitySelection.Children.Clear();
            championsSelection.Children.Clear();
            checkboxes.Clear();
            favoriteSelection.Children.Clear();
            favoriteCheckboxes.Clear();
            favoriteCheckboxesCommunity.Clear();
            communitySelection.Children.Clear();
            CommunityCheckboxes.Clear();
            VipCheckBoxes.Clear();
            vipSelection.Children.Clear();
            CreateCoreList();
            CreateChampionList();
            CreateFavorites();
            CreateCommunity();
            CreateVipList();
            refreshBtn.Visibility = Visibility.Hidden;
        }

        private void RefreshScriptListsFromCode()
        {
            parentScrollViewer.ScrollToTop();
            coreSelection.Children.Clear();
            utilitySelection.Children.Clear();
            championsSelection.Children.Clear();
            checkboxes.Clear();
            favoriteSelection.Children.Clear();
            favoriteCheckboxes.Clear();
            favoriteCheckboxesCommunity.Clear();
            communitySelection.Children.Clear();
            CommunityCheckboxes.Clear();
            VipCheckBoxes.Clear();
            vipSelection.Children.Clear();
            CreateCoreList();
            CreateChampionList();
            CreateFavorites();
            CreateCommunity();
            CreateVipList();
            refreshBtn.Visibility = Visibility.Hidden;
        }

        private void Button_Home(object sender, RoutedEventArgs e)
        {
            Home.Visibility = Visibility.Visible;
            Account.Visibility = Visibility.Hidden;
            LOL.Visibility = Visibility.Hidden;
            CSGO.Visibility = Visibility.Hidden;
        }

        private void Button_Account(object sender, RoutedEventArgs e)
        {
            Home.Visibility = Visibility.Hidden;
            Account.Visibility = Visibility.Visible;
            LOL.Visibility = Visibility.Hidden;
            CSGO.Visibility = Visibility.Hidden;
        }

        private void Button_Store(object sender, RoutedEventArgs e)
        {
            Home.Visibility = Visibility.Hidden;
            Account.Visibility = Visibility.Hidden;
            LOL.Visibility = Visibility.Hidden;
            CSGO.Visibility = Visibility.Hidden;
        }

        private void Button_LOL(object sender, RoutedEventArgs e)
        {
            Home.Visibility = Visibility.Hidden;
            Account.Visibility = Visibility.Hidden;
            LOL.Visibility = Visibility.Visible;
            CSGO.Visibility = Visibility.Hidden;
        }

        private void Button_CSGO(object sender, RoutedEventArgs e)
        {
            Home.Visibility = Visibility.Hidden;
            Account.Visibility = Visibility.Hidden;
            LOL.Visibility = Visibility.Hidden;
            CSGO.Visibility = Visibility.Visible;
        }

        private void CoreBtn_Click(object sender, RoutedEventArgs e)
        {
            parentScrollViewer.ScrollToTop();
            findScript.Text = "";
            coreSelection.Visibility = Visibility.Visible;
            utilitySelection.Visibility = Visibility.Hidden;
            championsSelection.Visibility = Visibility.Hidden;
            favoriteSelection.Visibility = Visibility.Hidden;
            communitySelection.Visibility = Visibility.Hidden;
            vipSelection.Visibility = Visibility.Hidden;
        }

        private void UtilityBtn_Click(object sender, RoutedEventArgs e)
        {
            parentScrollViewer.ScrollToTop();
            findScript.Text = "";
            coreSelection.Visibility = Visibility.Hidden;
            utilitySelection.Visibility = Visibility.Visible;
            championsSelection.Visibility = Visibility.Hidden;
            favoriteSelection.Visibility = Visibility.Hidden;
            communitySelection.Visibility = Visibility.Hidden;
            vipSelection.Visibility = Visibility.Hidden;
        }

        private void ChampionsBtn_Click(object sender, RoutedEventArgs e)
        {
            parentScrollViewer.ScrollToTop();
            findScript.Text = "";
            coreSelection.Visibility = Visibility.Hidden;
            utilitySelection.Visibility = Visibility.Hidden;
            championsSelection.Visibility = Visibility.Visible;
            favoriteSelection.Visibility = Visibility.Hidden;
            communitySelection.Visibility = Visibility.Hidden;
            vipSelection.Visibility = Visibility.Hidden;
        }


        private void FavoriteBtn_Click(object sender, RoutedEventArgs e)
        {
            parentScrollViewer.ScrollToTop();
            findScript.Text = "";
            coreSelection.Visibility = Visibility.Hidden;
            utilitySelection.Visibility = Visibility.Hidden;
            championsSelection.Visibility = Visibility.Hidden;
            communitySelection.Visibility = Visibility.Hidden;
            favoriteSelection.Visibility = Visibility.Visible;
            vipSelection.Visibility = Visibility.Hidden;
        }

        private void CommunityBtn_Click(object sender, RoutedEventArgs e)
        {
            parentScrollViewer.ScrollToTop();
            findScript.Text = "";
            coreSelection.Visibility = Visibility.Hidden;
            utilitySelection.Visibility = Visibility.Hidden;
            championsSelection.Visibility = Visibility.Hidden;
            favoriteSelection.Visibility = Visibility.Hidden;
            communitySelection.Visibility = Visibility.Visible;
            vipSelection.Visibility = Visibility.Hidden;
        }

        private void VipBtn_Click(object sender, RoutedEventArgs e)
        {
            parentScrollViewer.ScrollToTop();
            findScript.Text = "";
            coreSelection.Visibility = Visibility.Hidden;
            utilitySelection.Visibility = Visibility.Hidden;
            championsSelection.Visibility = Visibility.Hidden;
            favoriteSelection.Visibility = Visibility.Hidden;
            communitySelection.Visibility = Visibility.Hidden;
            vipSelection.Visibility = Visibility.Visible;
        }

        private void FilterScripts(object sender, TextChangedEventArgs e)
        {
            filteredSelection.Children.Clear();
            TextBox textBox = sender as TextBox;
            string name = textBox.Text;
            if (textBox != null)
            {
                if (textBox.Text == "")
                {
                    checkedCheckboxes = new List<CheckBox>();
                    foreach (CheckBox box in checkboxes)
                    {
                        if (box.IsChecked == true)
                        {
                            checkedCheckboxes.Add(box);
                        }
                    }
                    foreach (CheckBox box in CommunityCheckboxes)
                    {
                        if (box.IsChecked == true)
                        {
                            checkedCheckboxesCommunity.Add(box);
                        }
                    }
                    checkboxes = new List<CheckBox>();
                    labelNames = new List<TextBlock>();
                    CreateCoreList();
                    CreateChampionList();
                    CreateCommunity();
                    coreSelection.Visibility = Visibility.Hidden;
                    filteredSelection.Visibility = Visibility.Hidden;
                    utilitySelection.Visibility = Visibility.Hidden;
                    championsSelection.Visibility = Visibility.Visible;
                    communitySelection.Visibility = Visibility.Hidden;
                } else
                {
                    name = char.ToUpper(name[0]) + name.Substring(1);
                    championsSelection.Children.Clear();
                    coreSelection.Children.Clear();
                    communitySelection.Children.Clear();
                    utilitySelection.Children.Clear();
                    filteredSelection.Visibility = Visibility.Visible;
                    int count = 0;
                    int additionalPadding = 10;
                    foreach (CheckBox box in checkboxes)
                    {
                        if (!box.Name.Contains(name))
                        {
                            filteredSelection.Children.Remove(box);
                        }
                        else
                        {
                            if (!filteredSelection.Children.Contains(box))
                            {
                                if (count == 0)
                                {
                                    box.Margin = new Thickness { Left = 10, Top = 10 };
                                    filteredSelection.Children.Add(box);
                                    count++;
                                } else
                                {
                                    additionalPadding += 25;
                                    box.Margin = new Thickness { Left = 10, Top = additionalPadding };
                                    filteredSelection.Children.Add(box);
                                    count++;
                                }
                            }
                        }
                    }
                    count = 0;
                    additionalPadding = 8;
                    foreach (TextBlock block in labelNames)
                    {
                        if (!block.Text.Contains(name))
                        {
                            filteredSelection.Children.Remove(block);
                        }
                        else
                        {
                            if (!filteredSelection.Children.Contains(block))
                            {
                                if (count == 0)
                                {
                                    block.Margin = new Thickness { Left = 39, Top = 8 };
                                    filteredSelection.Children.Add(block);
                                    count++;
                                } else
                                {
                                    additionalPadding += 25;
                                    block.Margin = new Thickness { Left = 39, Top = additionalPadding };
                                    filteredSelection.Children.Add(block);
                                    count++;
                                }
                            }
                        }
                    }
                }
            }
            parentScrollViewer.ScrollToTop();
        }

        private void PopulateToolTip()
        {
            for (int i = 0; i < checkboxes.Count; i++)
            {
                this.Dispatcher.Invoke(() =>
                {
                    string scriptName = checkboxes[i].Name;
                    checkboxes[i].ToolTip = scriptName + " Rated " + scriptRatings[i] + " / 5";
                    labelNames[i].ToolTip = scriptName + " Rated " + scriptRatings[i] + " / 5";
                });
            }
        }

        private void FavoriteButton(Image star, string scriptName, bool isOfficial)
        {
            if(isOfficial)
            {
                string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Settings\favorites.ini";
                if (File.Exists(path))
                {
                    bool hasFound = false;
                    bool isFirstLine = false;
                    string allContent = File.ReadAllText(path);
                    int counter = 0;
                    foreach (string line in File.ReadLines(path))
                    {
                        if (line == scriptName)
                        {
                            if (counter == 0)
                            {
                                isFirstLine = true;
                            }
                            star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            foreach (var favorite in favoriteCheckboxes)
                            {
                                if (favorite.Name == scriptName)
                                {
                                    favoriteCheckboxes.Remove(favorite);
                                    break;
                                }
                            }
                            allContent = allContent.Replace("\n" + scriptName, "");
                            hasFound = true;
                            break;
                        }
                        counter++;
                    }
                    if (hasFound)
                    {
                        if (!allContent.Contains("\n"))
                        {
                            allContent = allContent.Replace(scriptName, "");
                            File.WriteAllText(path, allContent);
                        }
                        else
                        {
                            if (isFirstLine)
                            {
                                allContent = allContent.Replace(scriptName + "\n", "");
                                File.WriteAllText(path, allContent);
                            }
                            else
                            {
                                File.WriteAllText(path, allContent);
                            }
                        }
                    }
                    else
                    {
                        star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                        if (new FileInfo(path).Length == 0)
                        {
                            File.WriteAllText(path, allContent + scriptName);
                        }
                        else
                        {
                            File.WriteAllText(path, allContent + "\n" + scriptName);
                        }
                    }
                }
                else
                {
                    star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                    File.WriteAllText(path, scriptName);
                }
                CreateFavorites();
            } else
            {
                string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Settings\favorites.ini";
                if (File.Exists(path))
                {
                    bool hasFound = false;
                    bool isFirstLine = false;
                    string allContent = File.ReadAllText(path);
                    int counter = 0;
                    foreach (string line in File.ReadLines(path))
                    {
                        if (line == scriptName)
                        {
                            if (counter == 0)
                            {
                                isFirstLine = true;
                            }
                            star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            foreach (var favorite in favoriteCheckboxesCommunity)
                            {
                                if (favorite.Name == scriptName)
                                {
                                    favoriteCheckboxesCommunity.Remove(favorite);
                                    break;
                                }
                            }
                            allContent = allContent.Replace("\n" + scriptName, "");
                            hasFound = true;
                            break;
                        }
                        counter++;
                    }
                    if (hasFound)
                    {
                        if (!allContent.Contains("\n"))
                        {
                            allContent = allContent.Replace(scriptName, "");
                            File.WriteAllText(path, allContent);
                        }
                        else
                        {
                            if (isFirstLine)
                            {
                                allContent = allContent.Replace(scriptName + "\n", "");
                                File.WriteAllText(path, allContent);
                            }
                            else
                            {
                                File.WriteAllText(path, allContent);
                            }
                        }
                    }
                    else
                    {
                        star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                        if (new FileInfo(path).Length == 0)
                        {
                            File.WriteAllText(path, allContent + scriptName);
                        }
                        else
                        {
                            File.WriteAllText(path, allContent + "\n" + scriptName);
                        }
                    }
                }
                else
                {
                    star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                    File.WriteAllText(path, scriptName);
                }
                CreateFavorites();
            }
        }

        private void CreateCoreList()
        {
            List<dynamic> list = DbHandler.GetScripts("Core");
            int checkBoxTop = -15;
            int checkboxLeft = 480;
            int ModulenameTop = -18;
            int modulenameleft = 509;
            bool filledLeftSide = false;
            for (int x = 0; x < list.Count; x++)
            {
                for (int i = 0; i < 1; i++)
                {
                    //string rating = DbHandler.getScriptRating(list[x]["script"].ToString());
                    string scriptName = list[x]["script"].ToString();
                    if (scriptName.Contains(" ") || scriptName.Contains("(") || scriptName.Contains(")"))
                    {
                        continue;
                    }

                    int currentRating = Convert.ToInt32(scriptRatings[x]);
                    if (filledLeftSide == true)
                    {
                        bool isFavorite = false;
                        foreach(var favorite in favoriteCheckboxes)
                        {
                            if(favorite.Name == scriptName)
                            {
                                isFavorite = true;
                                break;
                            }
                        }
                        Image star = new Image();
                        if (isFavorite)
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        } else
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        }

                        int addPaddingRatingStar = 20;
                        for (int count = 1; count <= 5; count++)
                        {
                            int rating = count;
                            Image starRating = new Image();
                            starRating.Name = scriptName;
                            if (currentRating >= count)
                            {
                                starRating.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            }
                            else
                            {
                                starRating.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            }
                            starRating.Margin = new Thickness { Left = 160 + addPaddingRatingStar, Top = checkBoxTop };
                            starRating.Width = 20;
                            starRating.Height = 20;
                            starRating.Cursor = Cursors.Hand;
                            starRating.ToolTip = "Rate " + scriptName + ": " + count + "/5";
                            starRating.MouseUp += ((s, e) =>
                            {
                                DbHandler.SetScriptRating(scriptName, rating);
                            });
                            addPaddingRatingStar += 20;
                            coreSelection.Children.Add(starRating);
                        }

                        CheckBox checkbox2 = new CheckBox
                        {
                            Margin = new Thickness { Left = checkboxLeft, Top = checkBoxTop },
                            Name = list[x]["script"].ToString(),
                            //checkbox2.ToolTip = scriptName + " Rated " + rating + " / 5";
                            ToolTip = scriptName + " Rated " + currentRating + " / 5"
                        };
                        if (autoCheckCoreScriptsBtn.IsChecked == true)
                        {
                            checkbox2.IsChecked = true;
                        }
                        foreach (CheckBox box in checkedCheckboxes)
                        {
                            if (box.Name == checkbox2.Name)
                            {
                                checkbox2.IsChecked = true;
                            }
                        }
                        checkbox2.Checked += (s, e) => { SelectingModules(s, e, checkbox2); };
                        TextBlock moduleName2 = new TextBlock
                        {
                            Margin = new Thickness { Left = modulenameleft, Top = ModulenameTop += 25 },
                            Text = list[x]["script"].ToString() + ".lua",
                            FontSize = 16
                        };
                        moduleName2.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                        //moduleName2.ToolTip = scriptName + " Rated " + rating + " / 5";
                        moduleName2.ToolTip = scriptName + " Rated " + currentRating + " / 5";
                        coreSelection.Children.Add(checkbox2);
                        coreSelection.Children.Add(moduleName2);
                        coreSelection.Children.Add(star);
                        checkboxes.Add(checkbox2);
                        labelNames.Add(moduleName2);
                    }
                    else
                    {
                        bool isFavorite = false;
                        foreach (var favorite in favoriteCheckboxes)
                        {
                            if (favorite.Name == scriptName)
                            {
                                isFavorite = true;
                                break;
                            }
                        }
                        Image star = new Image();
                        if (isFavorite)
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        } else
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        }

                        CheckBox checkbox = new CheckBox
                        {
                            Margin = new Thickness { Left = 10, Top = checkBoxTop },
                            Name = list[x]["script"].ToString(),
                            //checkbox.ToolTip = scriptName + " Rated " + rating + " / 5";
                            ToolTip = scriptName + " Rated " + currentRating + " / 5"
                        };
                        if (autoCheckCoreScriptsBtn.IsChecked == true)
                        {
                            checkbox.IsChecked = true;
                        }
                        foreach (CheckBox box in checkedCheckboxes)
                        {
                            if (box.Name == checkbox.Name)
                            {
                                checkbox.IsChecked = true;
                            }
                        }
                        checkbox.Checked += (s, e) => { SelectingModules(s, e, checkbox); };
                        TextBlock moduleName = new TextBlock
                        {
                            Margin = new Thickness { Left = 39, Top = ModulenameTop += 25 },
                            Text = list[x]["script"].ToString() + ".lua",
                            FontSize = 16
                        };
                        moduleName.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                        //moduleName.ToolTip = scriptName + " Rated " + rating + " / 5";
                        moduleName.ToolTip = scriptName + " Rated " + currentRating + " / 5";

                        int addPaddingRatingStar = 20;
                        for (int count = 1; count <= 5; count++)
                        {
                            int rating = count;
                            Image starRating = new Image();
                            starRating.Name = scriptName;
                            if (currentRating >= count)
                            {
                                starRating.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            }
                            else
                            {
                                starRating.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            }
                            starRating.Margin = new Thickness { Left = 160 + addPaddingRatingStar, Top = checkBoxTop };
                            starRating.Width = 20;
                            starRating.Height = 20;
                            starRating.Cursor = Cursors.Hand;
                            starRating.ToolTip = "Rate " + scriptName + ": " + count + "/5";
                            starRating.MouseUp += ((s, e) =>
                            {
                                DbHandler.SetScriptRating(scriptName, rating);
                            });
                            addPaddingRatingStar += 20;
                            coreSelection.Children.Add(starRating);
                        }

                        coreSelection.Children.Add(checkbox);
                        coreSelection.Children.Add(moduleName);
                        coreSelection.Children.Add(star);
                        checkboxes.Add(checkbox);
                        labelNames.Add(moduleName);
                        if (checkBoxTop > 1900)
                        {
                            filledLeftSide = true;
                            checkBoxTop = -15;
                            ModulenameTop = -18;
                        }
                    }
                }
            }
        }

        private void CreateChampionList()
        {
            List<dynamic> list = DbHandler.GetScripts("Champion");
            int checkBoxTop = -15;
            int checkboxLeft = 440;
            int ModulenameTop = -18;
            int modulenameleft = 469;
            bool filledLeftSide = false;
            int startingPoint = 6;
            for (int x = 0; x < list.Count; x++)
            {
                for (int i = 0; i < 1; i++)
                {
                    //string rating = DbHandler.getScriptRating(list[x]["script"].ToString());
                    string scriptName = list[x]["script"].ToString();
                    if (scriptName.Contains(" ") || scriptName.Contains("(") || scriptName.Contains(")"))
                    {
                        continue;
                    }

                    int currentRating = Convert.ToInt32(scriptRatings[startingPoint]);
                    startingPoint += 1;
                    if (checkBoxTop + 40 >= 1900)
                    {
                        filledLeftSide = true;
                        checkBoxTop = -15;
                        ModulenameTop = -18;
                    }
                    if (filledLeftSide == true)
                    {
                        bool isFavorite = false;
                        foreach (var favorite in favoriteCheckboxes)
                        {
                            if (favorite.Name == scriptName)
                            {
                                isFavorite = true;
                                break;
                            }
                        }
                        Image star = new Image();
                        if (isFavorite)
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 725, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        }
                        else
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 725, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        }

                        int addPaddingRatingStar = 20;
                        for (int count = 1; count <= 5; count++)
                        {
                            int rating = count;
                            Image starRating = new Image();
                            starRating.Name = scriptName;
                            if (currentRating >= count)
                            {
                                starRating.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            }
                            else
                            {
                                starRating.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            }
                            starRating.Margin = new Thickness { Left = 580 + addPaddingRatingStar, Top = checkBoxTop };
                            starRating.Width = 20;
                            starRating.Height = 20;
                            starRating.Cursor = Cursors.Hand;
                            starRating.ToolTip = "Rate " + scriptName + ": " + count + "/5";
                            starRating.MouseUp += ((s, e) =>
                            {
                                DbHandler.SetScriptRating(scriptName, rating);
                            });
                            addPaddingRatingStar += 20;
                            championsSelection.Children.Add(starRating);
                        }

                        CheckBox checkbox2 = new CheckBox
                        {
                            Margin = new Thickness { Left = checkboxLeft, Top = checkBoxTop },
                            Name = list[x]["script"].ToString(),
                            //checkbox2.ToolTip = scriptName + " Rated " + rating + " / 5";
                            ToolTip = scriptName + " Rated " + currentRating + " / 5"
                        };
                        foreach (CheckBox box in checkedCheckboxes)
                        {
                            if (box.Name == checkbox2.Name)
                            {
                                checkbox2.IsChecked = true;
                            }
                        }
                        checkbox2.Checked += (s, e) => { SelectingModules(s, e, checkbox2); };
                        TextBlock moduleName2 = new TextBlock
                        {
                            Margin = new Thickness { Left = modulenameleft, Top = ModulenameTop += 25 },
                            Text = list[x]["script"].ToString() + ".lua",
                            FontSize = 16
                        };
                        moduleName2.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                        //moduleName2.ToolTip = scriptName + " Rated " + rating + " / 5";
                        moduleName2.ToolTip = scriptName + " Rated " + currentRating + " / 5";
                        championsSelection.Children.Add(checkbox2);
                        championsSelection.Children.Add(moduleName2);
                        championsSelection.Children.Add(star);
                        checkboxes.Add(checkbox2);
                        labelNames.Add(moduleName2);
                    }
                    else
                    {
                        bool isFavorite = false;
                        foreach (var favorite in favoriteCheckboxes)
                        {
                            if (favorite.Name == scriptName)
                            {
                                isFavorite = true;
                                break;
                            }
                        }
                        Image star = new Image();
                        if (isFavorite)
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        }
                        else
                        {
                            star.Name = scriptName;
                            star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                            star.Width = 20;
                            star.Height = 20;
                            star.Cursor = Cursors.Hand;
                            star.ToolTip = "Favorite: " + list[x]["script"].ToString();
                            star.MouseUp += ((s, e) =>
                            {
                                FavoriteButton(star, scriptName, true);
                            });
                        }

                        int addPaddingRatingStar = 20;
                        for (int count = 1; count <= 5; count++)
                        {
                            int rating = count;
                            Image starRating = new Image();
                            starRating.Name = scriptName;
                            if (currentRating >= count)
                            {
                                starRating.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                            }
                            else
                            {
                                starRating.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                            }
                            starRating.Margin = new Thickness { Left = 160 + addPaddingRatingStar, Top = checkBoxTop };
                            starRating.Width = 20;
                            starRating.Height = 20;
                            starRating.Cursor = Cursors.Hand;
                            starRating.ToolTip = "Rate " + scriptName + ": " + count + "/5";
                            starRating.MouseUp += ((s, e) =>
                            {
                                DbHandler.SetScriptRating(scriptName, rating);
                            });
                            addPaddingRatingStar += 20;
                            championsSelection.Children.Add(starRating);
                        }

                        CheckBox checkbox = new CheckBox
                        {
                            Margin = new Thickness { Left = 10, Top = checkBoxTop },
                            Name = list[x]["script"].ToString(),
                            //checkbox.ToolTip = scriptName + " Rated " + rating + " / 5";
                            ToolTip = scriptName + " Rated " + currentRating + " / 5"
                        };
                        foreach (CheckBox box in checkedCheckboxes)
                        {
                            if (box.Name == checkbox.Name)
                            {
                                checkbox.IsChecked = true;
                            }
                        }
                        checkbox.Checked += (s, e) => { SelectingModules(s, e, checkbox); };
                        TextBlock moduleName = new TextBlock
                        {
                            Margin = new Thickness { Left = 39, Top = ModulenameTop += 25 },
                            Text = list[x]["script"].ToString() + ".lua",
                            FontSize = 16
                        };
                        moduleName.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                        //moduleName.ToolTip = scriptName + " Rated " + rating + " / 5";
                        moduleName.ToolTip = scriptName + " Rated " + currentRating + " / 5";
                        championsSelection.Children.Add(checkbox);
                        championsSelection.Children.Add(moduleName);
                        championsSelection.Children.Add(star);
                        checkboxes.Add(checkbox);
                        labelNames.Add(moduleName);
                    }
                }
            }
        }

        private void CreateFavorites()
        {
            favoriteSelection.Children.Clear();
            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Settings\favorites.ini";
            int checkBoxTop = -15;
            int checkboxLeft = 480;
            int ModulenameTop = -18;
            int modulenameleft = 509;
            bool filledLeftSide = false;
            if(!File.Exists(path))
            {
                return;
            }
            foreach (string script in File.ReadLines(path))
            {
                var scriptName = script;
                if (scriptName.Contains(" ") || scriptName.Contains("(") || scriptName.Contains(")"))
                {
                    continue;
                }
                if (filledLeftSide == true)
                {
                    CheckBox checkbox2 = new CheckBox
                    {
                        Margin = new Thickness { Left = checkboxLeft, Top = checkBoxTop += 25 },
                        Name = scriptName.ToString()
                    };
                    checkbox2.Checked += (s, e) => { SelectingModules(s, e, checkbox2); };
                    TextBlock moduleName2 = new TextBlock
                    {
                        Margin = new Thickness { Left = modulenameleft, Top = ModulenameTop += 25 },
                        Text = scriptName.ToString() + ".lua",
                        FontSize = 16
                    };
                    moduleName2.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                    favoriteSelection.Children.Add(checkbox2);
                    favoriteSelection.Children.Add(moduleName2);
                    if (scriptName.Contains("Community"))
                    {
                        favoriteCheckboxesCommunity.Add(checkbox2);
                    }
                    else
                    {
                        favoriteCheckboxes.Add(checkbox2);
                    }
                }
                else
                {
                    CheckBox checkbox = new CheckBox
                    {
                        Margin = new Thickness { Left = 10, Top = checkBoxTop += 25 },
                        Name = scriptName.ToString()
                    };
                    checkbox.Checked += (s, e) => { SelectingModules(s, e, checkbox); };
                    TextBlock moduleName = new TextBlock
                    {
                        Margin = new Thickness { Left = 39, Top = ModulenameTop += 25 },
                        Text = scriptName.ToString() + ".lua",
                        FontSize = 16
                    };
                    moduleName.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                    favoriteSelection.Children.Add(checkbox);
                    favoriteSelection.Children.Add(moduleName);
                    if (scriptName.Contains("Community"))
                    {
                        favoriteCheckboxesCommunity.Add(checkbox);
                    }
                    else
                    {
                        favoriteCheckboxes.Add(checkbox);
                    }
                    if (checkBoxTop > 2000)
                    {
                        filledLeftSide = true;
                        checkBoxTop = -15;
                        ModulenameTop = -18;
                    }
                }
            }
        }

        private void CreateCommunity()
        {
            var CommunityScripts = Directory.EnumerateFiles(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Community\", "*", SearchOption.TopDirectoryOnly).Select(System.IO.Path.GetFileName);
            int checkBoxTop = -15;
            int checkboxLeft = 480;
            int ModulenameTop = -18;
            int modulenameleft = 509;
            bool filledLeftSide = false;
            foreach (string script in CommunityScripts)
            {
                var dot = script.IndexOf(".", StringComparison.Ordinal);
                var scriptName = script.Substring(0, dot);
                if(scriptName.Contains(" ") || scriptName.Contains("(") || scriptName.Contains(")"))
                {
                    continue;
                }
                if (filledLeftSide == true)
                {
                    bool isFavorite = false;
                    foreach (var favorite in favoriteCheckboxesCommunity)
                    {
                        if (favorite.Name == scriptName)
                        {
                            isFavorite = true;
                            break;
                        }
                    }
                    Image star = new Image();
                    if (isFavorite)
                    {
                        star.Name = scriptName;
                        star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                        star.Margin = new Thickness { Left = 725, Top = checkBoxTop += 25 };
                        star.Width = 20;
                        star.Height = 20;
                        star.Cursor = Cursors.Hand;
                        star.ToolTip = "Favorite: " + scriptName;
                        star.MouseUp += ((s, e) =>
                        {
                            FavoriteButton(star, scriptName, false);
                        });
                    }
                    else
                    {
                        star.Name = scriptName;
                        star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                        star.Margin = new Thickness { Left = 725, Top = checkBoxTop += 25 };
                        star.Width = 20;
                        star.Height = 20;
                        star.Cursor = Cursors.Hand;
                        star.ToolTip = "Favorite: " + scriptName;
                        star.MouseUp += ((s, e) =>
                        {
                            FavoriteButton(star, scriptName, false);
                        });
                    }
                    CheckBox checkbox2 = new CheckBox
                    {
                        Margin = new Thickness { Left = checkboxLeft, Top = checkBoxTop },
                        Name = scriptName.ToString()
                    };
                    foreach (CheckBox box in checkedCheckboxesCommunity)
                    {
                        if (box.Name == checkbox2.Name)
                        {
                            checkbox2.IsChecked = true;
                        }
                    }
                    checkbox2.Checked += (s, e) => { SelectingModules(s, e, checkbox2); };
                    TextBlock moduleName2 = new TextBlock
                    {
                        Margin = new Thickness { Left = modulenameleft, Top = ModulenameTop += 25 },
                        Text = scriptName.ToString() + ".lua",
                        FontSize = 16
                    };
                    moduleName2.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                    communitySelection.Children.Add(checkbox2);
                    communitySelection.Children.Add(moduleName2);
                    communitySelection.Children.Add(star);
                    CommunityCheckboxes.Add(checkbox2);
                }
                else
                {
                    bool isFavorite = false;
                    foreach (var favorite in favoriteCheckboxesCommunity)
                    {
                        if (favorite.Name == scriptName)
                        {
                            isFavorite = true;
                            break;
                        }
                    }
                    Image star = new Image();
                    if (isFavorite)
                    {
                        star.Name = scriptName;
                        star.Source = new BitmapImage(new Uri("star.jpg", UriKind.Relative));
                        star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                        star.Width = 20;
                        star.Height = 20;
                        star.Cursor = Cursors.Hand;
                        star.ToolTip = "Favorite: " + scriptName;
                        star.MouseUp += ((s, e) =>
                        {
                            FavoriteButton(star, scriptName, false);
                        });
                    }
                    else
                    {
                        star.Name = scriptName;
                        star.Source = new BitmapImage(new Uri("starEmpty.jpg", UriKind.Relative));
                        star.Margin = new Thickness { Left = 300, Top = checkBoxTop += 25 };
                        star.Width = 20;
                        star.Height = 20;
                        star.Cursor = Cursors.Hand;
                        star.ToolTip = "Favorite: " + scriptName;
                        star.MouseUp += ((s, e) =>
                        {
                            FavoriteButton(star, scriptName, false);
                        });
                    }
                    CheckBox checkbox = new CheckBox
                    {
                        Margin = new Thickness { Left = 10, Top = checkBoxTop },
                        Name = scriptName.ToString()
                    };
                    foreach (CheckBox box in checkedCheckboxesCommunity)
                    {
                        if (box.Name == checkbox.Name)
                        {
                            checkbox.IsChecked = true;
                        }
                    }
                    checkbox.Checked += (s, e) => { SelectingModules(s, e, checkbox); };
                    TextBlock moduleName = new TextBlock
                    {
                        Margin = new Thickness { Left = 39, Top = ModulenameTop += 25 },
                        Text = scriptName.ToString() + ".lua",
                        FontSize = 16
                    };
                    moduleName.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                    communitySelection.Children.Add(checkbox);
                    communitySelection.Children.Add(moduleName);
                    communitySelection.Children.Add(star);
                    CommunityCheckboxes.Add(checkbox);
                    if (checkBoxTop > 1710)
                    {
                        filledLeftSide = true;
                        checkBoxTop = -15;
                        ModulenameTop = -18;
                    }
                }
            }
        }

        private void CreateVipList()
        {
            List<dynamic> list = DbHandler.GetScriptsVip(userName);
            int checkBoxTop = -15;
            int checkboxLeft = 480;
            int ModulenameTop = -18;
            int modulenameleft = 509;
            bool filledLeftSide = false;
            List<string> VipScriptsOwned = new List<string>();
            for (int x = 0; x < list.Count; x++)
            {
                for (int i = 0; i < 1; i++)
                {
                    string scriptName = list[x]["scriptName"].ToString();
                    List<dynamic> VipScriptsWithSub = DbHandler.HasActiveVipSub(userName);
                    for (int j = 0; j < VipScriptsWithSub.Count; j++)
                    {
                        string VipScriptName = VipScriptsWithSub[j]["scriptName"].ToString();
                        if (VipScriptName == scriptName)
                        {
                            VipScriptsOwned.Add(scriptName);
                            if (scriptName.Contains(" ") || scriptName.Contains("(") || scriptName.Contains(")"))
                            {
                                continue;
                            }

                            DateTime today = Convert.ToDateTime(Date.GetDate());
                            DateTime sub = Convert.ToDateTime(VipScriptsWithSub[j]["endSub"]);
                            int result = DateTime.Compare(today, sub);
                            if (result > 0)
                            {
                                continue;
                            }

                            if (filledLeftSide == true)
                            {
                                CheckBox checkbox2 = new CheckBox
                                {
                                    Margin = new Thickness { Left = checkboxLeft, Top = checkBoxTop += 25 },
                                    Name = scriptName,
                                    ToolTip = "Subscription till: " + sub
                                };
                                foreach (CheckBox box in checkedCheckboxes)
                                {
                                    if (box.Name == checkbox2.Name)
                                    {
                                        checkbox2.IsChecked = true;
                                    }
                                }
                                checkbox2.Checked += (s, e) => { SelectingModules(s, e, checkbox2); };
                                TextBlock moduleName2 = new TextBlock
                                {
                                    Margin = new Thickness { Left = modulenameleft, Top = ModulenameTop += 25 },
                                    Text = scriptName + ".lua (" + list[x]["creator"].ToString() + ")",
                                    FontSize = 16
                                };
                                moduleName2.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                                moduleName2.ToolTip = "Subscription till: " + sub;
                                vipSelection.Children.Add(checkbox2);
                                vipSelection.Children.Add(moduleName2);
                                VipCheckBoxes.Add(checkbox2);
                            }
                            else
                            {
                                CheckBox checkbox = new CheckBox
                                {
                                    Margin = new Thickness { Left = 10, Top = checkBoxTop += 25 },
                                    Name = scriptName,
                                    ToolTip = "Subscription till: " + sub
                                };
                                foreach (CheckBox box in checkedCheckboxes)
                                {
                                    if (box.Name == checkbox.Name)
                                    {
                                        checkbox.IsChecked = true;
                                    }
                                }
                                checkbox.Checked += (s, e) => { SelectingModules(s, e, checkbox); };
                                TextBlock moduleName = new TextBlock
                                {
                                    Margin = new Thickness { Left = 39, Top = ModulenameTop += 25 },
                                    Text = scriptName + ".lua (" + list[x]["creator"].ToString() + ")",
                                    FontSize = 16
                                };
                                moduleName.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                                moduleName.ToolTip = "Subscription till: " + sub;
                                vipSelection.Children.Add(checkbox);
                                vipSelection.Children.Add(moduleName);
                                VipCheckBoxes.Add(checkbox);
                                if (checkBoxTop > 1710)
                                {
                                    filledLeftSide = true;
                                    checkBoxTop = -15;
                                    ModulenameTop = -18;
                                }
                            }
                        }
                    }
                    if (scriptName.Contains(" ") || scriptName.Contains("(") || scriptName.Contains(")"))
                    {
                        continue;
                    }

                    bool shouldSkipLoop = false;
                    for (int d = 0; d < VipScriptsOwned.Count; d++)
                    {
                        if (scriptName == VipScriptsOwned[d])
                        {
                            shouldSkipLoop = true;
                        }
                    }

                    if (shouldSkipLoop)
                    {
                        continue;
                    }
                    DateTime today2 = Convert.ToDateTime(Date.GetDate());
                    DateTime sub2 = new DateTime(2019, 10, 26);
                    int result2 = DateTime.Compare(today2, sub2);
                    if (filledLeftSide == true)
                    {
                        CheckBox checkbox2 = new CheckBox
                        {
                            Margin = new Thickness { Left = checkboxLeft, Top = checkBoxTop += 25 },
                            Name = scriptName,
                            ToolTip = "No current subscription for this VIP script"
                        };
                        foreach (CheckBox box in checkedCheckboxes)
                        {
                            if (box.Name == checkbox2.Name)
                            {
                                checkbox2.IsChecked = true;
                            }
                        }
                        checkbox2.Checked += (s, e) => { SelectingModules(s, e, checkbox2); };
                        TextBlock moduleName2 = new TextBlock
                        {
                            Margin = new Thickness { Left = modulenameleft, Top = ModulenameTop += 25 },
                            Text = scriptName + ".lua (" + list[x]["creator"].ToString() + ")",
                            FontSize = 16
                        };
                        moduleName2.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                        moduleName2.ToolTip = "No current subscription for this VIP script";
                        vipSelection.Children.Add(checkbox2);
                        vipSelection.Children.Add(moduleName2);
                        VipCheckBoxes.Add(checkbox2);
                    }
                    else
                    {
                        CheckBox checkbox = new CheckBox
                        {
                            Margin = new Thickness { Left = 10, Top = checkBoxTop += 25 },
                            Name = scriptName,
                            ToolTip = "No current subscription for this VIP script"
                        };
                        foreach (CheckBox box in checkedCheckboxes)
                        {
                            if (box.Name == checkbox.Name)
                            {
                                checkbox.IsChecked = true;
                            }
                        }
                        checkbox.Checked += (s, e) => { SelectingModules(s, e, checkbox); };
                        TextBlock moduleName = new TextBlock
                        {
                            Margin = new Thickness { Left = 39, Top = ModulenameTop += 25 },
                            Text = scriptName + ".lua (" + list[x]["creator"].ToString() + ")",
                            FontSize = 16
                        };
                        moduleName.SetValue(TextBlock.FontWeightProperty, FontWeights.Bold);
                        moduleName.ToolTip = "No current subscription for this VIP script";
                        vipSelection.Children.Add(checkbox);
                        vipSelection.Children.Add(moduleName);
                        VipCheckBoxes.Add(checkbox);
                        if (checkBoxTop > 1710)
                        {
                            filledLeftSide = true;
                            checkBoxTop = -15;
                            ModulenameTop = -18;
                        }
                    }
                }
            }
        }

        private void DownloadCompleted(object sender, AsyncCompletedEventArgs e)
        {
            MessageBox.Show("The following scripts have been updated succesfully: " + allDownloadedScripts);
        }

        private void DownloadCompletedLibs(object sender, AsyncCompletedEventArgs e)
        {
            //empty function as callback
        }

        public void DownloadLibs()
        {
            List<dynamic> list = DbHandler.GetScripts("Lib");
            for (int i = 0; i < list.Count; i++)
            {
                string scriptName = list[i]["script"].ToString();
                string scriptPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Libs\" + scriptName + ".lua";
                if (!File.Exists(scriptPath))
                {
                    allDownloadedScripts += scriptName + ".lua ";
                    using (var client = new WebClient())
                    {
                        if (downloadCompleteEvent == false)
                        {
                            client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompletedLibs);
                        }
                        downloadCompleteEvent = true;
                        try
                        {
                            client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/Libs/" + scriptName + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Libs\" + scriptName + ".lua");
                        }
                        catch (Exception)
                        {
                            //
                        }
                    }
                }
                string versionPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + scriptName + ".txt";
                if (File.Exists(versionPath))
                {
                    string version = File.ReadAllText(versionPath);
                    string versionDB = list[i]["version"];
                    if (versionDB.ToString() != version)
                    {
                        CreateVersionFile(scriptName, "Official");
                        allDownloadedScripts += scriptName + ".lua ";
                        using (var client = new WebClient())
                        {
                            if (downloadCompleteEvent == false)
                            {
                                client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompletedLibs);
                            }
                            downloadCompleteEvent = true;
                            try
                            {
                                client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/Libs/" + scriptName + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Libs\" + scriptName + ".lua");
                            }
                            catch (Exception)
                            {
                                //
                            }
                        }
                    }
                } else
                {
                    CreateVersionFile(scriptName, "Official");
                    using (var client = new WebClient())
                    {
                        if (downloadCompleteEvent == false)
                        {
                            client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompletedLibs);
                        }
                        downloadCompleteEvent = true;
                        try
                        {
                            client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/Libs/" + scriptName + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Libs\" + scriptName + ".lua");
                        }
                        catch (Exception)
                        {
                            //
                        }
                    }
                }
            }
        }

        public void DownloadScripts()
        {
            foreach (var script in favoriteCheckboxes)
            {
                if (script.IsChecked == true)
                {
                    string scriptPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official\" + script.Name + ".lua";
                    if (!File.Exists(scriptPath))
                    {
                        allDownloadedScripts += script.Name.ToString() + ".lua ";
                        using (var client = new WebClient())
                        {
                            if (downloadCompleteEvent == false)
                            {
                                client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompleted);
                            }
                            downloadCompleteEvent = true;
                            try
                            {
                                client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/" + script.Name.ToString() + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official\" + script.Name.ToString() + ".lua");
                            }
                            catch (Exception)
                            {
                                //
                            }
                        }
                    }
                    else
                    {
                        string versionPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + script.Name + ".txt";
                        if (File.Exists(versionPath))
                        {
                            string version = File.ReadAllText(versionPath);
                            string versionDB = DbHandler.GetFileVersion(script.Name, "Official");
                            if (versionDB != version)
                            {
                                CreateVersionFile(script.Name, "Official");
                                allDownloadedScripts += script.Name.ToString() + ".lua ";
                                using (var client = new WebClient())
                                {
                                    if (downloadCompleteEvent == false)
                                    {
                                        client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompleted);
                                    }
                                    downloadCompleteEvent = true;
                                    try
                                    {
                                        client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/" + script.Name.ToString() + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official\" + script.Name.ToString() + ".lua");
                                    }
                                    catch (Exception)
                                    {
                                        //
                                    }
                                }
                            }
                        }
                    }
                }
            }
            foreach (var script in checkboxes)
            {
                if (script.IsChecked == true)
                {
                    string scriptPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official\" + script.Name + ".lua";
                    if (!File.Exists(scriptPath))
                    {
                        allDownloadedScripts += script.Name.ToString() + ".lua ";
                        using (var client = new WebClient())
                        {
                            if (downloadCompleteEvent == false)
                            {
                                client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompleted);
                            }
                            downloadCompleteEvent = true;
                            try
                            {
                                client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/" + script.Name.ToString() + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official\" + script.Name.ToString() + ".lua");
                            }
                            catch (Exception)
                            {
                                //
                            }
                        }
                    } else
                    {
                        string versionPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + script.Name + ".txt";
                        if (File.Exists(versionPath))
                        {
                            string version = File.ReadAllText(versionPath);
                            string versionDB = DbHandler.GetFileVersion(script.Name, "Official");
                            if (versionDB != version)
                            {
                                CreateVersionFile(script.Name, "Official");
                                allDownloadedScripts += script.Name.ToString() + ".lua ";
                                using (var client = new WebClient())
                                {
                                    if (downloadCompleteEvent == false)
                                    {
                                        client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompleted);
                                    }
                                    downloadCompleteEvent = true;
                                    try
                                    {
                                        client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/" + script.Name.ToString() + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official\" + script.Name.ToString() + ".lua");
                                    }
                                    catch (Exception)
                                    {
                                        //
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // implement call to check if sub still active for user for the paid script. if not show messagebox with following context: "Your subscription has run out for script xxx, Please disable this module to load the software."
            foreach (var script in VipCheckBoxes)
            {
                if (script.IsChecked == true)
                {
                    string scriptPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Vip\" + script.Name + ".lua";
                    if (!File.Exists(scriptPath))
                    {
                        allDownloadedScripts += script.Name.ToString() + ".lua ";
                        using (var client = new WebClient())
                        {
                            if (downloadCompleteEvent == false)
                            {
                                client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompleted);
                            }
                            downloadCompleteEvent = true;
                            try
                            {
                                client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/Vip/" + script.Name.ToString() + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Vip\" + script.Name.ToString() + ".lua");
                            }
                            catch (Exception)
                            {
                                //
                            }
                        }
                    }
                    else
                    {
                        string versionPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + script.Name + ".txt";
                        if (File.Exists(versionPath))
                        {
                            string version = File.ReadAllText(versionPath);
                            string versionDB = DbHandler.GetFileVersion(script.Name, "VIP");
                            if (versionDB != version)
                            {
                                CreateVersionFile(script.Name, "VIP");
                                allDownloadedScripts += script.Name.ToString() + ".lua ";
                                using (var client = new WebClient())
                                {
                                    if (downloadCompleteEvent == false)
                                    {
                                        client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompleted);
                                    }
                                    downloadCompleteEvent = true;
                                    try
                                    {
                                        client.DownloadFileAsync(new Uri("https://cheatingpalace.com/scripts_storage/Vip/" + script.Name.ToString() + ".lua"), Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Vip\" + script.Name.ToString() + ".lua");
                                    }
                                    catch (Exception)
                                    {
                                        //
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        private void CreateVersionFile(string script, string type)
        {
            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + script + ".txt";
            string version = DbHandler.GetFileVersion(script, type);
            File.WriteAllText(path, version);
        }

        private void GetModules()
        {
            allDownloadedScripts = "";
            downloadCompleteEvent = false;
            OfficialScripts = "";
            foreach (var checkbox in checkboxes)
            {
                if (checkbox.IsChecked == true)
                {
                    string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + checkbox.Name + ".txt";
                    if (!File.Exists(path))
                    {
                        CreateVersionFile(checkbox.Name, "Official");
                    }
                    if (!OfficialScripts.Contains(checkbox.Name))
                    {
                        OfficialScripts += checkbox.Name + " ";
                    }
                }
            }

            FavoriteScripts = "";
            foreach (var checkbox in favoriteCheckboxes)
            {
                if (checkbox.IsChecked == true)
                {
                    if (!FavoriteScripts.Contains(checkbox.Name))
                    {
                        FavoriteScripts += checkbox.Name + " ";
                    }
                    string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + checkbox.Name + ".txt";
                    if (!File.Exists(path))
                    {
                        CreateVersionFile(checkbox.Name, "Official");
                    }
                }
            }
            CommunityScripts = "";

            foreach (var checkbox in CommunityCheckboxes)
            {
                if (checkbox.IsChecked == true)
                {
                    if (!CommunityScripts.Contains(checkbox.Name))
                    {
                        CommunityScripts += checkbox.Name + " ";
                    }
                    string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + checkbox.Name + ".txt";
                    if (!File.Exists(path))
                    {
                        CreateVersionFile(checkbox.Name, "Community");
                    }
                }
            }

            FavoriteScriptsCommunity = "";
            foreach (var checkbox in favoriteCheckboxesCommunity)
            {
                if (checkbox.IsChecked == true)
                {
                    if (!CommunityScripts.Contains(checkbox.Name))
                    {
                        FavoriteScriptsCommunity += checkbox.Name + " ";
                    }
                    string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + checkbox.Name + ".txt";
                    if (!File.Exists(path))
                    {
                        CreateVersionFile(checkbox.Name, "Community");
                    }
                }
            }

            VipScripts = "";

            foreach (var checkbox in VipCheckBoxes)
            {
                if (checkbox.IsChecked == true)
                {
                    //check if paid script sub active
                    bool isVipScriptSubValid = DbHandler.CheckVipScriptSubActive(checkbox.Name);
                    if (isVipScriptSubValid)
                    {
                        if (!VipScripts.Contains(checkbox.Name))
                        {
                            VipScripts += checkbox.Name + " ";
                        }
                        string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions\" + checkbox.Name + ".txt";
                        if (!File.Exists(path))
                        {
                            CreateVersionFile(checkbox.Name, "VIP");
                        }
                    } else
                    {
                        checkbox.IsChecked = false;
                        VipScripts.Replace(checkbox.Name, "");
                        MessageBox.Show("Your subscription for: " + checkbox.Name + " Has expired, please renew to activate it again");
                    }
                }
            }

            DownloadScripts();
            LoadLolCheat();
        }

        private void DownloadLOL_Cheat()
        {
            DbHandler.CheckSub();
            if (lolSubValid == true || lolSessionCount != 0)
            {
                DbHandler.GetUserData(Hwid.getHardwareID());
                if (lolSubValid || lolSessionCount != 0)
                {
                    using (WebClient wc = new WebClient())
                    {
                        try
                        {
                            //wc.Headers.Add("Content-Type", uhashdkqm);
                            //DownloadDll(wc);
                        }
                        catch (Exception exception)
                        {
                            MessageBox.Show("Something went wrong - contact Scortch " + exception.Message);
                        }
                    }
                    // no longer needed as we include ext.exe inside mainloader, besides this TODO: inject lol.dll from bytes from memory into freshly created cmd.exe
                    //using (WebClient wc = new WebClient())
                    //{
                    //    try
                    //    {
                    //        //wc.Headers.Add("Content-Type", uhashdkqm);
                    //        //DownloadExt(wc);
                    //    } catch (Exception exception)
                    //    {
                    //        MessageBox.Show("Something went wrong - contact Scortch " + exception.Message);
                    //    }
                    //}
                }
                if (lolSubValid == false && lolSessionCount != 0)
                {
                    lolSessionCount--;
                    DbHandler.SetLolSessions(lolSessionCount);
                }
            }
            else
            {
                MessageBox.Show("Your subscription has expired please renew to access the cheat");
            }
        }

        public void StartCheat(object sender, RoutedEventArgs e)
        {
            GetModules();
        }

        public void DownloadExt(WebClient wc)
        {
            wc.Headers.Add("verification", "mainloader.exe");
            var file = wc.DownloadData("https://cheatingpalace.com/LOL/prod/downloadE.php");
            File.WriteAllBytes(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/ext.exe", file);
            //wc.DownloadFile("https://cheatingpalace.com/LOL/prod/downloadE.php", Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/ext.exe");
        }

        public static byte[] DownloadDll(WebClient wc)
        {
            wc.Headers.Add("verification", "mainloader.exe");
            var file = wc.DownloadData("https://cheatingpalace.com/LOL/prod/downloadD.php");
            return file;
        }

        public static byte[] DownloadDllTestEnv(WebClient wc)
        {
            wc.Headers.Add("verification", "mainloader.exe");
            var file = wc.DownloadData("https://cheatingpalace.com/LOL/test/downloadD.php");
            return file;
        }

        //private static Random random = new Random();

        public static string RandomString(int length)
        {
            Random random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijmnopqrstuvwxyz0123456789";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        private void LoadLolCheat()
        {
            DbHandler.CheckSub();
            if (lolSubValid == true || lolSessionCount != 0)
            {
                DbHandler.GetUserData(Hwid.getHardwareID());
                if (lolSubValid == false && lolSessionCount != 0)
                {
                    lolSessionCount--;
                    DbHandler.SetLolSessions(lolSessionCount);
                }
            }
            else
            {
                MessageBox.Show("Your subscription has expired please renew to access the cheat");
                return;
            }
            try
            {
                bool isLeagueRunning = false;
                Process[] processlist = Process.GetProcesses();
                foreach (Process process in processlist)
                {
                    if (process.ProcessName == "League of Legends")
                    {
                        isLeagueRunning = true;
                    }
                }

                if (isLeagueRunning == true)
                {
                    FilterScriptsLoadOrder();
                    //Thread.Sleep(2000);
                    //Process.Start(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/ext.exe", "HWID=\"" + newHwid + "\" " + "OFFICIAL=\"" + OfficialScripts + FavoriteScripts + "\" " + "COMMUNITY=\"" + CommunityScripts + FavoriteScriptsCommunity + "\"");
                    //new loading method
                    string rds = RandomString(22);
                    string loadfileString = RandomString(100);
                    string filename = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/" + rds;
                    string content = "HWID=\"" + hwid + "\" " + "OFFICIAL=\"" + OfficialScripts + FavoriteScripts + "\" " + "COMMUNITY=\"" + CommunityScripts + FavoriteScriptsCommunity + "\" " + "VIP=\"" + VipScripts + "\"";
                    string encryptedContent = CryptoGraphy.EncryptString(content, hwid + rds);
                    string path = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/", "ext.exe");
                    //File.WriteAllBytes(path, Properties.Resources.ext_exe);
                    //Process.Start(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/ext.exe", loadfileString);
                    //Process.Start(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/LolExt/ext.exe");
                    // chris method
                    WebClient wc = new WebClient();
                    var Binary = DownloadDll(wc);
                    DbHandler.SetLoadFile(rds);
                    File.WriteAllText(filename, encryptedContent);
                    bool isSuccess = Injector.LoadHack(Binary);
                    LoadFileName = filename;
                    isLoadFileValid = true;
                    DateTime today = Convert.ToDateTime(Date.GetDate());
                    Log.SentToDb("injected", "Loaded LOL");
                    Log.SentToDb("injected_scripts", OfficialScripts + CommunityScripts + FavoriteScripts + FavoriteScriptsCommunity);
                    //SelfDelete.DeleteCFiles();
                }
                else
                {
                    MessageBox.Show(
                        "League of Legends is currently not running, please start a game and then press Load Cheat");
                }
            }
            catch (Exception e)
            {
                Log.SentToDb("injected", "Failed to load lol + " + e.Message);
            }
        }

        private void FilterScriptsLoadOrder()
        {
            string newOfficialScripts = "";
            string evade = "Evade ";
            string activator = "Activator ";
            string awareness = "Awareness ";
            string prediction = "Prediction ";
            string orbwalker = "Orbwalker ";
            if (OfficialScripts.Contains(activator))
            {
                newOfficialScripts += activator;
                OfficialScripts = OfficialScripts.Replace(activator, "");
            }
            if (OfficialScripts.Contains(awareness))
            {
                newOfficialScripts += awareness;
                OfficialScripts = OfficialScripts.Replace(awareness, "");
            }
            if (OfficialScripts.Contains(prediction))
            {
                newOfficialScripts += prediction;
                OfficialScripts = OfficialScripts.Replace(prediction, "");
            }
            if (OfficialScripts.Contains(orbwalker))
            {
                newOfficialScripts += orbwalker;
                OfficialScripts = OfficialScripts.Replace(orbwalker, "");
            }
            if (OfficialScripts.Contains(evade))
            {
                newOfficialScripts += evade;
                OfficialScripts = OfficialScripts.Replace(evade, "");
            }
            if (OfficialScripts != "")
            {
                newOfficialScripts += OfficialScripts;
                OfficialScripts = "";
            }
            OfficialScripts = newOfficialScripts;
        }

        private void LoadCsgo_Cheat(object sender, RoutedEventArgs e)
        {
            if (csgoSubValid == true)
            {
                using (WebClient wc = new WebClient())
                {
                    wc.DownloadFile("https://cheatingpalace.com/counterstrikeGO/exe/Injector.exe", "./Injector.exe");
                    wc.DownloadFile("https://cheatingpalace.com/counterstrikeGO/dll/CSGOPrivateRework.dll", "./CSGOPrivateRework.dll");
                    try
                    {
                        // for slow connections, safety net
                        Thread.Sleep(1000);
                        Process.Start("Injector.exe", newHwid);
                        DateTime today = Convert.ToDateTime(Date.GetDate());
                        Log.SentToDb("injected", "Injected-csgo");
                    }
                    catch
                    {
                        DateTime today = Convert.ToDateTime(Date.GetDate());
                        Log.SentToDb("injected", "Failed to inject CSGO");
                    }
                }
            }
            else
            {
                MessageBox.Show("Your subscription has expired please renew to access the cheat");
            }
        }

        private void LoadMenuSettings(object sender, RoutedEventArgs e)
        {
            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Settings\loader.ini";
            File.WriteAllText(path, "AutoLoad=" + autoLoadCheat.IsChecked.ToString() + "\n" + "AutoCheckCoreScripts=" + autoCheckCoreScriptsBtn.IsChecked.ToString());
            if (autoLoadCheat.IsChecked == true)
            {
                inGameCheckTimer.Elapsed += new ElapsedEventHandler(InGameCheckEvent);
                inGameCheckTimer.Interval = 4000;
                inGameCheckTimer.Enabled = true;
            }
        }

        private void loadConfig_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string path = lolPath.Text + @"\input.ini";
                string config = "";
                foreach (string line in System.IO.File.ReadLines(path))
                {
                    string line2 = line;
                    if (line.Contains("evtPlayerAttackMoveClick="))
                    {
                        line2 = "evtPlayerAttackMoveClick=[a]";
                    }
                    config += line2 + "\n";
                }
                File.WriteAllText(path, config);
            }
            catch (Exception x)
            {
                Console.WriteLine("The process failed: {0}", x.ToString());
            }
        }

        private void LoginBtn_OnClick(object sender, RoutedEventArgs e)
        {
            switch(DbHandler.checkLogin(username.Text, password.Password, globalPassword.Text))
            {
                case "0":
                    Log.SentToDb("declined", "Failed login");
                    SelfDelete.Delete();
                    break;
                case "1":
                    DbHandler.SetHwid(username.Text);
                    SelfDelete.Restart();
                    break;
                case "2":
                    Log.SentToDb("declined", "Failed global login");
                    SelfDelete.Delete();
                    break;
                case "3":
                    Log.SentToDb("declined", "Cant renew HWID too recent attempt");
                    SelfDelete.Delete();
                    break;
                default:
                    break;
            }
        }

        private void SetPasswordBtn_OnClick(object sender, RoutedEventArgs e)
        {
            if (setPassword.Password != "")
            {
                string passwordHash = Crypter.Blowfish.Crypt(setPassword.Password);
                DbHandler.SetPassword(passwordHash);
                SelfDelete.Restart();
            }
            else
            {
                MessageBox.Show("Please enter a valid password");
            }
        }

        private void alreadyMember_Click(object sender, RoutedEventArgs e)
        {
            Register.Visibility = Visibility.Hidden;
            Login.Visibility = Visibility.Visible;
        }

        private void registerBtn_Click(object sender, RoutedEventArgs e)
        {
            DbHandler.setUser(registerUsername.Text, registerPassword.Password, newHwid, ip, key.Text);
        }

        private void SelectingModules(object sender, RoutedEventArgs e, CheckBox checkBox)
        {
            
            if (isZoomHackUser == "1")
            {
                MessageBox.Show("You do not have a subscription for this feature, if you want to use all of our features make sure to buy the right package online!");
                checkBox.IsChecked = false;
            }
        }

        private void BtnSelectFile_OnClick(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();

            if (openFileDialog.ShowDialog() == true)
            {
                var scriptName = openFileDialog.FileName;
                if (string.IsNullOrEmpty(scriptName))
                {
                    MessageBox.Show("Please select a file first.");
                    return;
                }

                var sourcePath = scriptName;
                var targetDirectory = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Community"; // Change this to the desired directory

                try
                {
                    if (!Directory.Exists(targetDirectory))
                    {
                        Directory.CreateDirectory(targetDirectory);
                    }

                    var fileName = Path.GetFileName(sourcePath);
                    var targetPath = Path.Combine(targetDirectory, fileName);
                    File.Move(sourcePath, targetPath);

                    MessageBox.Show($"File moved to: {targetPath}");
                    RefreshScriptListsFromCode();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error moving file: {ex.Message}");
                }
            }
        }

        private void SetZoomHack_OnClick(object sender, RoutedEventArgs e)
        {
            string sectionName = "[CORE_MISC]";
            string propertyName = "ZoomHackActive";
            string filePath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Settings\Core.ini"; // Replace with the path to your static file

            try
            {
                string[] fileLines = File.ReadAllLines(filePath);
                bool sectionFound = false;

                for (int i = 0; i < fileLines.Length; i++)
                {
                    string line = fileLines[i].Trim();

                    if (line == sectionName)
                    {
                        sectionFound = true;
                    }
                    else if (sectionFound && line.StartsWith(propertyName))
                    {
                        string[] propertyParts = line.Split('=');

                        if (propertyParts.Length == 2)
                        {
                            int currentValue;
                            if (int.TryParse(propertyParts[1].Trim(), out currentValue))
                            {
                                // Toggle the value
                                int newValue = currentValue == 0 ? 1 : 0;

                                // Update the line
                                fileLines[i] = $"{propertyName} = {newValue}";

                                // Write the updated content back to the file
                                File.WriteAllLines(filePath, fileLines);
                                if (newValue == 1)
                                {
                                    SetZoomHack.Content = "Disable ZoomHack";
                                }
                                else
                                {
                                    SetZoomHack.Content = "Enable ZoomHack";
                                }

                                return;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }

        void CheckZoomStatus()
        {
            string sectionName = "[CORE_MISC]";
            string propertyName = "ZoomHackActive";
            string filePath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Settings\Core.ini"; // Replace with the path to your static file

            try
            {
                string[] fileLines = File.ReadAllLines(filePath);
                bool sectionFound = false;

                for (int i = 0; i < fileLines.Length; i++)
                {
                    string line = fileLines[i].Trim();

                    if (line == sectionName)
                    {
                        sectionFound = true;
                    }
                    else if (sectionFound && line.StartsWith(propertyName))
                    {
                        string[] propertyParts = line.Split('=');

                        if (propertyParts.Length == 2)
                        {
                            int currentValue;
                            if (int.TryParse(propertyParts[1].Trim(), out currentValue))
                            {
                                if (currentValue == 0)
                                {
                                    SetZoomHack.Content = "Enable ZoomHack";
                                }
                                else
                                {
                                    SetZoomHack.Content = "Disable ZoomHack";
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}
