$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/460.89/460.89-desktop-win10-64bit-international-whql.exe'
	checksum64     = '425fc9a8f15563a472dd7cfac75413d185e4a83f39ad13410a4aeac6619f107e'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/460.89/460.89-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '322f9e1bea86c51502b65b1870d894aabe0cfad7a63d94c1b2e29dd620c32a96'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/460.89/460.89-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'c05002b7cc39fbf0fc5716c9fb0c75879c8ed00fed7ba3755c7365fc036ed09d'
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
