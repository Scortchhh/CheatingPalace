using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Forms;

namespace AutoupdaterX
{
    public partial class updater : Form
    {
        public updater()
        {
            InitializeComponent();
            Close();
        }

        private void Close()
        {
            Process[] process = Process.GetProcesses();
            foreach (Process pr in process)
            {
                if (pr.ProcessName == "mainLoader" || pr.ProcessName == "GreenLoader")
                {
                    pr.Kill();
                }
            }
            Thread.Sleep(1000);
            startDownload();
        }

        private void startDownload()
        {
            //Thread thread = new Thread(() => {
            //});
            //thread.Start();

            WebClient client = new WebClient();
            client.Headers.Add("verification", "mainloader.exe");
            //client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
            //client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted);
            label2.Text = "Downloading";
            var file = client.DownloadData(new Uri("https://cheatingpalace.com/importantFiles/downloadL.php"));
            label2.Text = "Finishing";
            File.WriteAllBytes("mainLoader.exe", file); 
            label2.Text = "Completed";
            Environment.Exit(0);
        }
        void client_DownloadProgressChanged(object sender, DownloadProgressChangedEventArgs e)
        {
            this.BeginInvoke((MethodInvoker)delegate {
                double bytesIn = double.Parse(e.BytesReceived.ToString());
                double totalBytes = double.Parse(e.TotalBytesToReceive.ToString());
                double percentage = bytesIn / totalBytes * 100;
                label1.Text = "Downloading " + e.BytesReceived + " of " + e.TotalBytesToReceive;
                progressBar1.Value = int.Parse(Math.Truncate(percentage).ToString());
            });
        }
        void client_DownloadFileCompleted(object sender, AsyncCompletedEventArgs e)
        {
            this.BeginInvoke((MethodInvoker)delegate {
                label2.Text = "Completed";
            });
        }
    }
}
