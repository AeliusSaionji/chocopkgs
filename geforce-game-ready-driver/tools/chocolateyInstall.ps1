$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/441.41/441.41-desktop-win10-64bit-international-whql.exe'
	checksum64     = '3f30c38f083834ae2f5867f4ca6cc7487b1b1c145305943cc81391aa02641d88'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/441.41/441.41-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'f0bae56e7e327dc59387d8b06e0a33eabba5f7a5ac0b9b190cb82b0628a898bf'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/441.41/441.41-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '89d9625378f5a97a5eb04af41f8536837de0f31930c64d4c9455e3c990708576'
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
