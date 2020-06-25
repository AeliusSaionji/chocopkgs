$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/451.48/451.48-desktop-win10-64bit-international-whql.exe'
	checksum64     = '5b8761161e0932db12ba0dde0d3a09dcd5ffb51c03f060beda20821cfdfdf55c'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/451.48/451.48-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '704b6d37d820cd3e8e3ffcbefc17c38c598089033e77a92472e7aba42446592e'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/451.48/451.48-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'e3933383fc119f76d9c2601d7b5da9dac401a9ac8d23ae6766e5c0cd0d824483'
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
