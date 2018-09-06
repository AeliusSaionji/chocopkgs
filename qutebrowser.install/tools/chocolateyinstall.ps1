$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
	packageName = 'qutebrowser.install'
	fileType    = 'exe'
	file64      = gi $toolsDir\*_x64.exe
	silentArgs  = '/S'
}

Install-ChocolateyPackage @packageArgs
