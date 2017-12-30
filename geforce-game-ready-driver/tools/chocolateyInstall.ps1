$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win10-64bit-international-whql.exe'
$checksum   = '3d8171d3d0cde71f26a0dd78d019685ca42952406fa13e5a637986ccbbd37658'
$checksum64 = '08d5ee127f4e34f14bf03776a6bf93c03cba18dd3134ca8bc72557fe09cb9d02'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '0a5b32c1d9499a8280b0efce998aca77567349a96e787a042b5bffe39d1c3288'
	$checksum64 = '1e07422ec2973b717e11bbd5860a675b0922e3ef1ef1c97fd00c6c8cd77856db'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
