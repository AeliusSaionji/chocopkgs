$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/461.09/461.09-desktop-win10-64bit-international-whql.exe'
	checksum64     = 'c0595bc61cc8784e9d503dbb723f40e9407cd23fee8efd3f9fc584d5bee336f1'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/461.09/461.09-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '22ce45a5b9befb1acbbfce48eb492e7fc0b0eb5fbb10e2160ecbbf6941ef73a8'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/461.09/461.09-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '5d3043ad09aa4f9f2bb7469df75b2d9c96016638dcfcd9315e5cfae0364567ff'
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
