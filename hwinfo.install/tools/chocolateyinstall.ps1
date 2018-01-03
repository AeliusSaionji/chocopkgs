$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName      = 'hwinfo.install'
  fileType         = 'EXE'
  file             = gi $toolsDir\*32.exe
  file64           = gi $toolsDir\*64.exe 
  softwareName     = 'HWiNFO'
  silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -force "$toolsDir\*.exe" -ea 0
# Kill the process after it starts- there is no way to prevent autostart after install
Get-Process | Where { $_.name -eq 'HWiNFO64' } | Stop-Process
Get-Process | Where { $_.name -eq 'HWiNFO32' } | Stop-Process
