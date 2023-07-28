using System;
using System.Net;

namespace mainLoader
{
    class Date
    {
        public static string GetDate()
        {
            using (WebClient client = new WebClient())
            {
                try
                {
                    return client.DownloadString("https://cheatingpalace.com/checks/check_date.php").ToString();
                }
                catch (Exception e)
                {
                    Environment.Exit(0);
                    return e.Message;
                }
            }
        }
    }
}
