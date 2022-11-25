$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath   = "$toolsDir\advanced_renamer_setup_x86_3_88_1.exe"
$filePath64 = "$toolsDir\advanced_renamer_setup_3_88_1.exe"

$packageArgs = @{
  packageName      = 'advanced-renamer.install'
  fileType         = 'EXE'
  file             = "$filePath"
  file64           = "$filePath64"
  softwareName     = 'Advanced Renamer*'
  silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}


Install-ChocolateyInstallPackage @packageArgs
Remove-Item $filePath,$filePath64 -Force -ea 0
