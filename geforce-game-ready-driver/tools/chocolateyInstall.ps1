$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/425.31/425.31-desktop-win10-64bit-international-whql.exe'
	checksum64     = '67a20f1d68cc0e9d834b8f2ecd8e1d06d56e27a8ec30ce77a9505210902dca58'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/425.31/425.31-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'aff7e6632a148345abb21caf2eeb7b9753b7f7ea275ba82cad4a28e4fee4c8b0'
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
	Write-Warning "NVIDIA has ended support for 32bit operating systems."
	Write-Warning "32 bit users should specify version 391.35."
	Write-Warning "Security patches for 32bit may be available on geforce.com"
	Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
