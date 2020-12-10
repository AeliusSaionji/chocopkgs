$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/460.79/460.79-desktop-win10-64bit-international-whql.exe'
	checksum64     = '5619b896e98dc7ec62c5f5bd8885fec0c8d259a5213e21d262d8bca903da6cc1'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/460.79/460.79-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '76ce0d9a9b6c1ba9dc6b1bbebd4978852f5a0231c592ea55ec5a301eab38dbd9'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/460.79/460.79-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '5dd20c22eddd85599b2077783183de39c34bfc23e9b86d3323b30f3336b27889'
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
