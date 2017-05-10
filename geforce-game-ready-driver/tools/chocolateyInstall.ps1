$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win10-64bit-international-whql.exe'
$checksum   = '0d0a58e7f7bcd163a850ff54f6b5c94ecee3871225568f2da1dc911e2f71561a'
$checksum64 = 'a1bbae7aba440bce85f793528a1ce3352b4d34244d1c53606b58c30c99169c57'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '672d9f8f9c54d0accfb91a61f1a55685b23a598372ea568e0a6b75290d375e38'
	$checksum64 = '09861a636a9d1a2168bbe0aedcf4092ad1c8a10244a781dcd0560da584daad63'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
