$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/465.89/465.89-desktop-win10-64bit-international-whql.exe'
	checksum64     = '37a228ed029811d5bcf255da6faae8918bb8a4de57a4ef3e1f7360b71c151a2d'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/465.89/465.89-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '82e9bba6646156d464cb86a185b2921d927734e77316a80326519040f9dfe385'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/465.89/465.89-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '932de24eaf32552961921d9df3ae83e0077a81d4ad46f9622701853df9c1dabe'
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
