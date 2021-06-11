$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/466.77/466.77-desktop-win10-64bit-international-whql.exe'
	checksum64     = '09cc81f23aeacbea9ad1463321045d5f7959781926b83883ba1cc4b407e02e98'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/466.77/466.77-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '4de6fe3c8adbe7617f6293900e77aeb447451c552153932f1149e7809c1a0577'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/466.77/466.77-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'ab10597531cb5b4d5987c53d94eacfe5a7a2ceaa4ee854e446832d331d864bc9'
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
