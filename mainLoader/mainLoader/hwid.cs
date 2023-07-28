using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Management;
using System.Windows;

namespace mainLoader
{
    class Hwid
    {
        public static string getHardwareID()
        {
            var buffer = Windows.System.Profile.SystemIdentification.GetSystemIdForPublisher();
            var id = buffer.Id;
            var asBase64 = Windows.Security.Cryptography.CryptographicBuffer.EncodeToBase64String(id);
            return asBase64.Substring(20);
        }
    }
}
