$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/442.59/442.59-desktop-win10-64bit-international-whql.exe'
	checksum64     = '623f0b35056f00f56fc3d1d453ce9fd51fbb96d79dc13ddc0e52d5916cf5dcc6'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/442.59/442.59-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '31be834571542cd3e63d874b01b3fc37d59055d02b2230e0186ecfa39427d953'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/442.59/442.59-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '9aa63a36eb6b2f10ab8e953db8894985cbec742262beb200b558b94b79d5b697'
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
