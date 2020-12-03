$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/457.51/457.51-desktop-win10-64bit-international-whql.exe'
	checksum64     = 'c1276fc2a14ba3c1c3cfbcdc90d74f30a3247d3287e0249fa08a7701fb185541'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/457.51/457.51-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '4750b7c66c92afc8fa2db2adb5e926460f11e4e9077370d8839fc34f33fefde6'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/457.51/457.51-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'a4f72bf58d414d326dab0469bc912afa1c806c0f8800b82a19c38de2cbed8c1a'
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
