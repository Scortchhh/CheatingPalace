using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Timers;
using System.Windows;

namespace mainLoader
{
    class StartChecks
    {
        public static void Start()
        {
            if (Ip.CheckForInternetConnection() == false)
            {
                SelfDelete.Delete();
            }

            IsProxyActive();

            DbHandler.GetUserData(Hwid.getHardwareID());
        }

        public static void IsProxyActive()
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
                        Log.SentToDb("declined", "Proxy detected");
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
    }
}
