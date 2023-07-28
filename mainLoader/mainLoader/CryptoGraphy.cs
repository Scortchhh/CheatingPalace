using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace mainLoader
{
    class CryptoGraphy
    {

        public static string EncryptString(string In, string Key)
        {
            while (Key.Length < In.Length)
            {
                Key += Key;
            }

            byte[] XOR_ARRAY = new byte[In.Length];
            for (int Index = 0; Index < In.Length; Index++)
            {
                XOR_ARRAY[Index] += (byte)(In[Index] ^ (Key[Index] % 9));
            }
            return Encoding.UTF8.GetString(XOR_ARRAY);
        }

        public static string EncodeToBase64(string stringToBeEncoded)
        {
            var textBytes = Encoding.UTF8.GetBytes(stringToBeEncoded);
            var asBase64 = Convert.ToBase64String(textBytes);
            return asBase64;
        }


        public static string Generate(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            byte[] randomBytes = new byte[length];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(randomBytes);
            }
            StringBuilder sb = new StringBuilder();
            foreach (byte b in randomBytes)
            {
                sb.Append(chars[b % chars.Length]);
            }
            return sb.ToString();
        }
    }
}
