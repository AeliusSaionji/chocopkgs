$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/457.30/457.30-desktop-win10-64bit-international-whql.exe'
	checksum64     = '121661a39065d6c7a17534d8a87389c1532c9f49684a1e035f57f98fe7bc686c'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/457.30/457.30-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '3e597857e6111bba18c7acd62574e18ef00fdae2bffff1089b20c95cbdadf6d5'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/457.30/457.30-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '2aa80645e8f14c9f292fe522cba06748f4529d0e4a4e7dbd9f1a5772255e2fd0'
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
