$packageName = 'lua53'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '5.3.5'
$url         = "http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win32_bin.zip/download"
$url64       = "http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win64_bin.zip/download"
$checksum    = '7EE6599DFFDB3657088A447CBDA1E70E765FCC8ABA945226BFE4ED6817F159E969325D2D1CACFB8E5BB4C6F91D1908CFD1F7E19018BEFF97E5BCF80246D54C12'
$checksum64  = 'B4417C7F38C44BF38125B74D91DD17CF282B8E5BE5B431D96076F1E89822BFA7703F2BD0773F9758B1BB668C7044D8642378F5EC4868B6A4A33E43A81A4D07F2'
$checksumType= 'SHA512'

Install-ChocolateyZipPackage -PackageName $packageName -Url $url -UnzipLocation $toolsDir -Url64 $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

$pathType = 'User'
If ( Test-ProcessAdminRights ) { $pathType = 'Machine' }
Install-ChocolateyPath $toolsDir $pathType
