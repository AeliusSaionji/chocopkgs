$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/442.74/442.74-desktop-win10-64bit-international-whql.exe'
	checksum64     = 'f89c94e97ca72140bad0232ecf7b7686391ea531f2ec27760ab6e11f34bfbbe5'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/442.74/442.74-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'ae4be1e1ddfd01d5884c8ab8ce5be959cea89e6b54cca64465a1902cf1a74fcc'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/442.74/442.74-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '2f66fa5ccdd372c17b5279ae5b41779d2d17b8ed5c5b5270f690812df3258980'
	$packageArgs['url64']      = $packageArgsDCHURL
	$packageArgs['checksum64'] = $packageArgsDCHChecksum
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
	Write-Warning "NVIDIA has ended support for 32bit operating systems."
	Write-Warning "32 bit users should specify version 391.35."
	Write-Warning "Security patches for 32bit may be available on geforce.com"
	Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
