$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = 'hwinfo.install'
  fileType     = 'EXE'
  file         = "$toolsDir\hwi.exe"
  file64       = "$file"
  softwareName = 'HWiNFO*'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
}

# Stop process before upgrading
if ($null -ne (Get-Process | Where-Object -Property Name -Match 'HWiNFO\d{2}')) {
  Get-Process | Where-Object -Property Name -Match 'HWiNFO\d{2}' | Stop-Process
  $ProcessRunning = $true
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Force "$toolsDir\*.exe" -ea 0
# Kill the process after it starts- there is no way to prevent autostart after install
if ($null -eq $ProcessRunning) {
  Get-Process | Where-Object -Property Name -Match 'HWiNFO\d{2}' | Stop-Process
}

# Make launchable from cmd
if (Get-OSArchitectureWidth -compare 64) { $bitness = 64 } else { $bitness = 32 }
Install-BinFile -Name 'hwinfo' -Path "C:\Program Files\HWiNFO$bitness\HWiNFO$bitness.EXE" -UseStart
