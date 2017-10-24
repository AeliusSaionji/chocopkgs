$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/387.92/387.92-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/387.92/387.92-desktop-win10-64bit-international-whql.exe'
$checksum   = '3f1bde9984a447eae36d50351a90e31efb1bee46a845d3f6bceadb999211a214'
$checksum64 = 'b0c463417f04e52768fe867b8b11158abe0f803d28c5f0f8096f1e9f18adf96f'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/387.92/387.92-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/387.92/387.92-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '47965aac28938f3a76c3f1fa25b85c742961c0cf0fd5d55fb3a3e244af947ff5'
	$checksum64 = '24c26978d6e32d15757480851cfcff67855fbc255a8d217dea464175ce65f227'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
