$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win10-64bit-international-whql.exe'
$checksum   = '0fc79bc49fdd397e67fbc3fd4d6a946432de36a9ab76acdeb09e1aafe6e7c428'
$checksum64 = '1d4ea731fe49cd2070a00d645bdba4118d1f6792e67afb15fac716b3e177ca59'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '3bacac7183d74fb4be54b34be81af7d876e1af56f8a2934f438d61adbde678c9'
	$checksum64 = '51ef082e0f016c09dfa6423b6d966f80d8edf1912b27e26e2c261a4106c9627b'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
