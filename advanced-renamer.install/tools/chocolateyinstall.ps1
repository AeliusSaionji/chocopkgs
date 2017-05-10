$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\advanced_renamer_setup_x32.exe"

$packageArgs = @{
  packageName      = 'advanced-renamer.install'
  fileType         = 'EXE'
  file             = "$filePath"
  softwareName     = 'Advanced Renamer'
  silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}


Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 $filePath,"$filepath.ignore"
