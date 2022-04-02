$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
	packageName = 'qutebrowser.install'
	fileType    = 'exe'
	file32      = "$toolsdir\qutebrowser-2.5.0-win32_x32.exe"
	file64      = "$toolsdir\qutebrowser-2.5.0-amd64_x64.exe"
	silentArgs  = '/S /allusers'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file32 -Force -ea 0
Remove-Item $packageArgs.file64 -Force -ea 0
