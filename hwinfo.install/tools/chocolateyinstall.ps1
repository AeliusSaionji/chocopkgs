$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = 'hwinfo.install'
  fileType     = 'EXE'
  file64         = "$toolsDir\hwi64.exe"
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
Install-BinFile -Name 'hwinfo' -Path "C:\Program Files\HWiNFO64\HWiNFO64.EXE" -UseStart
