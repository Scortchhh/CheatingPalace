using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace mainLoader
{
    internal class Injector
    {
        [DllImport("kernel32.dll", EntryPoint = "LoadLibrary")]
        static extern Int64 LoadLibrary([MarshalAs(UnmanagedType.LPStr)] string lpLibFileName);

        [DllImport("kernel32.dll", EntryPoint = "GetProcAddress")]
        static extern IntPtr GetProcAddress(Int64 hModule, [MarshalAs(UnmanagedType.LPStr)] string lpProcName);

        [DllImport("kernel32.dll", EntryPoint = "FreeLibrary")]
        static extern bool FreeLibrary(Int64 hModule);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        delegate bool fnTestStart();

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        [return: MarshalAs(UnmanagedType.BStr)]
        delegate string fnInjectHack([MarshalAs(UnmanagedType.LPArray)] byte[] Binary);
        public static bool LoadHack(byte[] Binary)
        {
            Assembly A = Assembly.GetExecutingAssembly();
            byte[] Data = Properties.Resources.Loader;
            string DLLName = "Loader.dll";
            string CurrentPath = Path.GetDirectoryName(A.Location);
            string TemporaryPath = CurrentPath + "\\" + DLLName;
            File.WriteAllBytes(TemporaryPath, Data);

            try
            {
                var Module = LoadLibrary(TemporaryPath);
                IntPtr InjectHackAddress = GetProcAddress(Module, "InjectHack");
                fnInjectHack InjectHack = (fnInjectHack)Marshal.GetDelegateForFunctionPointer(InjectHackAddress, typeof(fnInjectHack));

                var result = "";
                while (result != "success")
                {
                    result = InjectHack(Binary);
                }
                FreeLibrary(Module);
                File.Delete(TemporaryPath);
                return true;
            }
            catch { return false; } // Nice Errorhandling Kappa
        }
    }
}
