﻿$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName      = 'hwinfo.install'
  fileType         = 'EXE'
  file             = "$toolsDir\hwi.exe"
  file64           = "$file"
  softwareName     = 'HWiNFO*'
  silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -force "$toolsDir\*.exe" -ea 0
# Kill the process after it starts- there is no way to prevent autostart after install
Get-Process | Where { $_.name -eq 'HWiNFO64' } | Stop-Process
Get-Process | Where { $_.name -eq 'HWiNFO32' } | Stop-Process
# Make launchable from cmd
if (Get-OSArchitectureWidth -compare 64) {$bitness=64} else {$bitness=32}
Install-BinFile -Name "hwinfo" -Path "C:\Program Files\HWiNFO$bitness\HWiNFO$bitness.EXE" -UseStart
