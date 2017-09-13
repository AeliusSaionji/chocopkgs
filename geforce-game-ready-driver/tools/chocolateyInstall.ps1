$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/385.41/385.41-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/385.41/385.41-desktop-win10-64bit-international-whql.exe'
$checksum   = '1bff9f79ea57eaae8f52c6252c6170d5036cdfe96f4ac65c8af4ad8199245d11'
$checksum64 = '606e8d36b551a43c0a2ce4bb807959653ac7861ef6d4e813d72f448da39b93b3'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/385.41/385.41-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/385.41/385.41-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '838cc66457e547690745eef88f659bb7fbc277e2b3b61525309287709f7c93a8'
	$checksum64 = 'e0183a25299379a3e9f27834a9f1960276ce4f5e39edcb718d2e54735149e55c'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
