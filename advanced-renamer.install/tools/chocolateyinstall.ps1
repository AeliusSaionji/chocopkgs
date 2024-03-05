$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName      = 'advanced-renamer.install'
  fileType         = 'EXE'
  file64           = Get-Item "$toolsDir\*x64.exe"
  softwareName     = 'Advanced Renamer*'
  silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}


Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0
