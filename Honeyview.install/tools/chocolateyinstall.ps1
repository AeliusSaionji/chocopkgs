$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\HONEYVIEW-SETUP_x32.EXE"

$packageArgs = @{
  packageName      = 'honeyview.install'
  fileType         = 'EXE'
  file             = "$filePath"
  softwareName     = 'Honeyview'
  silentArgs       = '/S'
}


Install-ChocolateyInstallPackage @packageArgs

# Kill the instance autostarted by the installer
Get-Process | Where {$_.name -eq 'Honeyview'} | Stop-Process -Force

Remove-Item -Force -ea 0 $filePath,"$filepath.ignore"
