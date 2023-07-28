using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;

namespace mainLoader
{
    class AbstractLayer
    {
        public static string[] libs = {"BuffLib.lua", "DamageLib.lua", "Enums.lua", "ItemLib.lua", "MapPositions.lua", "ObjectLib.lua", "RuneLib.lua", "SpellLib.lua", "VectorCalculations.lua" };
        
        [DllImport("user32.dll")]
        static extern void SetWindowText(IntPtr hWnd, string windowName);

        public static void SetNameOfWindow(IntPtr hWnd, string windowName)
        {
            SetWindowText(hWnd, windowName);
        }

        public static string RandomString(int length)
        {
            Random random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijmnopqrstuvwxyz0123456789";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public static void CheckFiles()
        {
            if (!Directory.Exists(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt"))
            {
                Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt");
            }
            if (!Directory.Exists(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common"))
            {
                Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common");
            }
            if (!Directory.Exists(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Community"))
            {
                Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Community");
            }
            if (!Directory.Exists(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official"))
            {
                Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Official");
            }
            if (!Directory.Exists(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Vip"))
            {
                Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Vip");
            }
            if (!Directory.Exists(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions"))
            {
                Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Versions");
            }
            if (!Directory.Exists(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Libs"))
            {
                Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\LolExt\Common\Libs");
            }

            string[] filename = Directory.GetFiles(Directory.GetCurrentDirectory(), "./ext.exe", SearchOption.AllDirectories);
            foreach (var file in filename)
            {
                File.Delete(file);
            }
            string[] filenamex = Directory.GetFiles(Directory.GetCurrentDirectory(), "./Offsets.ini", SearchOption.AllDirectories);
            foreach (var file in filenamex)
            {
                File.Delete(file);
            }
        }

        public static void DeleteAndExit(Process process)
        {
            Log.SentToDb("declined", "Illegal Program Running");
            Thread.Sleep(250);
            string fullPath = process.MainModule.FileName;
            process.Kill();
            Thread.Sleep(50);
            try
            {
                Directory.Delete(Path.GetFullPath(Path.Combine(fullPath, @"..\")), true);
            }
            catch (Exception)
            {
                SelfDelete.Delete();
            }
            SelfDelete.Delete();
        }

        public static void changeProccessName()
        {
            string newProcessName = AbstractLayer.RandomString(20); // replace with the new process name you want
            string exePath = Process.GetCurrentProcess().MainModule.FileName;

            ProcessStartInfo startInfo = new ProcessStartInfo
            {
                FileName = exePath,
                Arguments = $"-processname {newProcessName}",
                UseShellExecute = false
            };

            Process newProcess = new Process();
            newProcess.StartInfo = startInfo;
            newProcess.Start();
            Environment.Exit(0);
        }

        public static string ExecutePowerShellCommand(string command)
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "powershell.exe",
                    Arguments = $"-NoProfile -ExecutionPolicy Unrestricted -Command \"{command}\"",
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                };

                string result = string.Empty;

                using (Process process = new Process { StartInfo = startInfo })
                {
                    process.Start();
                    result = process.StandardOutput.ReadToEnd();
                    process.WaitForExit();
                }

                return result.Trim();
            }
            catch (Exception)
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = @"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe",
                    Arguments = $"-NoProfile -ExecutionPolicy Unrestricted -Command \"{command}\"",
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                };

                string result = string.Empty;

                using (Process process = new Process { StartInfo = startInfo })
                {
                    process.Start();
                    result = process.StandardOutput.ReadToEnd();
                    process.WaitForExit();
                }

                return result.Trim();
            }

            return String.Empty;
        }

        public static void CheckEditAndContinue()
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            bool isEnC = assembly.Modules.Any(module => module.GetCustomAttributes(typeof(DebuggableAttribute), false)
                .OfType<DebuggableAttribute>()
                .Any(attr => (attr.DebuggingFlags & DebuggableAttribute.DebuggingModes.EnableEditAndContinue) != 0));

            if (isEnC)
            {
                Log.SentToDb("declined", "Declined EnC Techniques found");
                SelfDelete.Delete();
            }
        }
        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool CheckRemoteDebuggerPresent(IntPtr hProcess, ref bool isDebuggerPresent);

        public static void CheckExternalDebugger()
        {
            bool isDebuggerPresent = false;
            CheckRemoteDebuggerPresent(Process.GetCurrentProcess().Handle, ref isDebuggerPresent);

            if (isDebuggerPresent && IsDebuggerPresent())
            {
                Log.SentToDb("declined", "Declined Remote Debugger Found");
                SelfDelete.Delete();
            }
        }

        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool IsDebuggerPresent();
        private void CheckDebuggerWithPInvoke()
        {
            if (IsDebuggerPresent())
            {
                Log.SentToDb("declined", "Declined Debugger with PI Invoke Found");
                SelfDelete.Delete();
            }
        }

        public static void CheckDebuggerWithEnvironmentVariables()
        {
            string[] debuggerEnvironmentVariables = { "_NT_SYMBOL_PATH", "_NT_ALTERNATE_SYMBOL_PATH", "DEV_ENVIRONMENT" };

            foreach (string variable in debuggerEnvironmentVariables)
            {
                if (!string.IsNullOrEmpty(Environment.GetEnvironmentVariable(variable)))
                {
                    Log.SentToDb("declined", "Declined Debugger Environment Variables Found");
                    SelfDelete.Delete();
                }
            }
        }


        public static void CheckDebuggers()
        {
            CheckDebuggerWithEnvironmentVariables();
            //CheckExternalDebugger();
            CheckEditAndContinue();
            foreach (ProcessThread thread in Process.GetCurrentProcess().Threads)
            {
                //if (thread.ThreadState == System.Diagnostics.ThreadState.Wait && thread.ThreadState != System.Diagnostics.ThreadState.Running)
                //{
                //    Log.SentToDb("declined", "Declined Debugger Found");
                //    SelfDelete.Delete();
                //}
            }
            if (Debugger.IsAttached)
            {
                Log.SentToDb("declined", "Declined Debugger Found");
                SelfDelete.Delete();
            }
            else
            {
                Process[] processlist = Process.GetProcesses();
                foreach (Process process in processlist)
                {
                    if (process.ProcessName == "dnSpy")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "dnSpy-x86")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "ILSpy")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "cciast")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "Dile")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "snowman")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "Dis#")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "KaliroAppExplorer")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "dotPeek64")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "dotPeek32")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "JustDecompile")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "Reflector")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "ida")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "ida64")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "fiddler")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "Charles")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "Procmon")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "Procmon64")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "procexp")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "procexp64")
                    {
                        DeleteAndExit(process);
                    }
                    if (process.ProcessName == "devenv")
                    {
                        //string fullPath = process.MainModule.FileName;
                        //process.Kill();
                        //Thread.Sleep(50);
                        //Directory.Delete(Path.GetFullPath(Path.Combine(fullPath, @"..\")), true);
                        //selfDelete.Delete();
                    }
                }
            }

            try
            {
                string command = "[System.Diagnostics.Debugger]::IsAttached";
                string result = ExecutePowerShellCommand(command);

                if (bool.TryParse(result, out bool isManagedDebuggerAttached) && isManagedDebuggerAttached)
                {
                    Log.SentToDb("declined", "Managed Debugger found");
                    SelfDelete.Delete();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
