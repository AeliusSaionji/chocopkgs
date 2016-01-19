$packageName= 'lua53'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://sourceforge.net/projects/luabinaries/files/5.3.2/Tools%20Executables/lua-5.3.2_Win32_bin.zip/download'
$url64      = 'http://sourceforge.net/projects/luabinaries/files/5.3.2/Tools%20Executables/lua-5.3.2_Win64_bin.zip/download'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64

$pathType = 'User'

if ( ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator") ) {
	$pathType = 'Machine'
}

Install-ChocolateyPath $toolsDir $pathType
