$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/466.27/466.27-desktop-win10-64bit-international-whql.exe'
	checksum64     = '2b785ea73ac2179e9c99ac1f8fd147fcec307b71ffcd44b851aa7bc1f9d74227'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/466.27/466.27-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '305707c582b11d3537310e9f6bef8f958155f267045ced6a436fe08b3672e06a'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/466.27/466.27-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '9e042d76e65610649eeadfbe08faf57ed1662391d37bef045a073a042361a332'
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
