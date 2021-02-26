$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/461.72/461.72-desktop-win10-64bit-international-whql.exe'
	checksum64     = 'd9986a4cd2f075295cacda187e036329c78f15c5c5c6ffee0c61ddef42af3356'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/461.72/461.72-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '9920926b202edc7d4ac9c98e8e24401c47d45595d99127bc6b922455808bf4ab'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/461.72/461.72-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '1c929ca81ab1e86665095ce01f7cb3e13dd288e7c7bf1ddd570d124c1501c3d4'
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
