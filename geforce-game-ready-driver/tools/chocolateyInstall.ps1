$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/382.33/382.33-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/382.33/382.33-desktop-win10-64bit-international-whql.exe'
$checksum   = 'c65b7ace46accbec9e9a1400bbc5db28bc7c2e1618a06d6322369a8b1ad20f4e'
$checksum64 = '6b499dee8813840f6c6bf41f975178711d411bf141ca766d597bcb8359a50181'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/382.33/382.33-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/382.33/382.33-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '4f09a41726ecfbdd01a31a4b49cc9a9f7baae78715c9d2898f096a10f55380f9'
	$checksum64 = '03f8cf726e092718e92182ccd883027d029c50064723159aa3e4efff41f8abff'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
