$packageName= 'lua52'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://sourceforge.net/projects/luabinaries/files/5.2.4/Tools%20Executables/lua-5.2.4_Win32_bin.zip/download'
$url64      = 'http://sourceforge.net/projects/luabinaries/files/5.2.4/Tools%20Executables/lua-5.2.4_Win64_bin.zip/download'
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

$pathType = 'User'
If ( Test-ProcessAdminRights ) { $pathType = 'Machine' }
Install-ChocolateyPath $toolsDir $pathType
