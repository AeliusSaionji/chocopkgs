$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/456.55/456.55-desktop-win10-64bit-international-whql.exe'
	checksum64     = '7e89635b47cf1cd7ad6d92d0271b0cd95855439fe57482faea24354830408eef'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/456.55/456.55-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '556df162757e296864c529c9420690fc96fd3f727d9800e3d73401511511dec5'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/456.55/456.55-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '7ddbc88c5babbbcf14ee662bc1ce3549ca87c76bc1c067a97da2720202da5723'
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
