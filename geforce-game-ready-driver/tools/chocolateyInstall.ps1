$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/457.09/457.09-desktop-win10-64bit-international-whql.exe'
	checksum64     = '1706ccb51fe397f4a9eeb4d952d7800940c4222019680c2fce97af0b1b04935a'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/457.09/457.09-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '99706644608499c6a90b28e19c3d88b369f2deab6b37f2a02ba33065665bfcb6'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/457.09/457.09-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '8c522f77d83cb20a545b2721bd28d5ccc1cc5309efc23a6c9b13d07a0980d8f1'
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
