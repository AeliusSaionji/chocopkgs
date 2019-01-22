$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = gi "$toolsDir\*x64.exe"

$packageArgs = @{
  packageName      = 'hydrus-network'
  fileType         = 'EXE'
  file             = "$filePath"
  softwareName     = 'Hydrus Network*'
  silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="C:\Program Files\Hydrus Network"'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Force -ea 0 $filePath
