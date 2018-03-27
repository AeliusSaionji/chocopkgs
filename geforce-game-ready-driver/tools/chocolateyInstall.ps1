$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win10-64bit-international-whql.exe'
$checksum   = '5d97cf8f4910c67b62de71f546cff34d8344557b9144f6262c85ee4ba1e6242e'
$checksum64 = '6c03c8deb7724b44f71333f06e8799d033a0d658e6d9d0a8841d72a6d4d08640'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = 'eab6a65bc57dbdd63b08ec9f601121c92caed70686d7a80a411772f3b4673f51'
	$checksum64 = '50a8b696d7374d11005639daaff189f5f08de66d685b41ad1e3d7342144594ca'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
