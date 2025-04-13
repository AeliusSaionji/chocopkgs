$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
	packageName = 'qutebrowser.install'
	fileType    = 'exe'
	file64      = "$toolsdir\qutebrowser-3.5.0-amd64_x64.exe"
	silentArgs  = '/S /allusers'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0
