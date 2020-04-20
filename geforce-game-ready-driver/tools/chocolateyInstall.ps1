$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/445.87/445.87-desktop-win10-64bit-international-whql.exe'
	checksum64     = '4ee449e8cfd4f2a9978a39a1e0da80f756989e4fe708faeb57ce73048fc64f75'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/445.87/445.87-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'afc67ec353d00a8f0bab776920190f47a7ce3476eeb3af974c7f7607e20a8a84'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/445.87/445.87-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'b44cf98e2108a0bf173d1fa4e4e1d6ca75a28996618d808fc298c09d2058cda9'
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
