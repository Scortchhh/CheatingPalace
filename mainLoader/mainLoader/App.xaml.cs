using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Reflection;
using System.Windows;

namespace mainLoader
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {

            (string, string, string) patches = DbHandler.GetLolPatch();

            string patchloader = patches.Item1;
            if (patchloader != mainLoader.MainWindow.Loaderpatch)
            {
                WebClient client = new WebClient();
                client.Headers.Add("verification", "mainloader.exe");
                var file = client.DownloadData(new Uri("https://cheatingpalace.com/importantFiles/downloadL.php"));
                File.WriteAllBytes("Loader.exe", file);
                // Get the current executing directory
                string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);

                // Set the executable name
                string executableName = "Loader.exe";

                // Combine the current directory and the executable name to form the full path
                string appToStart = Path.Combine(currentDirectory, executableName);

                // Create a new ProcessStartInfo object with the application path
                ProcessStartInfo startInfo = new ProcessStartInfo(appToStart);

                // Create a new Process object and assign the startInfo
                Process process = new Process();
                process.StartInfo = startInfo;

                // Start the application
                process.Start();
                SelfDelete.Delete();
            }
            string newProcessName = AbstractLayer.RandomString(20); // replace with the new process name you want
            string exePath = Assembly.GetEntryAssembly().Location;
            string exeDir = Path.GetDirectoryName(exePath);
            string newExePath = Path.Combine(exeDir, $"{newProcessName}.exe");

            // check if the new process is already running
            if (Environment.GetEnvironmentVariable("NewProcessStarted") == null)
            {
                // copy the current executable to a new file with the specified process name
                File.Copy(exePath, newExePath);

                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = newExePath,
                    Arguments = $"-processname {newProcessName}",
                    UseShellExecute = false
                };

                // set an environment variable to indicate that the new process has been started
                startInfo.EnvironmentVariables["NewProcessStarted"] = "1";

                Process newProcess = new Process();
                newProcess.StartInfo = startInfo;
                newProcess.Start();

                newProcess.WaitForInputIdle();

                SelfDelete.Delete();
            }

            //HollowingProcess.HollowProcess();
            base.OnStartup(e);
            SplashScreen splashscreen;
            splashscreen = new SplashScreen(new Uri("cp.png", UriKind.Relative).ToString());
            splashscreen.Show(true);
            AbstractLayer.CheckDebuggers();
            StartChecks.Start();
        }
    }
}
