using System;
using System.Net;
using System.Threading.Tasks;
using System.Windows;

namespace mainLoader
{
    class Log
    {
        public static void SentToDb(string status, string message, string code = "", string username = "")
        {
            using (WebClient wc = new WebClient())
            {
                DateTime today = Convert.ToDateTime(Date.GetDate());
                string hwid = Hwid.getHardwareID();
                string ip = Ip.GetIP();
                string accountName = MainWindow.userName;
                if (accountName == null || accountName == "")
                {
                    accountName = username;
                }
                wc.Headers.Add("Content-Type", "dmFsaWRhdGlvbi1zZW5kaW5nLXRvLWRi");
                string encryptedStatus = CryptoGraphy.EncodeToBase64(status);
                string encryptedMessage = CryptoGraphy.EncodeToBase64(message);
                string encryptedDate = CryptoGraphy.EncodeToBase64(today.ToString());
                string encryptedHwid = CryptoGraphy.EncodeToBase64(hwid);
                string encryptedIP = CryptoGraphy.EncodeToBase64(ip);
                string encryptedCode = CryptoGraphy.EncodeToBase64(code);
                string encryptedAccountName = CryptoGraphy.EncodeToBase64(accountName);
                wc.QueryString.Add("status", encryptedStatus);
                wc.QueryString.Add("message", encryptedMessage);
                wc.QueryString.Add("date", encryptedDate);
                wc.QueryString.Add("hwid", encryptedHwid);
                wc.QueryString.Add("ip", encryptedIP);
                wc.QueryString.Add("accountName", encryptedAccountName);
                wc.QueryString.Add("code", encryptedCode);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/logging.php");
            }
        }
    }
}
