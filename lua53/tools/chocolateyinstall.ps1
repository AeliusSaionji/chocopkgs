$packageName = 'lua53'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '{{PackageVersion}}'
$url         = 'http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win32_bin.zip/download'
$url64       = 'http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win64_bin.zip/download'
$checksum    = 'c3f6c0c5bde7434377e308a593fedf36587eb40786e55bd3d6378ea3a37dec9ec7fb7f5dada25e5db65d6a196a836af3de0432062614d0ea2d68d2e5b56ee183'
$checksum64  = '4bc023f48fd79f27c32f0bc1f45daf9b00743264b096cf1ca9c579d927f148d78ca1de8cc5ca08c18995ce8858b833df3ce5abd2e3c1315dde3d837bbd118465'
$checksumType= 'sha512'

Install-ChocolateyZipPackage -PackageName $packageName -Url $url -UnzipLocation $toolsDir -Url64 $url64 -Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

$pathType = 'User'

if ( ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator") ) {
	$pathType = 'Machine'
}

Install-ChocolateyPath $toolsDir $pathType
