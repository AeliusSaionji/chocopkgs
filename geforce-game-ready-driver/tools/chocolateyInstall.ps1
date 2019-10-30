$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/441.08/441.08-desktop-win10-64bit-international-whql.exe'
	checksum64     = '1591d9c2ee32261af9f57cb3ee03c2b4e2e0ac93193139b73db618cd1dbc65e1'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/441.08/441.08-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '81945043efdf3a910419824796139dd4ba8b7828eb402cd3f1d07e93bdf79b69'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/441.08/441.08-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'e5e4b56c827c7f6039831a01ace85d878281b5e79dc53617892e361a16526445'
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
