$packageName = 'lua53'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '{{PackageVersion}}'
$url         = "http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win32_bin.zip/download"
$url64       = "http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win64_bin.zip/download"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage -PackageName $packageName -Url $url -UnzipLocation $toolsDir -Url64 $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

$pathType = 'User'

if ( ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator") ) {
	$pathType = 'Machine'
}

Install-ChocolateyPath $toolsDir $pathType
