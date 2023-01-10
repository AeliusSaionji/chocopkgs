$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file64Location = Get-Item $toolsDir\*_x64.exe

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileType     = 'EXE'
  file64       = $file64Location
  softwareName = 'sunshine'
  silentArgs   = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0

Write-Host 'Sunshine can be configured at https://localhost:47990/ by default'
Write-Host 'Be sure to read the docs https://sunshinestream.readthedocs.io/'
Write-Host 'To use controllers, choco install vigembus'
