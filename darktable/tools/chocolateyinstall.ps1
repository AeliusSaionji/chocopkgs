$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'darktable'
  fileType       = 'exe'
  file64         = gi $toolsDir\*_x64.exe
  softwareName   = 'darktable'
  silentArgs     = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0
