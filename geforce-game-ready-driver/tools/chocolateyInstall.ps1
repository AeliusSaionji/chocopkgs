$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/388.13/388.13-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/388.13/388.13-desktop-win10-64bit-international-whql.exe'
$checksum   = '1e6c8b05af7047f6b2b7d571da52f1b5a723241fa8b000688c40932047954ba7'
$checksum64 = '33fb3b84a06145bcab00a2925a159800d155d7038ab52a2b09a8fff34db3de5f'
$checksumType = ''

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/388.13/388.13-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/388.13/388.13-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '73aa4c5dddc2a34d88927a1628cd65640943ed82168a1a6ce4fab9789aa3bb95'
	$checksum64 = '08162f45cf0ae2d0b9b0e83f0df3837dfa738ebc6e3750fc3006f4880691251a'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
