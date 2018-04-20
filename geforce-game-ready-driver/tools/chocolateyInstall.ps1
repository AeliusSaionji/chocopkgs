$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url            = 'https://us.download.nvidia.com/Windows/391.35/391.35-desktop-win10-32bit-international-whql.exe'
	url64          = 'https://us.download.nvidia.com/Windows/391.35/391.35-desktop-win10-64bit-international-whql.exe'
	checksum       = '5128180228d63d550869d615d9d165eabbc1bc1ce1c5a8235466e16d4867cb4e'
	checksum64     = 'd352ad886b250482385ae1b597cf1be301e2e3378567e10feb8942fec0c964c2'
	checksumType   = 'sha256'
	silentArgs     = '/s /noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url']        = 'https://us.download.nvidia.com/Windows/391.35/391.35-desktop-win8-win7-32bit-international-whql.exe'
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/391.35/391.35-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum']   = '1687319094fbcf7bb3e45ffa713916d94ebd9c838672720558553132becd2ac3'
	$packageArgs['checksum64'] = '7dd05b645433129b86ced17fcd8d29bf98eca2f3ac4834c19f24fb1161ea9e5c'
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
