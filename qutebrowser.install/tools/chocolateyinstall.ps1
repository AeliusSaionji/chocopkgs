$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
	packageName = 'qutebrowser.install'
	fileType    = 'exe'
	file64      = gi $toolsDir\*-amd64.exe
	silentArgs  = '/S /allusers'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0
