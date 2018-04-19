$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
 
$packageArgs = @{
  packageName      = 'vcxsrv'
  fileType         = 'EXE'
  file             = gi "$toolsDir\.*_x32.exe"
  file64           = gi "$toolsDir\.*_x64.exe"
  softwareName     = 'VcXsrv'
  silentArgs       = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -force "$toolsDir\*.exe" -ea 0