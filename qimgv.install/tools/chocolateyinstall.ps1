$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation   = Get-Item $toolsDir\*_x32.exe
$file64Location = Get-Item $toolsDir\*_x64.exe

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = $fileLocation
  file64        = $file64Location
  softwareName  = 'qimgv*'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file   -Force -ea 0
Remove-Item $packageArgs.file64 -Force -ea 0
