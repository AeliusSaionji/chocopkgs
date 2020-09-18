$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/456.38/456.38-desktop-win10-64bit-international-whql.exe'
	checksum64     = 'e0406120f7c1253214027306c67f5875df641df3b26432ed0479e5dbf255f0d1'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/456.38/456.38-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'c5b90a020ae054e7960c93db63134acd6fd9b594344a5f0f1fa55cd4ec2b58bf'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/456.38/456.38-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '6340a09e67c8c52137f7da41c1703a085814415db241c975c43e1533ead1bf52'
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
