$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win10-64bit-international-whql.exe'
$checksum   = 'ff4376f57549f3761efff19c74afd246c01628a1eed0f57a84b4cdb73c8b25a5'
$checksum64 = '5675cab5a713efaaedbbd5a6d489d0ddbc06a0edb4ae5e423901180b2dd17f12'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '6d2833b5a579eef7eb77c9375acb026378093c17ecd118fd4ef28261d55a8887'
	$checksum64 = '9c5ce59b61bc45eda41223e317759fb18ad329e5e8267ca1320d2a01f742a8a8'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
