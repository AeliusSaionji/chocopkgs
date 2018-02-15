$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/390.77/390.77-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/390.77/390.77-desktop-win10-64bit-international-whql.exe'
$checksum   = '4dd7707f069ef6749019321aa848414987b5f5194878f3c6ec0a811746d3a4a5'
$checksum64 = '0e296262e1e58ecdef5871bf8d3984e6068a2861b2b8d4c951054611c6fc22f2'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/390.77/390.77-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/390.77/390.77-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '3b4b7e20ba05868ce0074a4445d6c5bd73559ec8418f94e68be69988a75e4cf6'
	$checksum64 = '586386a16f0b922576ebcc0ca0548598ec0143fcbf858e97131e7ee96147fcb4'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
