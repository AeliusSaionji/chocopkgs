$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win10-64bit-international-whql.exe'
$checksum   = '9be45db25c564b4f4f2d049046284ff25030582b312651ce2a32c76f4add0d03'
$checksum64 = 'f9c2d43319ca2c6a31245509416de15f73feb8b18ed1e58da8efb3f7e711bf53'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = 'ba71e41cb4799d3a556d0954a7742037eb6c85cd354c0ea3e485f6737dfbb146'
	$checksum64 = '4a0a63092c8308815e4d8d4a0872f0a51b8f8bcd165e6d87004589142a8fd5f1'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
