$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/452.06/452.06-desktop-win10-64bit-international-whql.exe'
	checksum64     = '4fcf2a72fa89c2ea51a492fbbdc801a2d87c9d71ab00fb8370cf2f21a993991b'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/452.06/452.06-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'cc371299cb1c6471296147cc401f082a5ed3c84f46ef9417c66d9bfd77a69b9e'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/452.06/452.06-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '51fe12486b8994b757b3ad5d3b94b8438ea33348d1e37bda9162c2f1913201ac'
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
