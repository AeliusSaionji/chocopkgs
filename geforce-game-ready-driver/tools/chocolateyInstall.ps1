$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/461.40/461.40-desktop-win10-64bit-international-whql.exe'
	checksum64     = '059c70e062a3a6a8e71d9d4aac507b06ec14bbebd319d49e8bafc570d79cd158'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/461.40/461.40-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '8f23dfba6ab0010423cc1b0850167f4d269f96acdf74a8689e24bb886d0953f8'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/461.40/461.40-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '2ebb94c42079fa9a4f0462302a2abb73b5d7c8e175c6650e1907c6539e70a3d6'
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
