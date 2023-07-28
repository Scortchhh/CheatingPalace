using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Windows;
using Newtonsoft.Json;
using System.Web.UI.WebControls;
using CryptSharp;

namespace mainLoader
{
    class DbHandler
    {
        public static void CheckIsValidUser(string result, string hwid)
        {
            if (result != "1") {
                //Log.SentToDb("declined", "Declined when trying to open app");
                //SelfDelete.Delete();
                MainWindow.isLoggedUser = false;
            }
            if (result == "1")
            {
                List<dynamic> list = GetUser(hwid);
                MainWindow.userName = list[0]["name"].ToString();
                MainWindow.endSub = Convert.ToDateTime(list[0]["endSub"]);
                MainWindow.hwid = list[0]["hwid"].ToString();
                MainWindow.ip = Ip.GetIP();
                MainWindow.isLoggedUser = true;
                MainWindow.isZoomHackUser = list[0]["zoomHackOnly"].ToString();
            }
        }

        public static List<dynamic> GetUser(string hwid)
        {
            List<dynamic> list;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "dXNlci1nZXQtY2hlY2s=");
                string encryptedHWID = CryptoGraphy.EncodeToBase64(hwid);
                wc.QueryString.Add("hwid", encryptedHWID);
                var json = wc.DownloadString("https://cheatingpalace.com/EndPoints/getUser.php");
                var output = JsonConvert.DeserializeObject<List<dynamic>>(json);
                list = output;
            }
            return list;
        }

        public static void GetUserData(string hwid)
        {
            if (!IsHWIDBlackListed(hwid))
            {
                using (WebClient wc = new WebClient())
                {
                    wc.Headers.Add("Content-Type", "Z2V0dGluZy11c2VyLWRhdGEtY2hlY2s=");
                    string encryptedHWID = CryptoGraphy.EncodeToBase64(hwid);
                    wc.QueryString.Add("hwid", encryptedHWID);
                    var json = wc.DownloadString("https://cheatingpalace.com/EndPoints/getUserData.php");
                    //var output = JsonConvert.DeserializeObject<List<dynamic>>(json);
                    CheckIsValidUser(json, hwid);
                }
            }
        }

        public static bool IsHWIDBlackListed(string hwid)
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "YmxhY2tsaXN0ZWQtaHdpZC1jaGVja3M=");
                string encryptedHwid = CryptoGraphy.EncodeToBase64(hwid);
                wc.QueryString.Add("hwid", encryptedHwid);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/getBlackListedByHwid.php");
                if (result == "1")
                {
                    Log.SentToDb("declined", "Declined Blacklisted hwid");
                    SelfDelete.Delete();
                    return true;
                }
            }
            return false;
        }


        public static string checkLogin(string username, string password, string gpassword)
        {
            string r;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "Y2hlY2stbG9naW4tY3JlZGVudGlhbHM=");
                string encryptedUsername = CryptoGraphy.EncodeToBase64(username);
                string encryptedPassword = CryptoGraphy.EncodeToBase64(password);
                string encryptedGPassword = CryptoGraphy.EncodeToBase64(gpassword);
                wc.QueryString.Add("username", encryptedUsername);
                wc.QueryString.Add("password", encryptedPassword);
                wc.QueryString.Add("gpassword", encryptedGPassword);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/checkLogin.php");
                r = result;
            }

            return r;
        }

        public static bool isPasswordEmpty()
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "Y2hlY2staXMtcGFzc3dvcmQtZW1wdHk=");
                string encryptedHWID = CryptoGraphy.EncodeToBase64(Hwid.getHardwareID());
                wc.QueryString.Add("hwid", encryptedHWID);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/isPasswordEmpty.php");
                if (result == "1")
                {
                    return true;
                }
            }

            return false;
        }

        public static void SetPassword(string password)
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2V0LXBhc3N3b3JkLWZpZWxk");
                string encryptedHWID = CryptoGraphy.EncodeToBase64(Hwid.getHardwareID());
                string encryptedPassword = CryptoGraphy.EncodeToBase64(password);
                wc.QueryString.Add("hwid", encryptedHWID);
                wc.QueryString.Add("password", encryptedPassword);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/setPassword.php");
            }
        }

        public static void SetHwid(string username)
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2V0LWh3aWQtZm9yLXVzZXI=");
                string encryptedHWID = CryptoGraphy.EncodeToBase64(Hwid.getHardwareID());
                string encryptedUsername = CryptoGraphy.EncodeToBase64(username);
                wc.QueryString.Add("hwid", encryptedHWID);
                wc.QueryString.Add("username", encryptedUsername);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/setHwid.php");
                if (result == "1") {
                    Log.SentToDb("hwid", "Succesfully changed HWID", "", username);
                }
            }
        }

        public static void SetLolSessions(int sessionCount)
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2V0LUxvbFBvaW50cy1DaGVja3MtaW4tcGxhY2U=");
                string encryptedHWID = CryptoGraphy.EncodeToBase64(MainWindow.hwid);
                string encryptedSession = CryptoGraphy.EncodeToBase64(sessionCount.ToString());
                wc.QueryString.Add("hwid", encryptedHWID);
                wc.QueryString.Add("session", encryptedSession);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/setLolSessions.php");
            }
        }

        public static bool setUser(string name, string password, string hwid, string ipAddr, string code)
        {
            string passwordHash = Crypter.Blowfish.Crypt(password);
            List<dynamic> list;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "Y3JlYXRpb24tb2YtdXNlci10by1kYg==");
                string encryptedName = CryptoGraphy.EncodeToBase64(name);
                wc.QueryString.Add("name", encryptedName);
                string encryptedPassword = CryptoGraphy.EncodeToBase64(passwordHash);
                wc.QueryString.Add("password", encryptedPassword);
                string encryptedHwid = CryptoGraphy.EncodeToBase64(hwid);
                wc.QueryString.Add("hwid", encryptedHwid);
                string encryptedIp = CryptoGraphy.EncodeToBase64(ipAddr);
                wc.QueryString.Add("ip", encryptedIp);
                string encryptedCode = CryptoGraphy.EncodeToBase64(code);
                wc.QueryString.Add("code", encryptedCode);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/setUser.php");
                if (result == "")
                {
                    Log.SentToDb("declined", "Declined can't set user");
                    SelfDelete.Delete();
                }
                else if (result == "1")
                {
                    Log.SentToDb("success", "Succesfully set user", code);
                    SelfDelete.Restart();
                }
            }
            return false;
        }

        public static void SetLoadFile(string filename)
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2V0LWxvYWQtZmlsZS1jaGVja3M=");
                string encryptedHWID = CryptoGraphy.EncodeToBase64(MainWindow.hwid);
                string encryptedFileName = CryptoGraphy.EncodeToBase64(filename);
                wc.QueryString.Add("hwid", encryptedHWID);
                wc.QueryString.Add("fileName", encryptedFileName);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/setLoadFile.php");
            }
        }

        public static void SetScriptRating(string scriptName, int rating)
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2V0LXNjcmlwdC1yYXRpbmc=");
                string encryptedScriptName = CryptoGraphy.EncodeToBase64(scriptName);
                string encryptedRating = CryptoGraphy.EncodeToBase64(rating.ToString());
                wc.QueryString.Add("scriptName", encryptedScriptName);
                wc.QueryString.Add("rating", encryptedRating);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/setScriptRating.php");
                MessageBox.Show("You have rated: " + scriptName + " with a: " + rating.ToString() + "/5");
            }
        }

        public static List<dynamic> GetScriptRating()
        {
            List<dynamic> list;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2NyaXB0LWdldC1yYXRpbmc=");
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/getScriptRating.php");
                list = JsonConvert.DeserializeObject<List<dynamic>>(result);
            }
            return list;
        }

        public static List<dynamic> GetScripts(string type)
        {
            List<dynamic> list;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2NyaXB0cy1nZXQtYWxsLWNoZWNrcw==");
                string encryptedType = CryptoGraphy.EncodeToBase64(type);
                wc.QueryString.Add("scriptType", encryptedType);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/getScripts.php");
                list = JsonConvert.DeserializeObject<List<dynamic>>(result);
            }
            return list;
        }

        public static List<dynamic> GetScriptsVip(string name)
        {
            List<dynamic> list;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2NyaXB0cy1nZXQtYWxsLWNoZWNrcw==");
                string encryptedName = CryptoGraphy.EncodeToBase64(name);
                wc.QueryString.Add("username", encryptedName);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/getScriptsVip.php");
                list = JsonConvert.DeserializeObject<List<dynamic>>(result);
            }
            return list;
        }

        public static List<dynamic> HasActiveVipSub(string name)
        {
            List<dynamic> list;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c2NyaXB0cy1nZXQtYWxsLWNoZWNrcw==");
                string encryptedName = CryptoGraphy.EncodeToBase64(name);
                wc.QueryString.Add("username", encryptedName);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/hasValidVipSub.php");
                list = JsonConvert.DeserializeObject<List<dynamic>>(result);
            }
            return list;
        }

        //public static List<dynamic> GetScriptRating()
        //{
        //    List<dynamic> list;
        //    using (WebClient wc = new WebClient())
        //    {
        //        wc.Headers.Add("Content-Type", "c2NyaXB0LWdldC1yYXRpbmc=");
        //        string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/getScriptRating.php");
        //        list = JsonConvert.DeserializeObject<List<dynamic>>(result);
        //    }
        //    //if (rating == null)
        //    //{
        //    //    rating = "0";
        //    //}
        //    return list;
        //}

        public static string GetFileVersion(string script, string type)
        {
            string version;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "dmVyc2lvbi1mb3Itc2NyaXB0cw==");
                string encryptedScript = CryptoGraphy.EncodeToBase64(script);
                string encryptedType = CryptoGraphy.EncodeToBase64(type);
                wc.QueryString.Add("script", encryptedScript);
                wc.QueryString.Add("type", encryptedType);
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/getScriptVersion.php");
                version = result;
            }
            return version;
        }

        public static (string, string, string) GetLolPatch()
        {
            string loaderPatch;
            string riotPatch;
            string cheatPatch;
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "bG9sUGF0Y2gtY2hlY2tzLWZvci12YWxpZGl0eQ==");
                string result = wc.DownloadString("https://cheatingpalace.com/EndPoints/getLolPatch.php");
                var list = JsonConvert.DeserializeObject<List<dynamic>>(result);
                int length = list.Count;
                loaderPatch = list[0]["loaderPatch"];
                riotPatch = list[0]["riotPatch"];
                cheatPatch = list[0]["cheatPatch"];
                return (loaderPatch, riotPatch, cheatPatch);
            }
        }

        public static bool CheckVipScriptSubActive(string script)
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c3Vic2NyaXB0aW9uLXZhbGlkLWNoZWNrcw==");
                string encryptedName = CryptoGraphy.EncodeToBase64(MainWindow.userName);
                string encryptedScript = CryptoGraphy.EncodeToBase64(script);
                wc.QueryString.Add("name", encryptedName);
                wc.QueryString.Add("scriptName", encryptedScript);
                var json = wc.DownloadString("https://cheatingpalace.com/EndPoints/isSubActiveVipScript.php");
                if (json == "1")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public static void CheckSub()
        {
            using (WebClient wc = new WebClient())
            {
                wc.Headers.Add("Content-Type", "c3Vic2NyaXB0aW9uLXZhbGlkLWNoZWNrcw==");
                string encryptedHWID = CryptoGraphy.EncodeToBase64(Hwid.getHardwareID());
                wc.QueryString.Add("hwid", encryptedHWID);
                var json = wc.DownloadString("https://cheatingpalace.com/EndPoints/getSubscriptionData.php");
                var list = JsonConvert.DeserializeObject<List<dynamic>>(json);
                int length = list.Count;
                DateTime today = Convert.ToDateTime(Date.GetDate());
                for (int i = 0; i < length; i++)
                {
                    DateTime dbendSub = list[i]["endSub"];
                    int result = DateTime.Compare(today, dbendSub);
                    if (result < 0)
                    {
                        MainWindow.lolSubValid = true;
                    }
                    else if (result == 0)
                    {
                        MainWindow.lolSubValid = true;
                    }
                    else
                    {
                        MainWindow.lolSubValid = false;
                    }
                }
            }
        }
    }
}
