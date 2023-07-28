using System;
using System.IO;
using System.Net;

namespace mainLoader
{
    class Ip
    {
        public static string GetIP()
        {
            using (WebClient client = new WebClient())
            {
                try
                {
                    return client.DownloadString("https://cheatingpalace.com/checks/check_ip.php").ToString();
                }
                catch (Exception e)
                {
                    return "Your IP adress could not be resolved because " + e.Message;
                }
            }
        }
        public static bool CheckForInternetConnection()
        {
            try
            {
                ServicePointManager.Expect100Continue = true;
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                bool hasInternet = true;
                WebClient client = new WebClient();
                using (Stream data = client.OpenRead("https://google.com/"))
                {
                    using (StreamReader reader = new StreamReader(data))
                    {
                        string content = reader.ReadToEnd();
                        if (string.IsNullOrEmpty(content))
                        {
                            hasInternet = false;
                        }
                    }
                }
                return hasInternet;
            }
            catch
            {
                return false;
            }
        }
    }
}
