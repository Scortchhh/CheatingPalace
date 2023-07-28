using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace mainLoader
{
    class Git
    {
        //public static async Task gitAsync()
        //{
        //    var httpClient = new HttpClient();
        //    httpClient.DefaultRequestHeaders.UserAgent.Add(
        //        new ProductInfoHeaderValue("MyApplication", "1"));
        //    var repo = "markheath/azure-deploy-manage-containers";
        //    var contentsUrl = $"https://api.github.com/repos/{repo}/contents";
        //    var contentsJson = await httpClient.GetStringAsync(contentsUrl);
        //    var contents = (JArray)JsonConvert.DeserializeObject(contentsJson);
        //    foreach (var file in contents)
        //    {
        //        var fileType = (string)file["type"];
        //        if (fileType == "dir")
        //        {
        //            var directoryContentsUrl = (string)file["url"];
        //            // use this URL to list the contents of the folder
        //            Console.WriteLine($"DIR: {directoryContentsUrl}");
        //        }
        //        else if (fileType == "file")
        //        {
        //            var downloadUrl = (string)file["download_url"];
        //            // use this URL to download the contents of the file
        //            Console.WriteLine($"DOWNLOAD: {downloadUrl}");
        //        }
        //    }
        //}
    }
}
