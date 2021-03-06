﻿$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/471.11/471.11-desktop-win10-64bit-international-whql.exe'
	checksum64     = '8511e1567a16f4910af56a9b1f748e300ab054fe23f839ea08ae430483aba5f0'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/471.11/471.11-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '3e5cff70fcc11aa76f68a1f078ce8afa53d673b2c28a4b60509228f1dbb63e9b'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/471.11/471.11-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'c81810bd968ba6efe0b1052301c242d081dfd843d91fc9e2e46cbce3fc527719'
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
Write-Host "Nvidia website is funneling users towards the DCH download of their drivers. DCH is a new driver format, Win10 users should consider using the chocolatey package parameter to install the DCH version. See this package's page on chocolatey for details."
