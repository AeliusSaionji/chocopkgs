$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
 
$packageArgs = @{
  packageName      = 'vcxsrv'
  fileType         = 'EXE'
  file             = gi "$toolsDir\vcxsrv.*.exe"
  file64           = gi "$toolsDir\vcxsrv-64.*.exe"
  softwareName     = 'VcXsrv'
  silentArgs       = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -force "$toolsDir\*.exe" -ea 0