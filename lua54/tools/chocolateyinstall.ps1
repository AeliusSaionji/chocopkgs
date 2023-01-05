$packageName = 'lua54'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '5.4.2'
$url         = "http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win32_bin.zip/download"
$url64       = "http://sourceforge.net/projects/luabinaries/files/${version}/Tools%20Executables/lua-${version}_Win64_bin.zip/download"
$checksum    = 'AC6C946B7137B3664D612BCD81D74361673D8A4CFD616DF73D0C072531A663A0335AECB335AD9B12D981CA20242BF4F60F397819CD8423847419362A7FE1AA00'
$checksum64  = '3837DE05A7F04A44EC93B732CDAAE7BEC03907BD73222034B11CFF45B47185B040D3FAB18249CBBE0B52FB40DC89276E9D637375303E00ACB8DD83D68A3DC4FC'
$checksumType= 'SHA512'

Install-ChocolateyZipPackage -PackageName $packageName -Url $url -UnzipLocation $toolsDir -Url64 $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

$pathType = 'User'
If ( Test-ProcessAdminRights ) { $pathType = 'Machine' }
Install-ChocolateyPath $toolsDir $pathType
