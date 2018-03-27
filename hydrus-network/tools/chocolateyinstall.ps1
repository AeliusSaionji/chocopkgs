$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = gi "$toolsDir\*x64.exe"

$packageArgs = @{
  packageName      = 'hydrus-network'
  fileType         = 'EXE'
  file             = "$filePath"
  softwareName     = 'Hydrus Network'
  silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="C:\Program Files\Hydrus Network"'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Force -ea 0 $filePath

Write-Warning "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
Write-Host "As of version 295.0, this package now installs to Program Files, and hydrus-network itself will look for your database in your home folder." -ForegroundColor red -BackgroundColor white
Write-Host "Please move the contents of your database folder c:\tools\hydrus\db\ to $env:HOMEDRIVE\Users\<user>\Hydrus" -ForegroundColor red -BackgroundColor white
Write-Warning "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"